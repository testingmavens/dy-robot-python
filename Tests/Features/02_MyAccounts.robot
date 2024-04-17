*** Settings ***
Test Setup        Run Keywords    Open website   Read Data From JSON File  Close dev tools icon
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
MyAcount - 01 - Add/Edit/Remove Address details and card details
    [Tags]
    Generate Timestamp Email
    Click on Sign In
    Click on Register User
    Close the Get the First Look modal
    Fill in the Register form
    Click on Register Button
    Check that the user is successfully logged in and redirected to Account Details page    ${guest_valid}
    Click on Add a New Address button
    Click on Save button from Add a New Address form
    Verify the empty field validation messages for Add a New Address form
    Fill in the Add a New Address form    ${FIRST_NAME}   ${LAST_NAME}    ${reg_29_address}    ${reg_29_city}    ${reg_29_state}    ${reg_29_zip}    ${reg_29_tel}
    Click on Save button from Add a New Address form
    Check if the new address is present in My Account    ${FIRST_NAME}   ${LAST_NAME}    ${reg_29_address}    ${reg_29_city}    ${reg_29_zip}    ${reg_29_tel}
    Click on Edit link near first address
    Fill in the Edit Address form    ${Reg_FIRST_NAME}   ${Reg_LAST_NAME}    ${reg_29_address_1}    ${reg_29_city_1}    ${reg_29_state_1}    ${reg_29_zip_1}    ${reg_29_tel_1}
    Click on Save button from Edit Address form
    Check if the new address is present in My Account    ${Reg_FIRST_NAME}   ${Reg_LAST_NAME}    ${reg_29_address_1}    ${reg_29_city_1}    ${reg_29_zip_1}    ${reg_29_tel_1}
    Click on Delete link near first address
    Click Confirm on the Delete Address modal
    Check that My Address section is empty
    Click on Add a New Credit Card button
    Click on Save button from Add a New Credit Card form
    Verify the empty field validation messages for Add a New Credit Card form
    Close the New Credit Card form
    Click on Add a New Credit Card button
    Fill in the Add a New Credit Card form    ${reg_29_name}   ${visa_number}    ${csv}    ${FIRST_NAME}    ${LAST_NAME}    ${reg_29_address_1}    ${reg_29_city_1}    ${reg_29_state_1}    ${reg_29_zip_1}    ${reg_29_tel_1}
    Click on Save button from Add a New Credit Card form
    Skip
    Check if the new card is present in My Account    ${FIRST_NAME}    ${LAST_NAME}    ${reg_29_address}    ${reg_29_city}    ${reg_29_zip}    ${reg_29_tel}
    Click on Make Default button near first CC and see if setting is applied
    Click on Remove button near first CC
    Click Confirm on the Delete CC modal
    Check that Credit Card section is empty


MyAcount - 02 -Add/Edit/Remove card details
    [Tags]  ${product}
    Click on Sign In
    Click on Register User
    Close the Get the First Look modal
    Generate Timestamp Email
    Fill in the Register form
    Check that the user is successfully logged in and redirected to Account Details page    ${guest_valid}
    Click on Add a New Address button
    Fill in the Add a New Address form    ${FIRST_NAME}   ${LAST_NAME}    ${reg_29_address}    ${reg_29_city}    ${reg_29_state}    ${reg_29_zip}    ${reg_29_tel}
    Click on Save button from Add a New Address form
    Check if the new address is present in My Account    ${FIRST_NAME}   ${LAST_NAME}    ${reg_29_address}    ${reg_29_city}    ${reg_29_zip}    ${reg_29_tel}
    Click on Add a New Credit Card button
    Sleep  2s
    Close the New Credit Card form
    Click on Add a New Credit Card button
    Fill in the Add a New Credit Card form    ${reg_29_name}   ${visa_number}    ${csv}    ${FIRST_NAME}    ${LAST_NAME}    ${reg_29_address_1}    ${reg_29_city_1}    ${reg_29_state_1}    ${reg_29_zip_1}    ${reg_29_tel_1}
    Click on Save button from Add a New Credit Card form
    Check if the new card is present in My Account    ${FIRST_NAME}    ${LAST_NAME}    ${reg_29_address}    ${reg_29_city}    ${reg_29_zip}    ${reg_29_tel}
    Click on Make Default button near first CC and see if setting is applied
    Click on Remove button near first CC
    Click Confirm on the Delete CC modal
    Check that Credit Card section is empty

MyAcount - 03 - Validate Personal Info change
    [Tags]  ${product}
    Click on Sign In
    Click on Register User
    Close the Get the First Look modal
    Generate Timestamp Email
    Fill in Register Form           ${FIRST_NAME}    ${LAST_NAME}    ${guest_valid}      ${valid_password}
    Click on Register
    Check Created User fields       ${FIRST_NAME}    ${LAST_NAME}    ${guest_valid}
    Change Name in Personal Information             First   Last
    Change Birthday in Personal Information         12/12/2012
    Change Anniversary in Personal Information      11/11/2002
    Save Personal Information                       First
    Check Personal Information                      First   Last     12/12/2012    11/11/2002


MyAcount - 04 - Validate Personal validation messages
    [Tags]  ${product}
    Click on Sign In
    Click on Register User
    Close the Get the First Look modal
    Generate Timestamp Email
    Fill in Register Form           ${FIRST_NAME}    ${LAST_NAME}    ${guest_valid}      ${valid_password}
    Click on Register
    Check Created User fields       ${FIRST_NAME}    ${LAST_NAME}    ${guest_valid}
    Clear Name in Personal Information
    Save Personal Information with no arguments
    Check validation message for first name and last name field

