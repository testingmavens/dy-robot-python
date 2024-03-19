*** Settings ***
Test Setup        Run Keywords    Open website
Test Teardown     Run Keywords    Close All Browsers
Force Tags        prod    automation
Library           SeleniumLibrary    screenshot_root_directory=EMBED
Resource          ../Resources/Locators.robot
Resource          ../Resources/Variables.robot
Resource          ../Resources/Errors.robot
Resource          ../Keywords/CommonWeb.robot
Resource          ../Keywords/Login.robot
Resource          ../Keywords/Homepage.robot
Resource          ../Keywords/Checkout.robot
Resource          ../Keywords/PDP.robot
Resource          ../Keywords/Cart.robot
Resource          ../Keywords/Shipping.robot
Resource          ../Keywords/Wishlist.robot
Resource          ../Keywords/Login.robot
Resource          ../Keywords/Search.robot
Resource          ../Keywords/PLP.robot
Resource          ../Keywords/Payment.robot
Resource          ../Keywords/GiftCard.robot
*** Test Cases ***
PRD_SMK_Checkout - 01 - Generic Checkout with Credit Card
    [Tags]  DY  RUN
    Search for a product from header search  B13779 SS
    Click search icon from header search
    Close the Get the First Look modal
    Open the Product from PLP product list  1
    Select Size    L
    Sleep  3s
    Click Add To Cart Button from PDP
    Click on My Bag
    Click on View Bag from minicart
    Click on Checkout button from Cart page
  IF   '${shopLocale}' in ['US','CN']
    Enter valid Shipping details    ${GUEST_email}    ${FIRST_NAME}   ${LAST_NAME}   ${ADDRESS}   ${ADDRESS2}   ${ZIP}   ${PHONE}
    Select Delivery    2-day
    Check that the default Delivery Method is selected    2-day
    Click on Continue To Payment button
    Select an Address from Address Suggestion modal    suggested
    Enter payment details    ${visa_number}    ${card_exp}    ${csv}    ${card_holder}
   ELSE IF    '${shopLocale}' in ['UK','FR']
    Click checkout as guest button
    Enter valid billing details for eu    ${GUEST_email}    ${FIRST_NAME}   ${LAST_NAME}   ${ADDRESS}   ${ADDRESS2}   ${ZIP}   ${PHONE}
    Enter payment details for eu    ${visa_number}    ${card_exp}    ${csv}    ${card_holder}
   END



PRD_SMK_Checkout - 03 - Guest User/Simple Product-Wish List Add to bag/ Deliver to address/ 2Day Delivery/ Mastercard
    [Tags]  DY
    Search for a product from header search  B13779 SS
    Click search icon from header search
    Sleep  5s
    Close the Get the First Look modal
    Open the Product from PLP product list  1
    Get product primary name from PDP
    Click add to wishlist button
    Click go to wishlist
    Check whether added item is displayed in wishlist
    Sleep  3s
    Click Move to bag button from wishlist
    Sleep  1s
    Select Size    S
    Click add to bag
    Sleep  3s
    Click on View Bag from minicart
    Check whether product is added to cart
    Click on Checkout button from Cart page
    IF   '${shopLocale}' in ['US','CN']
    Click on Continue To Payment button
    Clear the Checkout Shipping form
    Generate Timestamp Email
    Sleep  3s
    Enter valid Shipping details    ${guest_valid}    ${FIRST_NAME}   ${LAST_NAME}   ${ADDRESS}   ${ADDRESS2}   ${ZIP}   ${PHONE}
    Check that the default Delivery Method is selected    2-day
    Check delivery date for the shipping method  2-day
    #Check Info Texts During Checkout
    Click on Continue To Payment button
    Select an Address from Address Suggestion modal    entered
    Verify that the shipping information is correct on Payment page    ${guest_valid}    ${FIRST_NAME}   ${LAST_NAME}   ${ADDRESS}   ${ADDRESS2}   ${ZIP}   ${PHONE}
    Verify that the shipping method is correct on Payment page    2-day
    Sleep  1s
    Click on Edit Shipping link from Payment step
    Sleep  1s
    Enter valid Shipping details    ${GUEST_email}    ${Reg_FIRST_NAME}   ${Reg_LAST_NAME}   ${Reg_ADDRESS}   ${ADDRESS2}   ${ZIP_two}   ${PHONE_two}
    Select Delivery    Overnight
    Check if the Shipping cost was update in the Summary
    Check delivery date for the shipping method  Overnight
    Click on Continue To Payment button
    Select an Address from Address Suggestion modal    entered
    Verify that the shipping information is correct on Payment page    ${GUEST_email}    ${Reg_FIRST_NAME}   ${Reg_LAST_NAME}   ${Reg_ADDRESS}   ${ADDRESS2}   ${ZIP_two}   ${PHONE_two}
    Verify that the shipping method is correct on Payment page    2-day
    Check that Credit Card payment option is preselected and expanded
    Check that Billing Same As Shipping checkbox is selected by default
    Enter payment details    ${mastercard_number}    ${card_exp}    ${csv}    ${card_holder}
  ELSE IF    '${shopLocale}' in ['UK','FR']
    Click checkout as guest button
    Enter valid billing details for eu    ${GUEST_email}    ${FIRST_NAME}   ${LAST_NAME}   ${ADDRESS}   ${ADDRESS2}   ${ZIP}   ${PHONE}
    Enter payment details for eu    ${visa_number}    ${card_exp}    ${csv}    ${card_holder}
   END


