*** Settings ***
Library           SeleniumLibrary    screenshot_root_directory=EMBED
Resource          ../../Resources/Locators/MyAccount/LoginOrRegistration.robot
Resource          ../../Resources/Locators/MyAccount/MyAccount.robot
Resource          ../../Resources/Locators/MyAccount/ForgotPassword.robot
Resource          ../CommonWeb.robot

*** Keywords ***
#Check whether all elements are dislpayed in login section
#     Wait Until Element Is Visible    ${account_registration_header}
#     Wait Until Element Is Visible    ${registered_customer_subHeading}
#     Wait Until Element Is Visible    ${registered_customer_subHeading}
#     Run Keyword And Warn On Failure  Element Text Should Be  ${registered_customer_messageElement}  ${registered_customer_messageText}
#     Wait Until Element Is Visible    ${login_form_email_textField}
#     Run Keyword And Warn On Failure  Element Text Should Be  ${login_form_email_placeHolderElement}  ${login_email_placeHolder_value}
#     Wait Until Element Is Visible    ${login_form_password_textField}
#     Run Keyword And Warn On Failure  Element Text Should Be  ${login_form_password_placeHolderElement}  ${login_password_placeHolder_value}
#     Wait Until Element Is Visible    ${login_email_toolTip}
#     Wait Until Element Is Visible    ${forgot_password_link}
#     Run Keyword And Warn On Failure  Element Text Should Be  ${login_button}  ${login_button_text}
#

Check whether all elements are dislpayed in register section
     Wait Until Element Is Visible      ${registered_customer_subHeading}
     Run Keyword And Warn On Failure    Element Text Should Be    ${faster_check_out}    ${faster_check_out_message}
     Run Keyword And Warn On Failure    Element Text Should Be    ${access_order}    ${access_order_message}
     Run Keyword And Warn On Failure    Element Text Should Be    ${view_online}    ${view_online_message}
     Run Keyword And Warn On Failure    Element Text Should Be    ${add_items}    ${add_items_message}
     Wait Until Element Is Visible      ${register_button}
#
#Check validation messages for blank email Id and blank password login
#     Click Element  ${login_form_email_textField}
#     Click Element  ${login_form_password_textField}
#     Click Element  ${login_button}
#     Wait Until Element Is Visible    ${login_form_email_error}
#     Wait Until Element Is Visible    ${login_form_password_error}
#     Run Keyword And Warn On Failure  Element Text Should Be  ${login_form_email_error}  ${blank_email_error}
#     Run Keyword And Warn On Failure  Element Text Should Be  ${login_form_password_error}  ${blank_password_error}
#
#Check validation messages for valid email Id and blank password login
#     Check and Input text    ${login_form_email_textField}  ${REGISTERED_email}
#     Click Element  ${login_form_password_textField}
#     Click Element  ${login_button}
#     Run Keyword And Continue On Failure   Wait Until Element Is Not Visible  ${login_form_email_error}
#     Run Keyword And Continue On Failure   Wait Until Element Is Visible    ${login_form_password_error}
#     Run Keyword And Continue On Failure   Element Text Should Be  ${login_form_password_error}  ${blank_password_error}
#
#Check validation messages for blank email Id and valid password login
#     Click Element  ${login_form_email_textField}
#     Press Key  ${login_form_email_textField}  CONTROL+A DELETE
#     Click Element  ${login_form_password_textField}
#     Check and Input text    ${login_form_password_textField}  ${REGISTERED_pwd}
#     Click Element  ${login_button}
#     Run Keyword And Continue On Failure  Wait Until Element Is Not Visible    ${login_form_password_error}
#     Run Keyword And Continue On Failure  Wait Until Element Is Visible    ${login_form_email_error}
#     Run Keyword And Continue On Failure  Element Text Should Be  ${login_form_email_error}  ${blank_email_error}
#
#Check user logs in with valid username and password
#     Click Element  ${login_form_email_textField}
#     Press Key    ${login_form_email_textField}    CONTROL+A DELETE
#     Check and Input text    ${login_form_email_textField}    ${REGISTERED_email}
#     Click Element  ${login_form_password_textField}
#     Press Key    ${login_form_password_textField}   CONTROL+A DELETE
#     Check and Input text    ${login_form_password_textField}   ${REGISTERED_pwd}
#     Click Element  ${login_button}
#     Wait Until Element Is Visible    ${my_account_title}    5s    error=my account page title is not seen
#

Check user navigates to registration page on clicking register button
     Click Element  ${register_button}
     Wait Until Element Is Visible    ${new_customer_heading}    5s    error=new customer page title is not seen

