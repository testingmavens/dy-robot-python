*** Settings ***
Library           SeleniumLibrary    screenshot_root_directory=EMBED
Resource          ../Resources/Locators.robot
Resource          ../Resources/Variables.robot
Resource          ../Keywords/CommonWeb.robot

*** Keywords ***
Click on Sign In
    Click Element    ${sign_in_icon}
    Wait Until Element Is Visible    ${login_heading}           30      Login Page is not Loaded


Click on Register User
    Click Element    ${register_login_button}
    Wait Until Element Is Visible    ${register_box}           30       Register Pager is not Loaded


Click on Register
    Click on Register Button
    Wait Until Element Is Visible     ${account_container}      30       Account Page is not Loaded


Click on Login
    Click Element    ${login_button}
    Wait Until Element Is Visible     ${account_container}      30      Account Page is not Loaded


Fill in Login Form
    [Arguments]    ${username}    ${password}
    Input Text    ${login_username_field}    ${username}
    Input Text    ${login_password_field}    ${password}


Fill in Register Form
    [Arguments]     ${firstname}    ${lastname}     ${email}    ${password}
    Fill Full Name              ${firstname}    ${lastname}
    Fill Email fields           ${email}        ${email}
    Fill Password Fields        ${password}     ${password}


Click on Register Button
    Scroll Element Into View    ${register_create_account_button}
    Click Element       ${register_create_account_button}


Check Created User fields
    [Arguments]     ${firstname}    ${lastname}     ${email}
    ${logged_user_firstname_text}=    Get Element Attribute    ${logged_user_firstname_field}   value
    ${logged_user_lastname_text}=     Get Element Attribute    ${logged_user_lastname_field}    value

    Run Keyword and Warn on Failure     Should Be Equal As Strings          ${logged_user_firstname_text}             ${firstname}
    Run Keyword and Warn on Failure     Should Be Equal As Strings          ${logged_user_lastname_text}              ${lastname}
    Check Email in Account Page         ${email}


Check Email in Account Page
    [Arguments]     ${email}
    ${logged_user_email_text}=        Get Text    ${logged_user_email_field}
    Run Keyword and Warn on Failure     Should Contain                      ${logged_user_email_text}                 ${email}


Check Email Address Error on Create Account Form
    Fill Full Name
    Fill Password Fields
    Check Field Error      ${register_email_field}            ${invalid_email}    ${register_email_err}              ${register_invalid_email_err}       Error checking: Invalid email address
    Check Field Error      ${register_confirm_email_field}    ${invalid_email}    ${register_confirm_email_err}      ${register_invalid_email_err}       Error checking: Invalid confirm email address
    Check Email Address Mismatch
    Clear all fields


Clear all fields
    Clear a field    ${register_firstname_field}
    Clear a field    ${register_lastname_field}
    Clear a field    ${register_email_field}
    Clear a field    ${register_confirm_email_field}
    Clear a field    ${register_password_field}
    Clear a field    ${register_confirm_password_field}


Check Password Error on Create Account Form
    Fill Full Name
    Fill Email fields
    Check Field Error    ${register_password_field}            ${short_password}        ${register_password_err}              ${register_missing_char_pwd_err}      Error checking: Missing characters password
    Check Field Error    ${register_confirm_password_field}    ${short_password}        ${register_confirm_password_err}      ${register_missing_char_pwd_err}      Error checking: Missing characters confirm password
    Check Field Error    ${register_password_field}            ${invalid_password}      ${register_password_err}              ${register_invalid_pwd_err}           Error checking: Invalid password
    Check Field Error    ${register_confirm_password_field}    ${invalid_password}      ${register_confirm_password_err}      ${register_invalid_pwd_err}           Error checking: Invalid confirm password
    Check Password Address Mismatch
    Clear all fields


Check Email Address Mismatch
    Fill Email fields       ${GUEST_email}      ${REGISTERED_email}
    Click on Register Button
    Check error message          ${register_confirm_email_err}    ${register_mismatch_emails_err}     Error checking: Mismatch emails


Check Password Address Mismatch
    Fill Password fields         ${valid_password}                      ${valid_password}1
    Click on Register Button
    Check error message          ${register_confirm_password_err}       ${register_not_match_pwd_err}     Error checking: Mismatch password


Fill Password Fields
    [Arguments]     ${password}=${valid_password}           ${confirm_password}=${valid_password}
    Input Text      ${register_password_field}              ${password}
    Input Text      ${register_confirm_password_field}      ${confirm_password}


Fill Full Name
    [Arguments]     ${firstname}=${FIRST_NAME}    ${lastname}=${LAST_NAME}
    Input Text      ${register_firstname_field}             ${firstname}
    Input Text      ${register_lastname_field}              ${lastname}


Check error message
    [Arguments]     ${error_locator}    ${expected_error_message}   ${warn}=Warning
    ${error_visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${error_locator}
    IF    ${error_visible}
        ${errorMessage}    CommonWeb.Check and Get text    ${error_locator}
        Run Keyword And Warn On Failure    Should Be Equal As Strings    ${errorMessage}    ${expected_error_message}   ${warn}
    END


Check Field Error
    [Arguments]     ${email_field}      ${email_txt}    ${error_field}      ${expected_err}     ${warn}
    Input Text      ${email_field}      ${email_txt}
    Click on Register Button
    Check error message     ${error_field}        ${expected_err}     ${warn}


Fill Email fields
    [Arguments]     ${email}=${GUEST_email}    ${confirm_email}=${GUEST_email}
    Input Text      ${register_email_field}                 ${email}
    Input Text      ${register_confirm_email_field}         ${confirm_email}

Logout
    Mouse Over                          ${header_icon_account}
    Wait until Element Is Visible       ${logout_link}    30    Logout button is not displayed
    Click Element                       ${logout_link}

Click on Login button
    Click Element    ${login_button}