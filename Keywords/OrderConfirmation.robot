*** Settings ***
Library           SeleniumLibrary    screenshot_root_directory=EMBED
Resource          ../Resources/Locators.robot
Resource          ../Resources/Variables.robot
Resource          ../Resources/Errors.robot
Resource          ../Keywords/CommonWeb.robot


*** Keywords ***
Order Confirmation page is displayed
    Wait Until Page Contains Element    ${OrderConfirmation_Page}    50s    User is not redirected on Confirmation page after validated Checkout
    #Order Number
    Wait Until Page Contains Element    ${confirm_order_number}    10s    Order Number seems not displayed in OrderConfirmation page
    Scroll To Element    ${confirm_order_number}
    ${order}=    Check and Get text    ${confirm_order_number}
    Set Test Variable    ${order}   ${order}
    Set Test Message    || Order number: ${order}||    append=yes

    Run Keyword And Warn On Failure     Wait Until Element Is Visible    ${confirm_email}                   10s     Confirmation order Email is not displayed
    Run Keyword And Warn On Failure     Wait Until Element Is Visible    ${confirm_shipping}                10s     Confirmation order Shiping not displayed
    Run Keyword And Warn On Failure     Wait Until Element Is Visible    ${confirm_first_name}              10s     Confirmation order Full Name not displayed
    Run Keyword And Warn On Failure     Wait Until Element Is Visible    ${confirm_last_name}               10s     Confirmation order Full Name not displayed
    Run Keyword And Warn On Failure     Wait Until Element Is Visible    ${confirm_address1}                10s     Confirmation order Address1 not displayed
    Run Keyword And Warn On Failure     Wait Until Element Is Visible    ${confirm_postal}                  10s     Confirmation order Postal not displayed
    Run Keyword And Warn On Failure     Wait Until Element Is Visible    ${confirm_phone}                   10s     Confirmation order Phone not displayed
    Run Keyword And Warn On Failure     Wait Until Element Is Visible    ${confirm_order_total_top}         10s     Confirmation order Total not displayed

    ${populatedAddress2}=   Run Keyword And Return Status    Element Should Contain    ${confirm_address2}     ${ADDRESS2}    timeout=3s
    Run Keyword If    ${populatedAddress2}    Wait Until Element Is Visible    ${confirm_address2}    10s   Confirmation order Address2 not displayed

Verify that Create an Account section is displayed for Guest Order Confirmation page
    Run Keyword And Continue On Failure    Element Should Be Visible    ${oc_create_acc_title_l}
    Run Keyword And Continue On Failure    Element Should Be Visible    ${oc_create_acc_pwd_l}
    Run Keyword And Continue On Failure    Element Should Be Visible    ${oc_create_acc_submit_l}

Verify that Create an Account section is NOT displayed for Registered Order Confirmation page
    Run Keyword And Continue On Failure    Element Should Not Be Visible    ${oc_create_acc_title_l}
    Run Keyword And Continue On Failure    Element Should Not  Visible    ${oc_create_acc_pwd_l}
    Run Keyword And Continue On Failure    Element Should Not Visible    ${oc_create_acc_submit_l}

Check the empty validation messages for Create Account form within Order Confirmation page
    Click Create Account button from Order Confirmation page
    ${create_acc_err}    Check and Get text    ${create_acc_err_l}
    Run Keyword And Continue On Failure    Element Text Should Be    ${create_acc_err_l}    ${oc_create_acc_expected_err}

Click on Password field and check that password validation messages are in place
    Click Element    ${oc_create_acc_pwd_l}
    Run Keyword And Warn On Failure    Element Text Should Be    ${oc_six_chars_l}    ${oc_six_char_err}
    Run Keyword And Warn On Failure    Element Text Should Be    ${oc_capital_lowercase_l}    ${oc_capital_lowercase_err}
    Run Keyword And Warn On Failure    Element Text Should Be    ${oc_one_number_l}    ${oc_capital_one_number_err}
    Run Keyword And Warn On Failure    Element Text Should Be    ${oc_no_space_l}    ${oc_capital_no_spaces_err}
    Run Keyword And Warn On Failure    Element Text Should Be    ${oc_special_char_l}    ${oc_capital_special_char_err}

Click Create Account button from Order Confirmation page
    Scroll Element Into View    ${oc_create_acc_submit_l}
    Click Element    ${oc_create_acc_submit_l}