#Check forgot password modal slides up of clicking forgot password link
#     Click Element  ${forgot_password_link}
#     Run Keyword And Continue On Failure  Element Text Should Be  ${forgot_password_modal}  ${forgot_password_modal_title}
#
#
#Click register button on accounts page
#     Click Element    ${register_button}
#
#
#Click on Login
#    Click Element    ${login_button}
#    Wait Until Element Is Visible     ${account_container}      30      Account Page is not Loaded
#
#
#Fill in Login Form
#    [Arguments]    ${username}    ${password}
#    Input Text    ${login_username_field}    ${username}
#    Input Text    ${login_password_field}    ${password}
#
#
#Check Created User fields
#    [Arguments]     ${firstname}    ${lastname}     ${email}
#    ${logged_user_firstname_text}=    Get Element Attribute    ${logged_user_firstname_field}   value
#    ${logged_user_lastname_text}=     Get Element Attribute    ${logged_user_lastname_field}    value
#
#    Run Keyword and Warn on Failure     Should Be Equal As Strings          ${logged_user_firstname_text}             ${firstname}
#    Run Keyword and Warn on Failure     Should Be Equal As Strings          ${logged_user_lastname_text}              ${lastname}
#    Check Email in Account Page         ${email}
#
#
#Check Email in Account Page
#    [Arguments]     ${email}
#    ${logged_user_email_text}=        Get Text    ${logged_user_email_field}
#    Run Keyword and Warn on Failure     Should Contain                      ${logged_user_email_text}                 ${email}
#
#
#Check Empty Fields Message on Create Account Form
#    ${register_dict_err}=   Create Dictionary
#    ...    ${register_firstname_err}            ${register_empty_first_name_err}
#    ...    ${register_lastname_err}             ${register_empty_last_name_err}
#    ...    ${register_email_err}                ${register_invalid_email_err}
#    ...    ${register_confirm_email_err}        ${register_invalid_email_err}
#    ...    ${register_password_err}             ${register_empty_pwd_err}
#    ...    ${register_confirm_password_err}     ${register_empty_pwd_err}
#
#    FOR    ${key}    IN    @{register_dict_err.keys()}
#        ${expectedErr}=    Get From Dictionary    ${register_dict_err}    ${key}
#        Check error message    ${key}    ${expectedErr}
#    END
#
#
#Check Email Address Error on Create Account Form
#    Fill Full Name
#    Fill Password Fields
#    Check Field Error      ${register_email_field}            ${invalid_email}    ${register_email_err}              ${register_invalid_email_err}       Error checking: Invalid email address
#    Check Field Error      ${register_confirm_email_field}    ${invalid_email}    ${register_confirm_email_err}      ${register_invalid_email_err}       Error checking: Invalid confirm email address
#    Check Email Address Mismatch
#    Clear all fields
#
#
#Clear all fields
#    Clear a field    ${register_firstname_field}
#    Clear a field    ${register_lastname_field}
#    Clear a field    ${register_email_field}
#    Clear a field    ${register_confirm_email_field}
#    Clear a field    ${register_password_field}
#    Clear a field    ${register_confirm_password_field}
#
#
#Check Password Error on Create Account Form
#    Fill Full Name
#    Fill Email fields
#    Check Field Error    ${register_password_field}            ${short_password}        ${register_password_err}              ${register_missing_char_pwd_err}      Error checking: Missing characters password
#    Check Field Error    ${register_confirm_password_field}    ${short_password}        ${register_confirm_password_err}      ${register_missing_char_pwd_err}      Error checking: Missing characters confirm password
#    Check Field Error    ${register_password_field}            ${invalid_password}      ${register_password_err}              ${register_invalid_pwd_err}           Error checking: Invalid password
#    Check Field Error    ${register_confirm_password_field}    ${invalid_password}      ${register_confirm_password_err}      ${register_invalid_pwd_err}           Error checking: Invalid confirm password
#    Check Password Address Mismatch
#    Clear all fields
#
#
#
#Check Password Address Mismatch
#    Fill Password fields         ${valid_password}                      ${valid_password}1
#    Click on Register Button
#    Check error message          ${register_confirm_password_err}       ${register_not_match_pwd_err}     Error checking: Mismatch password
#
#
#Fill Password Fields
#    [Arguments]     ${password}=${valid_password}           ${confirm_password}=${valid_password}
#    Input Text      ${register_password_field}              ${password}
#    Input Text      ${register_confirm_password_field}      ${confirm_password}
#
#
#Fill Full Name
#    [Arguments]     ${firstname}=${FIRST_NAME}    ${lastname}=${LAST_NAME}
#    Input Text      ${register_firstname_field}             ${firstname}
#    Input Text      ${register_lastname_field}              ${lastname}
#
#
#Check error message
#    [Arguments]     ${error_locator}    ${expected_error_message}   ${warn}=Warning
#    ${error_visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${error_locator}
#    IF    ${error_visible}
#        ${errorMessage}    CommonWeb.Check and Get text    ${error_locator}
#        Run Keyword And Warn On Failure    Should Be Equal As Strings    ${errorMessage}    ${expected_error_message}   ${warn}
#    END
#
#
#
