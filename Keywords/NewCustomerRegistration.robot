*** Settings ***
Library           SeleniumLibrary    screenshot_root_directory=EMBED
Library           Collections
Resource          ../Resources/Locators.robot
Resource          ../Resources/Variables.robot
Resource          ../Keywords/CommonWeb.robot
Resource          ../Keywords/MyAccount/LoginOrRegistration.robot
Resource          ../Resources/Locators/MyAccount/Registration.robot

*** Variables ***
@{invalid_values}=   io.com  io@u  io
*** Keywords ***
User clicks register button
    Scroll Element Into View    ${register_button_regPage}
    Scroll And Click by JS    ${register_button_regPage}

User clicks password requirement button
    Scroll Element Into View    ${password_requirements_button_reg}
    Click Element    ${password_requirements_button_reg}

User clicks add to email button
    Scroll Element Into View  ${add_to_email_reg}
    Click Element   ${add_to_email_reg}

Check whether all elements are displayed in customer registration page
     Wait Until Element Is Visible    ${first_name_textField_reg}
     Wait Until Element Is Visible    ${last_name_textField_reg}
     Wait Until Element Is Visible    ${email_textField_reg}
     Wait Until Element Is Visible    ${retype_email_textField_reg}
     Wait Until Element Is Visible    ${password_textField_reg}
     Wait Until Element Is Visible    ${retype_password_textField_reg}
     Wait Until Element Is Visible    ${retype_password_textField_reg}
     Run Keyword And Warn On Failure  Element Text Should Be  ${first_name_placeHolder_reg}  ${first_name_placeHolderValue}
     Run Keyword And Warn On Failure  Element Text Should Be  ${last_name_placeHolder_reg}  ${last_name_placeHolderValue}
     Run Keyword And Warn On Failure  Element Text Should Be  ${email_placeHolder_reg}  ${email_placeHolderValue}
     Run Keyword And Warn On Failure  Element Text Should Be  ${retype_email_placeHolder_reg}  ${retype_email_placeHolderValue}
     Run Keyword And Warn On Failure  Element Text Should Be  ${password_placeHolder_reg}  ${password_placeHolderValue}
     Run Keyword And Warn On Failure  Element Text Should Be  ${retype_password_placeHolder_reg}  ${retype_password_placeHolderValue}
     Run Keyword And Warn On Failure  Element Text Should Be  ${password_requirement_1_reg}  ${password_requirement_1_value}
     Run Keyword And Warn On Failure  Element Text Should Be  ${password_requirement_2_reg}  ${password_requirement_2_value}
     Run Keyword And Warn On Failure  Element Text Should Be  ${password_requirement_3_reg}  ${password_requirement_3_value}
     Run Keyword And Warn On Failure  Element Text Should Be  ${password_requirement_4_reg}  ${password_requirement_4_value}
     Run Keyword And Warn On Failure  Element Text Should Be  ${password_requirement_5_reg}  ${password_requirement_5_value}
     Run Keyword And Warn On Failure  Element Text Should Be  ${password_requirement_6_reg}  ${password_requirement_6_value}
     Wait Until Element Is Visible    ${add_to_email_reg}
     #Run Keyword And Warn On Failure  Element Text Should Be  ${add_to_email}  ${add_to_emailValue}

Clear all fields on registration form
     Scroll Element Into View    ${new_customer_heading}
     Click Element   ${first_name_textField_reg}
     Press Keys    ${first_name_textField_reg}  CONTROL+A  DELETE
     Click Element   ${last_name_textField_reg}
     Press Keys    ${last_name_textField_reg}  CONTROL+A  DELETE
     Click Element   ${email_textField_reg}
     Press Keys    ${email_textField_reg}  CONTROL+A  DELETE
     Click Element   ${retype_email_textField_reg}
     Press Keys    ${retype_email_textField_reg}  CONTROL+A  DELETE
     Click Element   ${password_textField_reg}
     Press Keys    ${password_textField_reg}   CONTROL+A  DELETE
     Click Element   ${retype_password_textField_reg}
     Press Keys    ${retype_password_textField_reg}   CONTROL+A  DELETE

Check whether registration is possible with blank mandatory values
     Clear all fields on registration form
     User clicks register button
     Element Text Should Be  ${first_name_validation_reg}  ${first_name_validation_value}
     Element Text Should Be  ${last_name_validation_reg}  ${last_name_validation_value}
     Element Text Should Be  ${email_validation_reg}  ${email_validation_value}
     Element Text Should Be  ${retype_email_validation_reg}  ${retype_email_validation_value}
     Element Text Should Be  ${password_validation_reg}  ${password_validation_value}
     Element Text Should Be  ${retype_password_validation_reg}  ${retype_password_validation_value}


