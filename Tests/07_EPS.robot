*** Settings ***
Test Setup        Run Keywords    Open website
Test Teardown     Run Keywords    Close All Browsers
Force Tags        Regression    automation
Library           SeleniumLibrary    screenshot_root_directory=EMBED
Resource           ../Keywords/EPS.robot
Resource           ../Keywords/Search.robot
Resource           ../Keywords/PLP.robot
Resource           ../Keywords/Cart.robot
Resource           ../Keywords/Checkout.robot
Resource           ../Keywords/Search.robot
Resource           ../Keywords/Shipping.robot
Resource           ../Keywords/Payment.robot

*** Test Cases ***
PRD_SMK_EPS - 01 - Login and Check PLP page
    [Tags]  EPS
    @{query_list}=    Create List    curb chain bracelet   silver bracelet   gold necklace
    Login to EPS
  FOR    ${search_query}    IN    @{query_list}
    Search for a product from header search    ${search_query}
    Check did you mean suggestion is not displayed
    Check search instead option for    ${search_query}
    Check top results displayed for search  ${search_query}
    Click View all products
    Check all products in PLP search results contain  ${search_query}
  END

PRD_SMK_EPS - 02 - Check PLP page for strike thorugh price
    [Tags]  EPS
    Login to EPS
    Search for a product from header search    Gold
    Click View all products
    Check all products in PLP has striked through rates

PRD_SMK_EPS - 03 - Forgot Link Password
    [Tags]  EPS
    Click forgot password link
    Check forgot password modal
    Enter mail address in forgot password modal
    Click submit button from forgot password modal
    Check forgot password success message
    Click close button from forgot password modal


PRD_SMK_EPS - 04 - Checkout with Tax Calculation
    [Tags]  EPS
    Login to EPS
    Search for a product from header search   T7039QMSTBRAC
    Click search icon from header search
    Sleep  5s
    Close the Get the First Look modal
    Open the Product from PLP product list  1
    Get product primary name from PDP
    Select Size    M
    Click Add To Cart Button from PDP
    Click on My Bag
    Click on View Bag from minicart
    Click on Checkout button from Cart page
   IF   '${shopLocale}' in ['US','CN']
    Generate Timestamp Email
    Enter valid Shipping details    ${guest_valid}    ${FIRST_NAME}   ${LAST_NAME}   ${ADDRESS}   ${ADDRESS2}   ${ZIP}   ${PHONE}
    Check that the default Delivery Method is selected    2-day
    Click on Continue To Payment button
    Select an Address from Address Suggestion modal    suggested
    Check that the correct tax was applied for state    California
    Sleep  2s
    Click on Edit Shipping link from Payment step
    Change the state and zip    Hawaii    96825
    Click on Continue To Payment button
    Select an Address from Address Suggestion modal    entered
    Check that the correct tax was applied for state    Hawaii
    Sleep  2s
    Click on Edit Shipping link from Payment step
    Change the state and zip    Alaska    99517
    Click on Continue To Payment button
    Select an Address from Address Suggestion modal    entered
    Check that the correct tax was applied for state    Alaska
    Click on Continue To Payment button
    Select an Address from Address Suggestion modal    entered
    Verify if Order Summary data is correct    M    1
    Enter payment details    ${amex_number}    ${card_exp}    ${amex_csv}    ${card_holder}
    Expand the Promo Code section
   ELSE IF    '${shopLocale}' in ['UK','FR']
    Click checkout as guest button
    Enter valid billing details for eu    ${GUEST_email}    ${FIRST_NAME}   ${LAST_NAME}   ${ADDRESS}   ${ADDRESS2}   ${ZIP}   ${PHONE}
    Enter payment details for eu    ${visa_number}    ${card_exp}    ${csv}    ${card_holder}
   END