PRD_SMK_Checkout - 04 - Guest User/Simple Product/ Deliver to address/ 2Day Delivery/ AMEX
    [Tags]  DY
    Go to womens amulet stacker
    Sleep  5s
    Open the Product from PLP product list  3
    Get product primary name from PDP
    Click Add To Cart Button from PDP
    Click on My Bag
    Click on View Bag from minicart
    Click on Checkout button from Cart page
    IF   '${shopLocale}' in ['US','CN']
    Click on Continue To Payment button
    Enter text in shipping address       123
    Select suggestion number    2
    Generate Timestamp Email
    Fill in the remaining Shipping details ${guest_valid}    ${FIRST_NAME}   ${LAST_NAME}   ${PHONE}
    Check that the default Delivery Method is selected    2-day
    Click on Continue To Payment button
    Select an Address from Address Suggestion modal    suggested
    Check that Credit Card payment option is preselected and expanded
    Check that Billing Same As Shipping checkbox is selected by default
    Enter payment details    ${amex_number}    ${card_exp}    ${amex_csv}    ${card_holder}
  ELSE IF    '${shopLocale}' in ['UK','FR']
    Click checkout as guest button
    Enter valid billing details for eu    ${GUEST_email}    ${FIRST_NAME}   ${LAST_NAME}   ${ADDRESS}   ${ADDRESS2}   ${ZIP}   ${PHONE}
    Enter payment details for eu    ${visa_number}    ${card_exp}    ${csv}    ${card_holder}
   END

PRD_SMK_Checkout - 05 - Guest User/Simple Product/ Deliver to address/ 2Day Delivery/ Order Review/ Tax Calculation/ AMEX
    [Tags]  DY  TaxCalculation
    Search for a product from header search  T7039QMSTBRAC
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

PRD_SMK_Checkout - 06 - Guest User/Simple Product/ Deliver to address/ 2Day Delivery/ Discover
    [Tags]  DY
    Search for a product from header search  B13779 SS
    Click search icon from header search
    Sleep  5s
    Close the Get the First Look modal
    Open the Product from PLP product list  1
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
    Select an Address from Address Suggestion modal    entered
    Check that Credit Card payment option is preselected and expanded
    Check that Billing Same As Shipping checkbox is selected by default
    Sleep  2s
    Expand the Redeem Gift Card section
   ELSE IF    '${shopLocale}' in ['UK','FR']
    Click checkout as guest button
    Enter valid billing details for eu    ${GUEST_email}    ${FIRST_NAME}   ${LAST_NAME}   ${ADDRESS}   ${ADDRESS2}   ${ZIP}   ${PHONE}
    Enter payment details for eu    ${visa_number}    ${card_exp}    ${csv}    ${card_holder}
   END


PRD_SMK_Checkout - 07 - Guest User/Simple Product/ Deliver to address/ 2Day Delivery/ PayPal
    [Tags]  DY  RUN
    Search for a product from header search  B13779 SS
    Click search icon from header search
    Sleep  5s
    Close the Get the First Look modal
    Open the Product from PLP product list  1
    Select Size    M
    Sleep  2s
    Click Add To Cart Button from PDP
    Access Cart page directly
    Click on Checkout button from Cart page
   IF   '${shopLocale}' in ['US','CN']
    Generate Timestamp Email
    Enter valid Shipping details    ${guest_valid}    ${FIRST_NAME}   ${LAST_NAME}   ${ADDRESS}   ${ADDRESS2}   ${ZIP}   ${PHONE}
    Sleep  2s
    Select Delivery    2-day
    Check if the Shipping cost was update in the Summary
    Click on Continue To Payment button
    Select an Address from Address Suggestion modal    entered
    Select the PayPal payment method
  ELSE IF    '${shopLocale}' in ['UK','FR']
    Click checkout as guest button
    Enter valid billing details for eu    ${GUEST_email}    ${FIRST_NAME}   ${LAST_NAME}   ${ADDRESS}   ${ADDRESS2}   ${ZIP}   ${PHONE}
    Enter payment details for eu    ${visa_number}    ${card_exp}    ${csv}    ${card_holder}
    Select the PayPal payment method
   END