Check whether registration is possible with blank first name value
     Clear all fields on registration form
     Check and Input text    ${last_name_textField_reg}    ${LAST_NAME}
     Generate Timestamp Email
     Check and Input text    ${email_textField_reg}        ${guest_valid}
     Check and Input text    ${retype_email_textField_reg}  ${guest_valid}
     Check and Input text    ${password_textField_reg}  ${PASSWORD}
     Check and Input text    ${retype_password_textField_reg}  ${PASSWORD}
     NewCustomerRegistration.User clicks register button
     Element Text Should Be  ${first_name_validation_reg}  ${first_name_validation_value}

Check whether registration is possible with blank last name value
     Clear all fields on registration form
     Check and Input text    ${first_name_textField_reg}    ${FIRST_NAME}
     Generate Timestamp Email
     Check and Input text    ${email_textField_reg}        ${guest_valid}
     Check and Input text    ${retype_email_textField_reg}  ${guest_valid}
     Check and Input text    ${password_textField_reg}  ${PASSWORD}
     Check and Input text    ${retype_password_textField_reg}  ${PASSWORD}
     NewCustomerRegistration.User clicks register button
     Element Text Should Be  ${last_name_validation_reg}  ${last_name_validation_value}

Check whether registration is possible with blank email value
     Clear all fields on registration form
     Check and Input text    ${first_name_textField_reg}    ${FIRST_NAME}
     Check and Input text    ${last_name_textField_reg}    ${LAST_NAME}
     Generate Timestamp Email
     Check and Input text    ${retype_email_textField_reg}  ${guest_valid}
     Check and Input text    ${password_textField_reg}  ${PASSWORD}
     Check and Input text    ${retype_password_textField_reg}  ${PASSWORD}
     NewCustomerRegistration.User clicks register button
     Element Text Should Be  ${email_validation_reg}  ${email_validation_value}

Check whether registration is possible with blank retype email value
     Clear all fields on registration form
     Check and Input text    ${first_name_textField_reg}    ${FIRST_NAME}
     Check and Input text    ${last_name_textField_reg}    ${LAST_NAME}
     Generate Timestamp Email
     Check and Input text    ${email_textField_reg}        ${guest_valid}
     Check and Input text    ${password_textField_reg}  ${PASSWORD}
     Check and Input text    ${retype_password_textField_reg}  ${PASSWORD}
     NewCustomerRegistration.User clicks register button
     Element Text Should Be  ${retype_email_validation_reg}  ${retype_email_validation_value}

Check whether registration is possible with blank password value
     Clear all fields on registration form
     Check and Input text    ${first_name_textField_reg}    ${FIRST_NAME}
     Check and Input text    ${last_name_textField_reg}    ${LAST_NAME}
     Generate Timestamp Email
     Check and Input text    ${email_textField_reg}        ${guest_valid}
     Check and Input text    ${retype_email_textField_reg}  ${guest_valid}
     Check and Input text    ${retype_password_textField_reg}  ${PASSWORD}
     NewCustomerRegistration.User clicks register button
     Element Text Should Be  ${password_validation_reg}  ${password_validation_value}

Check whether registration is possible with blank retype password value
     Clear all fields on registration form
     Check and Input text    ${first_name_textField_reg}    ${FIRST_NAME}
     Check and Input text    ${last_name_textField_reg}    ${LAST_NAME}
     Check and Input text    ${email_textField_reg}        ${GUEST_email}
     Check and Input text    ${retype_email_textField_reg}  ${GUEST_email}
     Check and Input text    ${password_textField_reg}  ${PASSWORD}
     NewCustomerRegistration.User clicks register button
     Element Text Should Be  ${retype_password_validation_reg}  ${retype_password_validation_value}

Check whether registration is possible with invalid email value
     FOR    ${invalid_values}    IN    @{invalid_values}
     Clear all fields on registration form
     Check and Input text    ${first_name_textField_reg}    ${FIRST_NAME}
     Check and Input text    ${last_name_textField_reg}    ${LAST_NAME}
     Check and Input text    ${email_textField_reg}        ${invalid_values}
     Generate Timestamp Email
     Check and Input text    ${retype_email_textField_reg}  ${guest_valid}
     Check and Input text    ${password_textField_reg}  ${PASSWORD}
     Check and Input text    ${retype_password_textField_reg}  ${PASSWORD}
     NewCustomerRegistration.User clicks register button
     Element Text Should Be  ${email_validation_reg}  ${email_validation_value}
     END

