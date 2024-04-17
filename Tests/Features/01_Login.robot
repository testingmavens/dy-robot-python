*** Settings ***
Test Setup        Run Keywords    Open website  Read Data From JSON File  Close dev tools icon
Test Teardown     Run Keywords    Close All Browsers
Force Tags        prod    automation
Library           SeleniumLibrary    screenshot_root_directory=EMBED
Resource          ../../Resources/Locators.robot
Resource          ../../Resources/Variables.robot
Resource          ../../Resources/Errors.robot
Resource          ../../Keywords/Homepage.robot
Resource          ../../Keywords/Checkout.robot
Resource          ../../Keywords/Cart.robot
Resource          ../../Keywords/OrderConfirmation.robot
Resource          ../../Keywords/Shipping.robot
Resource          ../../Keywords/Payment.robot
Resource          ../../Keywords/PDP.robot
Resource          ../../Keywords/PLP.robot
Resource          ../../Keywords/CommonWeb.robot
Resource          ../../Keywords/Login.robot
Resource          ../../Keywords/StoreLocator.robot
Resource          ../../Keywords/GiftCard.robot
Resource          ../../Keywords/MyAccount.robot
Resource          ../../Keywords/DataReader.robot
*** Test Cases ***
Registration - 01 - New customer registration feature with valid details
    [Tags]
    Check if Login is accessible from header
    Check whether all elements are dislpayed in register section
    Check user navigates to registration page on clicking register button
    Close the Get the First Look modal
    Check whether all elements are dislpayed in registration page
    Check whether registration is possible with valid details

Registration - 02 - New customer registration feature with valid details and signup
    [Tags]
    Check if Login is accessible from header
    Check user navigates to registration page on clicking register button
    Close the Get the First Look modal
    Check privary policy link in registration page
    Check whether all elements are dislpayed in registration page
    Check whether registration is possible with valid details and signup

Registration - 03 - Change password and login for new customer
    [Tags]
    Click on Sign In
    Click on Register User
    Close the Get the First Look modal
    Generate Timestamp Email
    Fill in Register Form           ${FIRST_NAME}    ${LAST_NAME}    ${guest_valid}      ${valid_password}+1
    Click on Register
    Check Created User fields       ${FIRST_NAME}    ${LAST_NAME}    ${guest_valid}
    Logout
    Click on Sign In
    Fill in Login Form              ${guest_valid}     ${valid_password}+1
    Click on Login
    Check Email in Account Page     ${guest_valid}
    Change Email                    a_${guest_valid}    ${valid_password}+1
    Check Email in Account Page     a_${guest_valid}

Registration - 04 - Login user with valid credentials
    [Tags]
    Click on Sign In
    Fill in Login Form              ${REGISTERED_email}     ${REGISTERED_pwd}
    Click on Login
    Check Email in Account Page     ${REGISTERED_email}

Registration - 05 - Verify new customer registration feature with blank mandatory values
    Check if Login is accessible from header
    Check whether all elements are dislpayed in register section
    Check user navigates to registration page on clicking register button
    Close the Get the First Look modal
    Check whether all elements are displayed in customer registration page
    Check whether registration is possible with blank mandatory values
    Check whether registration is possible with blank first name value
    Check whether registration is possible with blank last name value
    Check whether registration is possible with blank email value
    Check whether registration is possible with blank retype email value
    Check whether registration is possible with blank password value
    Check whether registration is possible with blank retype password value

Registration - 06 - Verify new customer registration feature with invalid email value
    Check if Login is accessible from header
    Check whether all elements are dislpayed in register section
    Check user navigates to registration page on clicking register button
    Close the Get the First Look modal
    Check whether registration is possible with invalid email value
    Check whether registration is possible with invalid retype email value

Registration - 07 - Verify new customer registration feature with already existing email value
    Check if Login is accessible from header
    Check whether all elements are dislpayed in register section
    Check user navigates to registration page on clicking register button
    Close the Get the First Look modal
    Check whether registration is possible with already existing email value

Registration - 08 - Verify new customer registration feature with mismatch email value
    Check if Login is accessible from header
    Check whether all elements are dislpayed in register section
    Check user navigates to registration page on clicking register button
    Close the Get the First Look modal
    Check whether registration is possible with email mismatch

Registration - 09 - Verify new customer registration feature with password requirements not satisfied
    Check if Login is accessible from header
    Check whether all elements are dislpayed in register section
    Check user navigates to registration page on clicking register button
    Close the Get the First Look modal
    Check whether registration is possible with password requirement not satisfied - minimum length
    Check whether registration is possible with password requirement not satisfied - capital and lower case
    Check whether registration is possible with password requirement not satisfied - no space
    Check whether registration is possible with password requirement not satisfied - no special character
    Check whether registration is possible with password requirement not satisfied - one number
    Check whether registration is possible with password requirement not satisfied - minimum length