PRD_SMK_Checkout - 08 - Guest User/Simple Product/ Deliver to address/ 2Day Delivery/ PayPal Express from Mini Cart
    [Tags]  DY
    Search for a product from header search  B13779 SS
    Click search icon from header search
    Sleep  5s
    Close the Get the First Look modal
    Open the Product from PLP product list  1
    Select Size    L
    Click Add To Cart Button from PDP
    Click on Paypal button from Page    minicart


PRD_SMK_Checkout - 09 - Guest User/Simple Product/ Deliver to address/ 2Day Delivery/ PayPal Express from Cart
    [Tags]  DY
    Search for a product from header search  B13779 SS
    Click search icon from header search
    Sleep  5s
    Close the Get the First Look modal
    Open the Product from PLP product list  1
    Select Size    L
    Click Add To Cart Button from PDP
    Click on View Bag from minicart
    Click on Paypal button from Page    cart


PRD_SMK_Checkout - 10 - Guest User/Simple Product/ Deliver to address/ 2Day Delivery/ PayPal Express from checkout Page
    [Tags]  DY
    Search for a product from header search  B13779 SS
    Click search icon from header search
    Sleep  5s
    Close the Get the First Look modal
    Open the Product from PLP product list  1
    Select Size    M
    Click Add To Cart Button from PDP
    Click on View Bag from minicart
    Click on Checkout button from Cart page
    Click on Paypal button from Page    checkout

PRD_SMK_Checkout - 11 - Guest User/Simple Product/ Deliver to address/ Overnight Delivery/ Affirm
    [Tags]  DY
    Search for a product from header search  B13779 SS
    Click search icon from header search
    Sleep  5s
    Close the Get the First Look modal
    Open the Product from PLP product list  1
    Select Size    M
    Click Add To Cart Button from PDP
    Click on View Bag from minicart
    Click on Checkout button from Cart page
    Generate Timestamp Email
    Enter valid Shipping details    ${guest_valid}    ${FIRST_NAME}   ${LAST_NAME}   ${ADDRESS}   ${ADDRESS2}   ${ZIP}   ${PHONE}
    Select Delivery    Overnight
    Check if the Shipping cost was update in the Summary
    Click on Continue To Payment button
    Select an Address from Address Suggestion modal    entered
    Select the Affirm payment method
    Check that the Affirm Checkout modal is displayed


PRD_SMK_Checkout - 12 - Checkout a $0 item
    [Tags]  DY
    Search for a product from header search  192740696091
    Click search icon from header search
    Sleep  5s
    Close the Get the First Look modal
    Open the Product from PLP product list  1
    Click Add To Cart Button from PDP
    Click on View Bag from minicart
    Click on Checkout button from Cart page
    Enter valid Shipping details    ${GUEST_email}    ${FIRST_NAME}   ${LAST_NAME}   ${ADDRESS}   ${ADDRESS2}   ${ZIP}   ${PHONE}
    Select Delivery    Standard
    Click on Continue To Payment button
    Select an Address from Address Suggestion modal    entered
    Click on Place Order CTA for payment    zero_order


PRD_SMK_Checkout - 13 - Logged In User/Simple Product/ Deliver to address/ 2Day Delivery/ Affirm
    [Tags]  DY
   IF   '${shopLocale}' in ['US','CN']
    Search for a product from header search  BC0100MSS
    Click search icon from header search
    Sleep  5s
    Close the Get the First Look modal
    Open the Product from PLP product list  1
    Select Size    S
    Click Add To Cart Button from PDP
    Click on View Bag from minicart
    Click on Checkout button from Cart page
    Click on Sign In button from Checkout
    Enter login credentials during checkout    ${REG_affirm_account}    ${REG_affirm_pwd}
    Click on Sign In button during checkout
    Select Delivery    2-day
    Click on Continue To Payment button
    Select an Address from Address Suggestion modal    entered
    Select the Affirm payment method
    Check that the Affirm Checkout modal is displayed
   END