Check whether registration is possible with invalid retype email value
     FOR    ${invalid_values}    IN   @{invalid_values}
     Clear all fields on registration form
     Check and Input text    ${first_name_textField_reg}    ${FIRST_NAME}
     Check and Input text    ${last_name_textField_reg}    ${LAST_NAME}
     Generate Timestamp Email
     Check and Input text    ${email_textField_reg}        ${guest_valid}
     Check and Input text    ${retype_email_textField_reg}  ${invalid_values}
     Check and Input text    ${password_textField_reg}  ${PASSWORD}
     Check and Input text    ${retype_password_textField_reg}  ${PASSWORD}
     NewCustomerRegistration.User clicks register button
     Element Text Should Be  ${retype_email_validation_reg}  ${retype_email_validation_value}
     END

Check whether registration is possible with already existing email value
     Clear all fields on registration form
     Check and Input text    ${first_name_textField_reg}    ${FIRST_NAME}
     Check and Input text    ${last_name_textField_reg}    ${LAST_NAME}
     Check and Input text    ${email_textField_reg}        ${GUEST_email}
     Check and Input text    ${retype_email_textField_reg}  ${GUEST_email}
     Check and Input text    ${password_textField_reg}  ${PASSWORD}
     Check and Input text    ${retype_password_textField_reg}  ${PASSWORD}
     NewCustomerRegistration.User clicks register button
     Sleep  5s
     Element Text Should Be  ${email_validation_reg}  ${already_existing_user_validation}

Check whether registration is possible with email mismatch
     Clear all fields on registration form
     Check and Input text    ${first_name_textField_reg}    ${FIRST_NAME}
     Check and Input text    ${last_name_textField_reg}    ${LAST_NAME}
     Generate Timestamp Email
     Check and Input text    ${email_textField_reg}        john@doe.com
     Check and Input text    ${retype_email_textField_reg}  john.rt@doe.com
     Check and Input text    ${password_textField_reg}  ${PASSWORD}
     Check and Input text    ${retype_password_textField_reg}  ${PASSWORD}
     NewCustomerRegistration.User clicks register button
     Sleep  5s
     Element Text Should Be  ${retype_email_validation_reg}  ${email_mismatch_validation}

Check whether registration is possible with password requirement not satisfied - minimum length
     Clear all fields on registration form
     Check and Input text    ${first_name_textField_reg}    ${FIRST_NAME}
     Check and Input text    ${last_name_textField_reg}    ${LAST_NAME}
     Generate Timestamp Email
     Check and Input text    ${email_textField_reg}        ${guest_valid}
     Check and Input text    ${retype_email_textField_reg}  ${guest_valid}
     Check and Input text    ${password_textField_reg}  123
     Check and Input text    ${retype_password_textField_reg}  123
     NewCustomerRegistration.User clicks register button
     Sleep  5s
     Element Should Be Visible  ${minimum_length_requirement_unchecked}

Check whether registration is possible with password requirement not satisfied - capital and lower case
     Clear all fields on registration form
     Check and Input text    ${first_name_textField_reg}    ${FIRST_NAME}
     Check and Input text    ${last_name_textField_reg}    ${LAST_NAME}
     Generate Timestamp Email
     Check and Input text    ${email_textField_reg}        ${guest_valid}
     Check and Input text    ${retype_email_textField_reg}  ${guest_valid}
     Check and Input text    ${password_textField_reg}  123456
     Check and Input text    ${retype_password_textField_reg}  123456
     Sleep  1s
     Element Should Be Visible  ${capital_lowercase_requirement_unchecked}

Check whether registration is possible with password requirement not satisfied - one number
     Clear all fields on registration form
     Check and Input text    ${first_name_textField_reg}    ${FIRST_NAME}
     Check and Input text    ${last_name_textField_reg}    ${LAST_NAME}
     Generate Timestamp Email
     Check and Input text    ${email_textField_reg}        ${guest_valid}
     Check and Input text    ${retype_email_textField_reg}  ${guest_valid}
     Check and Input text    ${password_textField_reg}  abcdefgh
     Check and Input text    ${retype_password_textField_reg}  abcdefgh
     Sleep  1s
     Element Should Be Visible  ${one_number_requirement_unchecked}

Check whether registration is possible with password requirement not satisfied - no space
     Clear all fields on registration form
     Check and Input text    ${first_name_textField_reg}    ${FIRST_NAME}
     Check and Input text    ${last_name_textField_reg}    ${LAST_NAME}
     Generate Timestamp Email
     Check and Input text    ${email_textField_reg}        ${guest_valid}
     Check and Input text    ${retype_email_textField_reg}  ${guest_valid}
     Check and Input text    ${password_textField_reg}  abcd efgh
     Check and Input text    ${retype_password_textField_reg}  abcd efgh
     Sleep  1s
     Element Should Be Visible  ${no_spaces_requirement_unchecked}