Check the validation messages for invalid emails on Create an Account form within Order Confirmation step
    [Arguments]    ${expectedErr}    @{lista}
    FOR    ${value}    IN    @{lista}
        Press Keys    ${oc_create_acc_pwd_l}    CONTROL+A DELETE
        CommonWeb.Check and Input text    ${oc_create_acc_pwd_l}    ${value}
        Click Create Account button from Order Confirmation page
        ${err_visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${create_acc_err_l}    5s     Create Account Error message is not visible
        IF    ${err_visible}
            ${errorMessage}    CommonWeb.Check and Get text    ${create_acc_err_l}
            Run Keyword And Warn On Failure    Should Be Equal As Strings    ${errorMessage}    ${expectedErr}
        END
    END

Create an account from Order Confirmation page
    Press Keys    ${oc_create_acc_pwd_l}    CONTROL+A DELETE
    CommonWeb.Check and Input text    ${oc_create_acc_pwd_l}    ${valid_password}
    Click Create Account button from Order Confirmation page
    Wait Until Location Contains    /account?registration=submitted    30s

Check that the account was created for correct guest email
    Run Keyword And Warn On Failure    Wait Until Element Is Visible    ${my_acc_email_lbl_l}    5s     My Account Email label is not visible
    Run Keyword And Warn On Failure    Element Should Contain   ${my_acc_email_elm_l}    ${guest_valid}

Go to Order History from My Account
    Scroll Element Into View    ${my_acc_order_history_l}
    Click Element    ${my_acc_order_history_l}

Check that the last order id is present in Order History for the newly created account
    Run Keyword And Warn On Failure    Element Should Be Visible    css:#orderCard-${order}
    Scroll Element Into View    css:#orderCard-${order} span:first-child span:first-child
    Run Keyword And Warn On Failure    CommonWeb.Check and Click    css:#orderCard-${order} span:first-child span:first-child


Order Confirmation Pickup Store page is displayed
    Run Keyword And Warn On Failure     Wait Until Page Contains Element    ${bopis_title}    10s    Missing "Pick Up In Store" title
    Run Keyword And Warn On Failure     Scroll To Element    ${bopis_shipping_title}
    
    Run Keyword And Warn On Failure     Wait Until Element Is Visible    ${confirm_email}                   10s     Confirmation order Email is not displayed
    Run Keyword And Warn On Failure     Wait Until Element Is Visible    ${bopis_store_name}                    10s     Confirmation order BOPIS: Store Name not displayed
    Run Keyword And Warn On Failure     Wait Until Element Is Visible    ${bopis_store_address1}                10s     Confirmation order BOPIS: Store Address not displayed
    Run Keyword And Warn On Failure     Wait Until Element Is Visible    ${bopis_store_phone}                   10s     Confirmation order BOPIS: Store Phone not displayed

Order Confirmation Billing Information page is displayed
    Run Keyword And Warn On Failure     Wait Until Element Is Visible    ${billing_address_checkout}                    10s     Confirmation order BOPIS: Store Name not displayed
    Run Keyword And Warn On Failure     Wait Until Element Is Visible    ${billing_payment_method_checkout}                10s     Confirmation order BOPIS: Store Address not displayed

Order Confirmation page is displayed for EU
    Wait Until Page Contains Element    xpath://h2[@id='conf-header']    50s    User is not redirected on Confirmation page after validated Checkout
    #Order Number
    Wait Until Page Contains Element    css:#orderRefNum    10s    Order Number seems not displayed in OrderConfirmation page
    Scroll To Element    css:#orderRefNum
    ${order}=    Check and Get text    css:#orderRefNum
    Set Test Variable    ${order}   ${order}
    Set Test Message    || Order number: ${order}||    append=yes

#    Run Keyword And Warn On Failure     Wait Until Element Is Visible    ${confirm_email}                   10s     Confirmation order Email is not displayed
#    Run Keyword And Warn On Failure     Wait Until Element Is Visible    ${confirm_shipping}                10s     Confirmation order Shiping not displayed
#    Run Keyword And Warn On Failure     Wait Until Element Is Visible    ${confirm_first_name}              10s     Confirmation order Full Name not displayed
#    Run Keyword And Warn On Failure     Wait Until Element Is Visible    ${confirm_last_name}               10s     Confirmation order Full Name not displayed
#    Run Keyword And Warn On Failure     Wait Until Element Is Visible    ${confirm_address1}                10s     Confirmation order Address1 not displayed
#    Run Keyword And Warn On Failure     Wait Until Element Is Visible    ${confirm_postal}                  10s     Confirmation order Postal not displayed
#    Run Keyword And Warn On Failure     Wait Until Element Is Visible    ${confirm_phone}                   10s     Confirmation order Phone not displayed
#    Run Keyword And Warn On Failure     Wait Until Element Is Visible    ${confirm_order_total_top}