PRD_SMK_Checkout - 14 - Checkout with Credit Card and Virtual Gift Card
    [Tags]  DY
    Search for a product from header search  BC0100MSS
    Click search icon from header search
    Sleep  5s
    Close the Get the First Look modal
    Open the Product from PLP product list  1
    Select Size    L
    Click Add To Cart Button from PDP
    Click on My Bag
    Click on View Bag from minicart
    Click on Checkout button from Cart page
   IF   '${shopLocale}' in ['US','CN']
    Enter valid Shipping details    ${GUEST_email}    ${FIRST_NAME}   ${LAST_NAME}   ${ADDRESS}   ${ADDRESS2}   ${ZIP}   ${PHONE}
    Click on Continue To Payment button
    Select an Address from Address Suggestion modal    suggested
    Sleep  5s
    Add Physical Gift Card
   ELSE IF    '${shopLocale}' in ['UK','FR']
    Click checkout as guest button
    Enter valid billing details for eu    ${GUEST_email}    ${FIRST_NAME}   ${LAST_NAME}   ${ADDRESS}   ${ADDRESS2}   ${ZIP}   ${PHONE}
    Enter payment details for eu    ${visa_number}    ${card_exp}    ${csv}    ${card_holder}
    Click on Place Order CTA for payment in eu    cc
   END



PRD_SMK_Checkout - 15 - Check Virtual GC Purchase
    [Tags]  DY
    Open Gift Card PDP
    Close the Get the First Look modal
    Select Amount Gift Card PDP  1
    Fill Virtual GC PDP
    Click Add To Cart Button from PDP
    Click on My Bag
    Click on View Bag from minicart
    Click on Checkout button from Cart page
   IF   '${shopLocale}' in ['US','CN']
    Check VGC fields on the checkout
    Enter payment details    ${visa_number}    ${card_exp}    ${csv}    ${card_holder}
    Enter text in Billing address       123
    Verify the address suggestions are displayed
    Select suggestion number    2
    Generate Timestamp Email
    Fill in the remaining Billing details    ${guest_valid}    ${FIRST_NAME}   ${LAST_NAME}    ${PHONE}
  ELSE IF    '${shopLocale}' in ['UK','FR']
    Click checkout as guest button
    Enter valid billing details for eu    ${GUEST_email}    ${FIRST_NAME}   ${LAST_NAME}   ${ADDRESS}   ${ADDRESS2}   ${ZIP}   ${PHONE}
    Enter payment details for eu    ${visa_number}    ${card_exp}    ${csv}    ${card_holder}
  END


PRD_SMK_Checkout - 16 - Check Physical GC Purchase
    [Tags]  DY
    Open Gift Card PDP   False
    Close the Get the First Look modal
    Select an Available Physical Gift Card PDP
    Scroll To Top
    Click Add To Cart Button from PDP
    Click on My Bag
    Click on View Bag from minicart
    Click on Checkout button from Cart page
    IF   '${shopLocale}' in ['US','CN']
    Enter text in shipping address       123
    Verify the address suggestions are displayed
    Select suggestion number    2
    Generate Timestamp Email
    Sleep  3s
    Fill in the remaining Shipping details    ${guest_valid}    ${FIRST_NAME}   ${LAST_NAME}    ${PHONE}
    Check that the default Delivery Method is selected    2-day
    Click on Continue To Payment button
    Select an Address from Address Suggestion modal    suggested
    Check that Credit Card payment option is preselected and expanded
    Check that Billing Same As Shipping checkbox is selected by default
    Enter payment details    ${amex_number}    ${card_exp}    ${amex_csv}    ${card_holder}
   ELSE IF    '${shopLocale}' in ['UK','FR']
    Click checkout as guest button
    Enter valid billing details for eu    ${GUEST_email}    ${FIRST_NAME}   ${LAST_NAME}   ${ADDRESS}   ${ADDRESS2}   ${ZIP}   ${PHONE}
    Enter payment details for eu    ${visa_number}    ${card_exp}    ${csv}    ${card_holder}
    Click on Place Order CTA for payment in eu    cc
   END