Check whether registration is possible with password requirement not satisfied - no special character
     Clear all fields on registration form
     Check and Input text    ${first_name_textField_reg}    ${FIRST_NAME}
     Check and Input text    ${last_name_textField_reg}    ${LAST_NAME}
     Generate Timestamp Email
     Check and Input text    ${email_textField_reg}        ${guest_valid}
     Check and Input text    ${retype_email_textField_reg}  ${guest_valid}
     Check and Input text    ${password_textField_reg}  abcdefgh
     Check and Input text    ${retype_password_textField_reg}  abcdefgh
     Sleep  1s
     Element Should Be Visible  ${special_character_requirement_unchecked}

Check whether registration is possible with valid details and signup
     Clear all fields on registration form
     Check and Input text    ${first_name_textField_reg}    ${FIRST_NAME}
     Check and Input text    ${last_name_textField_reg}    ${LAST_NAME}
     Generate Timestamp Email
     Check and Input text    ${email_textField_reg}        ${guest_valid}
     Check and Input text    ${retype_email_textField_reg}  ${guest_valid}
     Check and Input text    ${password_textField_reg}  P@ssword00
     Check and Input text    ${retype_password_textField_reg}  P@ssword00
     Sleep  2s
     Element Should Be Visible  ${minimum_length_requirement_checked}
     Element Should Be Visible  ${capital_lowercase_requirement_checked}
     Element Should Be Visible  ${no_spaces_requirement_checked}
     Element Should Be Visible  ${no_email_requirement_checked}
     Element Should Be Visible  ${one_number_requirement_checked}
     Element Should Be Visible  ${special_character_requirement_checked}
     Click Element    xpath://label[@for='add-to-email-list']
     NewCustomerRegistration.User clicks register button
     Element Should Be Visible  ${my_account_title}

Check whether registration is possible with valid details
     Clear all fields on registration form
     Check and Input text    ${first_name_textField_reg}    ${FIRST_NAME}
     Check and Input text    ${last_name_textField_reg}    ${LAST_NAME}
     Generate Timestamp Email
     Check and Input text    ${email_textField_reg}        ${guest_valid}
     Check and Input text    ${retype_email_textField_reg}  ${guest_valid}
     Check and Input text    ${password_textField_reg}  P@ssword00
     Check and Input text    ${retype_password_textField_reg}  P@ssword00
     Sleep  2s
     Element Should Be Visible  ${minimum_length_requirement_checked}
     Element Should Be Visible  ${capital_lowercase_requirement_checked}
     Element Should Be Visible  ${no_spaces_requirement_checked}
     Element Should Be Visible  ${no_email_requirement_checked}
     Element Should Be Visible  ${one_number_requirement_checked}
     Element Should Be Visible  ${special_character_requirement_checked}
     NewCustomerRegistration.User clicks register button
     Element Should Be Visible  ${my_account_title}

Check whether all elements are dislpayed in registration page
      Run Keyword And Warn On Failure  Element Should Be Visible  ${first_name_textField_reg}
      ${first_name_label}  Get Text    xpath://label[@for='registration-form-fname']
      Run Keyword And Warn On Failure  Should Contain Text      ${first_name_label}    First Name
      Run Keyword And Warn On Failure  Element Should Be Visible  ${last_name_textField_reg}
      ${last_name_label}  Get Text    xpath://label[@for='registration-form-lname']
      Run Keyword And Warn On Failure  Should Contain Text      ${last_name_label}   Last Name
      Run Keyword And Warn On Failure  Element Should Be Visible  ${email_textField_reg}
      ${email_label}  Get Text    xpath://label[@for='registration-form-email']
      Run Keyword And Warn On Failure  Should Contain Text     ${email_label}    Email
      Run Keyword And Warn On Failure  Element Should Be Visible  ${retype_email_textField_reg}
      ${retype_email_label}  Get Text     xpath://label[@for='registration-form-email-confirm']
      Run Keyword And Warn On Failure  Should Contain Text     ${retype_email_label}    Retype Email Address
      Run Keyword And Warn On Failure  Element Should Be Visible  ${password_textField_reg}
      ${password_label}  Get Text     xpath://label[@for='registration-form-password']
      Run Keyword And Warn On Failure  Should Contain Text     ${password_label}    Password
      Run Keyword And Warn On Failure  Element Should Be Visible  ${retype_password_textField_reg}
      ${retype_password_label}  Get Text     xpath://label[@for='registration-form-password-confirm']
      Run Keyword And Warn On Failure  Should Contain Text     ${retype_password_label}     Retype Password

Check privary policy link in registration page
   Scroll Element Into View    xpath://a[text()='Privacy Policy'][1]
   Click Element    xpath://a[text()='Privacy Policy'][1]
   @{window_handles}=    Get Window Handles
   Switch Window    ${window_handles}[1]
   Location Should Be    https://www.davidyurman.com/assistance/online-privacy-notice.html
   Close Window
   Switch Window    ${window_handles}[0]
