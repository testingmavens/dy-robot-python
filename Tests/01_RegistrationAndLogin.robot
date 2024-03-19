*** Settings ***
Test Setup        Run Keywords    Open website
Test Teardown     Run Keywords    Close All Browsers
Force Tags        prod    automation
Library           SeleniumLibrary    screenshot_root_directory=EMBED
Resource          ../Resources/Locators.robot
Resource          ../Resources/Locators/MyAccount/LoginOrRegistration.robot
Resource          ../Resources/Variables.robot
Resource          ../Resources/Errors.robot
Resource          ../Keywords/NewCustomerRegistration.robot
Resource          ../Keywords/MyAccount/LoginOrRegistration.robot
Resource          ../Keywords/Homepage.robot
Resource          ../Keywords/Checkout.robot
Resource          ../Keywords/Cart.robot
Resource          ../Keywords/OrderConfirmation.robot
Resource          ../Keywords/Shipping.robot
Resource          ../Keywords/Payment.robot
Resource          ../Keywords/PDP.robot
Resource          ../Keywords/PLP.robot
Resource          ../Keywords/CommonWeb.robot
Resource          ../Keywords/Login.robot
Resource          ../Keywords/StoreLocator.robot
Resource          ../Keywords/GiftCard.robot
Resource          ../Keywords/MyAccount.robot
*** Test Cases ***
PRD_SMK_Registration - 01 - New customer registration feature with valid details
    [Tags]
    Check if Login is accessible from header
    Check whether all elements are dislpayed in register section
    Check user navigates to registration page on clicking register button
    Close the Get the First Look modal
    Check whether all elements are dislpayed in registration page
    Check whether registration is possible with valid details

PRD_SMK_Registration - 02 - New customer registration feature with valid details and signup
    [Tags]
    Check if Login is accessible from header
    Check user navigates to registration page on clicking register button
    Close the Get the First Look modal
    Check privary policy link in registration page
    Check whether all elements are dislpayed in registration page
    Check whether registration is possible with valid details and signup

PRD_SMK_Registration - 03 - Change password and login for new customer
    [Tags]
    Click on Sign In
    Click on Register User
    Close the Get the First Look modal
    Generate Timestamp Email
    Fill in Register Form           ${FIRST_NAME}    ${LAST_NAME}    ${guest_valid}      ${valid_password}
    Click on Register
    Check Created User fields       ${FIRST_NAME}    ${LAST_NAME}    ${guest_valid}
    Change Password                 ${valid_password}   ${valid_password}+1
    Logout
    Click on Sign In
    Fill in Login Form              ${guest_valid}     ${valid_password}+1
    Click on Login
    Check Email in Account Page     ${guest_valid}
    Change Email                    a_${guest_valid}    ${valid_password}+1
    Check Email in Account Page     a_${guest_valid}

PRD_SMK_Registration - 04 - Login user with valid credentials
    [Tags]
    Click on Sign In
    Fill in Login Form              ${REGISTERED_email}     ${REGISTERED_pwd}
    Click on Login
    Check Email in Account Page     ${REGISTERED_email}