PRD_SMK_Checkout - 17 - Check BOPIS/ Guest User/Simple Product
    [Tags]  DY
   Skip if  '${shopLocale}' in ['UK','FR']
   IF   '${shopLocale}' in ['US','CN']
    Search for a product from header search  R15752MBB
    Click search icon from header search
    Sleep  5s
    Close the Get the First Look modal
    Open the Product from PLP product list  1
    Select Size    6
    Open BOPIS modal
    Select available store at       90022
    Click Add To Cart Button from PDP
    Click on My Bag
    Click on Checkout button from Cart page
    Enter valid Store PickUp Guest details       ${GUEST_email}    ${FIRST_NAME}   ${LAST_NAME}  ${PHONE}
    Click on Continue To Payment button
    Enter payment details    ${visa_number}    ${card_exp}    ${csv}    ${card_holder}
    Enter text in Billing address       123
    Select suggestion number    2
    Generate Timestamp Email
    Fill in the remaining Billing details    ${guest_valid}    ${FIRST_NAME}   ${LAST_NAME}    ${PHONE}
   END

PRD_SMK_Checkout - 18 - Check Multiple BOPIS
    [Tags]  DY
   Skip if  '${shopLocale}' in ['UK','FR']
   IF   '${shopLocale}' in ['US','CN']
    Search for a product from header search  R15752MBB
    Click search icon from header search
    Sleep  5s
    Close the Get the First Look modal
    Open the Product from PLP product list  1
    Select Size    11
    Open BOPIS modal
    Select available store at       92626
    Click Add To Cart Button from PDP
    Close mini cart modal
    Select Size    6
    Open BOPIS modal
    Select available store at       90022
    Click Add To Cart Button from PDP
    Click on My Bag
    Click on Checkout button from Cart page
    Enter valid Shipping details    ${GUEST_email}    ${FIRST_NAME}   ${LAST_NAME}   ${ADDRESS}   ${ADDRESS2}   ${ZIP}   ${PHONE}
    Click on Continue To Payment button
    Select an Address from Address Suggestion modal    entered
    Enter payment details    ${visa_number}    ${card_exp}    ${csv}    ${card_holder}
    Select/Unselect Billing Same As Shipping checkbox
    Enter text in Billing address       123
    Sleep  5s
    Select suggestion number    4
    Generate Timestamp Email
    Fill in the remaining Billing details    ${guest_valid}    ${FIRST_NAME}   ${LAST_NAME}    ${PHONE}
    Click on Place Order CTA for payment    cc
   END

PRD_SMK_Checkout - 19 - Check BOPIS + Delivery
    [Tags]  DY
   Skip if  '${shopLocale}' in ['UK','FR']
   IF   '${shopLocale}' in ['US','CN']
    Search for a product from header search  R15752MBB
    Click search icon from header search
    Sleep  5s
    Close the Get the First Look modal
    Open the Product from PLP product list  1
    Select Size    9
    Open BOPIS modal
    Select available store at       90022
    Click Add To Cart Button from PDP
    Close the minicart
    Select Size    6
    Select Address Pickup
    Click Add To Cart Button from PDP
    Click on My Bag
    Click on Checkout button from Cart page
    Enter valid Shipping details    ${GUEST_email}    ${FIRST_NAME}   ${LAST_NAME}   ${ADDRESS}   ${ADDRESS2}   ${ZIP}   ${PHONE}
    Click on Add Gift Message CTA
    Fill in the Gifting Form from Shipping step    my    present    gift
    Click on Continue To Payment button
    Select an Address from Address Suggestion modal    entered
    Check that Billing Same As Shipping checkbox is selected by default
    Sleep  2s
    Select/Unselect Billing Same As Shipping checkbox
    Enter payment details    ${visa_number}    ${card_exp}    ${csv}    ${card_holder}
   END

PRD_SMK_Checkout - 20 - Logged In User/Simple Product/ Deliver to address/ 2Day Delivery/ Affirm
    [Tags]  DY
   Skip if  '${shopLocale}' in ['UK','FR']
   IF   '${shopLocale}' in ['US','CN']
    Search for a product from header search  B13779 SS
    Click search icon from header search
    Sleep  5s
    Close the Get the First Look modal
    Open the Product from PLP product list  1
    Select Size    M
    Click Add To Cart Button from PDP
    Click on View Bag from minicart
    Click on Checkout button from Cart page
    Click on Sign In button from Checkout
    Enter login credentials during checkout    ${REG_affirm_account}    ${REG_affirm_pwd}
    Click on Sign In button during checkout
    Select Delivery    2-day
    Click on Continue To Payment button
    Select an Address from Address Suggestion modal    entered
    Select the Affirm payment method
    Check that the Affirm Checkout modal is displayed
   END
