*** Settings ***
Test Setup        Run Keywords    Open website   Read Data From JSON File
Test Teardown     Run Keywords    Close All Browsers
Force Tags        Regression    automation
Library           SeleniumLibrary    screenshot_root_directory=EMBED
Resource          ../../Resources/Locators.robot
Resource          ../../Resources/Variables.robot
Resource          ../../Resources/Errors.robot
Resource          ../../Keywords/Checkout.robot
Resource          ../../Keywords/Cart.robot
Resource          ../../Keywords/OrderConfirmation.robot
Resource          ../../Keywords/Shipping.robot
Resource          ../../Keywords/Payment.robot
Resource          ../../Keywords/PDP.robot
Resource          ../../Keywords/PLP.robot
Resource          ../../Keywords/CommonWeb.robot
Resource          ../../Keywords/Login.robot
Resource          ../../Keywords/Homepage.robot
Resource          ../../Keywords/StoreLocator.robot
Resource          ../../Keywords/GiftCard.robot
Resource          ../../Keywords/MyAccount.robot
Resource          ../../Keywords/DataReader.robot
Resource          ../../Keywords/Search.robot

*** Test Cases ***
Checkout with Credit Card - Visa
    [Documentation]    Verifies the flow for a guest user purchasing a product with 2-day delivery using a credit card.
    ...                It is a Sanity test to assess basic functionality of the new build.
    [Tags]    Guest    Generic   CreditCard  Checkout
    Search for a product from header search  883932208184
    Click search icon from header search
    Close the Get the First Look modal
    Open the Product from PLP product list  1
    Select Size    5
    Capture product price from PDP
    Capture product primary name from PDP
    Capture product secondary name from PDP
    Save the product subtitle on PDP
    Sleep  2s
    Click Add To Cart Button from PDP
    Click on My Bag
    Check shipping method group title in minicart  Delivery
    Compare item details in minicart with PDP  5
    Click on View Bag from minicart
    Check shipping method icon  Delivery
    Compare item details in cart with minicart
    Verify order summary in correct in cart page
    Generate Timestamp Email
   IF   '${shopLocale}' in ['US','CN']
    Click on Checkout button from Cart page
    Compare item details in cart with checkout
    Enter valid Shipping details    ${guest_valid}    ${FIRST_NAME}   ${LAST_NAME}   ${ADDRESS}   ${ADDRESS2}   ${ZIP}   ${PHONE}
    Select Delivery    2-day
    Check delivery date for the shipping method  2-day
    Click on Continue To Payment button
    Select an Address from Address Suggestion modal    suggested
    Enter payment details    ${visa_number}    ${card_exp}    ${csv}    ${card_holder}
    Verify if Order Summary data is correct    5    1
    Click on Place Order CTA for payment    cc
    Order Confirmation page is displayed
   END
   IF    '${shopLocale}' in ['UK','FR','GR','IT']
    Click on Checkout button from Cart page for EU
    Click checkout as guest button
    Verify if Order Summary data is correct for EU    5    1
    Enter valid Shipping details for EU    ${guest_valid}    ${FIRST_NAME}   ${LAST_NAME}   ${ADDRESS}   ${ADDRESS2}   ${ZIP}   ${PHONE}  ${CITY}
    Enter payment details for EU    ${visa_number}    ${card_exp}    ${csv}    ${card_holder}
    Click on Place Order CTA for payment for EU    cc
    Order Confirmation page is displayed for EU
   END


Checkout with Credit Card - Mastercard
    [Documentation]    This test case represents the end-to-end flow for a guest user purchasing a simple product with
    ...                2-day delivery using a Mastercard credit card. The steps include navigating through the product
    ...                details page (PDP), accessing the cart, entering shipping information, selecting delivery options,
    ...                proceeding to payment, and confirming the order. The test also covers validation of empty and
    ...                invalid fields on the shipping address step, clearing the checkout shipping form, and verifying
    ...                the correctness of shipping information and method on the payment page. Additionally, it checks
    ...                the preselection and expansion of the Credit Card payment option, the default selection of the
    ...                "Billing Same As Shipping" checkbox, and enters payment details for the Mastercard. Finally, it
    ...                verifies the display of the Order Confirmation page.
    [Tags]   Guest    CreditCard  Checkout
    Search for a product from header search  883932208184 
    Click search icon from header search
    Close the Get the First Look modal
    Open the Product from PLP product list  1
    Select Size    5
    Capture product price from PDP
    Capture product primary name from PDP
    Capture product secondary name from PDP
    Save the product subtitle on PDP
    Sleep  2s
    Click Add To Cart Button from PDP
    Click on My Bag
    Check shipping method group title in minicart  Delivery
    Compare item details in minicart with PDP  5
    Click on View Bag from minicart
    Check shipping method icon  Delivery
    Compare item details in cart with minicart
    Verify order summary in correct in cart page
    Generate Timestamp Email
    IF   '${shopLocale}' in ['US','CN']
    Click on Checkout button from Cart page
    Compare item details in cart with checkout
    Click on Continue To Payment button
    Clear the Checkout Shipping form
    Generate Timestamp Email
    Enter valid Shipping details    ${guest_valid}    ${FIRST_NAME}   ${LAST_NAME}   ${ADDRESS}   ${ADDRESS2}   ${ZIP}   ${PHONE}
    Check that the default Delivery Method is selected    2-day
    Check delivery date for the shipping method  2-day
    Check Info Texts During Checkout
    Click on Continue To Payment button
    Select an Address from Address Suggestion modal    entered
    Verify that the shipping information is correct on Payment page    ${guest_valid}    ${FIRST_NAME}   ${LAST_NAME}   ${ADDRESS}   ${ADDRESS2}   ${ZIP}   ${PHONE}
    Verify that the shipping method is correct on Payment page    2-day
    Click on Edit Shipping link from Payment step
    Enter valid Shipping details    ${GUEST_email}    ${Reg_FIRST_NAME}   ${Reg_LAST_NAME}   ${Reg_ADDRESS}   ${ADDRESS2}   ${ZIP_two}   ${PHONE_two}
    Select Delivery    2-day
    Click on Continue To Payment button
    Select an Address from Address Suggestion modal    entered
    Verify that the shipping information is correct on Payment page    ${GUEST_email}    ${Reg_FIRST_NAME}   ${Reg_LAST_NAME}   ${Reg_ADDRESS}   ${ADDRESS2}   ${ZIP_two}   ${PHONE_two}
    Verify that the shipping method is correct on Payment page    2-day
    Check that Credit Card payment option is preselected and expanded
    Check that Billing Same As Shipping checkbox is selected by default
    Enter payment details    ${mastercard_number}    ${card_exp}    ${csv}    ${card_holder}
    Click on Place Order CTA for payment    cc
    Order Confirmation page is displayed
    END
   IF    '${shopLocale}' in ['UK','FR','GR','IT']
    Click on Checkout button from Cart page for EU
    Click checkout as guest button
    Verify if Order Summary data is correct for EU    5    1
    Enter valid Shipping details for EU    ${guest_valid}    ${FIRST_NAME}   ${LAST_NAME}   ${ADDRESS}   ${ADDRESS2}   ${ZIP}   ${PHONE}  ${CITY}
    Enter payment details for EU    ${mastercard_number}    ${card_exp}    ${csv}    ${card_holder}
    Click on Place Order CTA for payment for EU    cc
    Order Confirmation page is displayed for EU
   END

Checkout with Credit Card - AMEX
    [Documentation]    This test case verifies the end-to-end process for a guest user purchasing a simple product with
    ...                2-day delivery, specifically using an American Express (AMEX)credit card for payment. The test
    ...                includes steps such as navigating through the product details page (PDP), accessing the cart,
    ...                entering shipping information, validating the shipping address step, and completing the purchase
    ...                with payment through an AMEX card.
    [Tags]   Guest    CreditCard    Checkout
    Search for a product from header search  883932208184 
    Click search icon from header search
    Close the Get the First Look modal
    Open the Product from PLP product list  1
    Select Size    5
    Capture product price from PDP
    Capture product primary name from PDP
    Capture product secondary name from PDP
    Save the product subtitle on PDP
    Sleep  2s
    Click Add To Cart Button from PDP
    Click on My Bag
    Check shipping method group title in minicart  Delivery
    Compare item details in minicart with PDP  5
    Click on View Bag from minicart
    Check shipping method icon  Delivery
    Compare item details in cart with minicart
    Verify order summary in correct in cart page
    Generate Timestamp Email
   IF   '${shopLocale}' in ['US','CN']
    Click on Checkout button from Cart page
    Compare item details in cart with checkout
    Click on Continue To Payment button
    Sleep  5s
    Enter text in shipping address       123
    Sleep  5s
    Select suggestion number    2
    Generate Timestamp Email
    Fill in the remaining Shipping details    ${guest_valid}    ${FIRST_NAME}   ${LAST_NAME}    ${PHONE}
    Check that the default Delivery Method is selected    2-day
    Check delivery date for the shipping method  2-day
    Click on Continue To Payment button
    Select an Address from Address Suggestion modal    suggested
    Check that Credit Card payment option is preselected and expanded
    Check that Billing Same As Shipping checkbox is selected by default
    Enter payment details    ${amex_number}    ${card_exp}    ${amex_csv}    ${card_holder}
    Click on Place Order CTA for payment    cc
    Order Confirmation page is displayed
   END
   IF    '${shopLocale}' in ['UK','FR','GR','IT']
    Click on Checkout button from Cart page for EU
    Click checkout as guest button
    Verify if Order Summary data is correct for EU    5    1
    Enter valid Shipping details for EU    ${guest_valid}    ${FIRST_NAME}   ${LAST_NAME}   ${ADDRESS}   ${ADDRESS2}   ${ZIP}   ${PHONE}  ${CITY}
    Enter payment details for EU    ${amex_number}    ${card_exp}    ${amex_csv}    ${card_holder}
    Click on Place Order CTA for payment for EU    cc
    Order Confirmation page is displayed for EU
   END

Checkout with Credit Card Discover
    [Documentation]    This test case focuses on the guest user's purchase journey for a simple product with 2-day
    ...                delivery, specifically using a Discover credit card for payment. The test includes steps such
    ...                as navigating through the product details page (PDP), accessing the cart, entering shipping
    ...                information, validating the shipping address step, handling promo codes and gift cards,
    ...                adjusting billing preferences, and completing the purchase with payment using a Discover card.

    [Tags]   Guest    CreditCard    Checkout
    Search for a product from header search  883932208184 
    Click search icon from header search
    Close the Get the First Look modal
    Open the Product from PLP product list  1
    Select Size    5
    Capture product price from PDP
    Capture product primary name from PDP
    Capture product secondary name from PDP
    Save the product subtitle on PDP
    Sleep  2s
    Click Add To Cart Button from PDP
    Click on My Bag
    Check shipping method group title in minicart  Delivery
    Compare item details in minicart with PDP  5
    Click on View Bag from minicart
    Check shipping method icon  Delivery
    Compare item details in cart with minicart
    Verify order summary in correct in cart page
    Generate Timestamp Email
   IF   '${shopLocale}' in ['US','CN']
    Click on Checkout button from Cart page
    Compare item details in cart with checkout
    Enter valid Shipping details    ${guest_valid}    ${FIRST_NAME}   ${LAST_NAME}   ${ADDRESS}   ${ADDRESS2}   ${ZIP}   ${PHONE}
    Check that the default Delivery Method is selected    2-day
    Check delivery date for the shipping method  2-day
    Click on Continue To Payment button
    Select an Address from Address Suggestion modal    entered
    Check that Credit Card payment option is preselected and expanded
    Check that Billing Same As Shipping checkbox is selected by default
    Expand the Promo Code section
    Click on Add Promo Code button
    Verify the Empty field validation message for Promo Code
    Expand the Redeem Gift Card section
    Click on Apply button
    Verify the Empty fields validation messages for Gift Card
    Verify the invalid fields validation message for Gift Card
    Check The Gift Card Balances
    Remove the applied gift card
    Select/Unselect Billing Same As Shipping checkbox
    Click on Place Order CTA
    Verify the Empty fields validation messages for Credit Card section
    Verify the Empty fields validation messages for Billing Address section
    Select/Unselect Billing Same As Shipping checkbox
    Verify the invalid fields validation for Credit Card section
    Enter payment details    ${discover_number}    ${card_exp}    ${csv}    ${card_holder}
    Click on Place Order CTA for payment    cc
    Order Confirmation page is displayed
   END
   IF    '${shopLocale}' in ['UK','FR','GR','IT']
    Click on Checkout button from Cart page for EU
    Click checkout as guest button
    Verify if Order Summary data is correct for EU    5    1
    Enter valid Shipping details for EU    ${guest_valid}    ${FIRST_NAME}   ${LAST_NAME}   ${ADDRESS}   ${ADDRESS2}   ${ZIP}   ${PHONE}  ${CITY}
    Enter payment details for EU    ${amex_number}    ${card_exp}    ${amex_csv}    ${card_holder}
    Click on Place Order CTA for payment for EU    cc
    Order Confirmation page is displayed for EU
   END

Checkout with Credit Card - AMEX and Tax Calculation
    [Documentation]    This test case validates the entire purchase process for a guest user buying a simple product
    ...                with 2-day delivery. The focus is on the Order Review phase and tax calculation, particularly
    ...                when using an American Express (AMEX) credit card. Key steps include navigating through the
    ...                product details page (PDP), capturing product information, accessing the cart, entering shipping
    ...                details, reviewing orders, changing shipping details for different states, applying promo codes,
    ...                and completing the purchase using an AMEX card.
    [Tags]   Guest    CreditCard    OrderReview    TaxCalculation    Checkout
   Skip If    '${shopLocale}' in ['UK','FR','GR','IT']
    Search for a product from header search  R09500 SS7
    Click search icon from header search
    Close the Get the First Look modal
    Open the Product from PLP product list  1
    Select Size    5
    Capture product price from PDP
    Capture product primary name from PDP
    Capture product secondary name from PDP
    Save the product subtitle on PDP
    Sleep  2s
    Click Add To Cart Button from PDP
    Click on My Bag
    Check shipping method group title in minicart  Delivery
    Compare item details in minicart with PDP  5
    Click on View Bag from minicart
    Check shipping method icon  Delivery
    Compare item details in cart with minicart
    Verify order summary in correct in cart page
    Generate Timestamp Email
    IF   '${shopLocale}' in ['US','CN']
    Click on Checkout button from Cart page
    Compare item details in cart with checkout
    Enter valid Shipping details    ${guest_valid}    ${FIRST_NAME}   ${LAST_NAME}   ${ADDRESS}   ${ADDRESS2}   ${ZIP}   ${PHONE}
    Check that the default Delivery Method is selected  2-day
    Click on Continue To Payment button
    Select an Address from Address Suggestion modal    suggested
    END
    IF   '$shopLocale' in ['US']
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
    END
    IF   '$shopLocale' in ['CN']
    Check that the correct tax was applied for state    California
    Sleep  2s
    Click on Edit Shipping link from Payment step
    Change the state and zip    Ontario    K0C 9Z9
    Click on Continue To Payment button
    Select an Address from Address Suggestion modal    entered
    Check that the correct tax was applied for state cn   Ontario
    Sleep  2s
    Click on Edit Shipping link from Payment step
    Change the state and zip    Ottawa    K4A 9Z9
    Click on Continue To Payment button
    Check that the correct tax was applied for state cn   Ontario
    Click on Continue To Payment button
    Select an Address from Address Suggestion modal    entered
    Check that the correct tax was applied for state cn   Ontario
    END
    Verify if Order Summary data is correct    5    1
    Enter payment details    ${amex_number}    ${card_exp}    ${amex_csv}    ${card_holder}
    Expand the Promo Code section
    Enter a valid promo code    Product
    Click on Add Promo Code button
    Verify the successful promo code message
    Extract Coupon Amount
    Check if Subtotal was updated with promo code discount
    Click on Place Order CTA for payment    cc
    Order Confirmation page is displayed


Checkout with Credit Card - PayPal Checkout Page
    [Documentation]    This test case verifies the guest user's purchase process for a simple product with 2-day
    ...                delivery, specifically utilizing PayPal for payment. The test involves actions such as navigating
    ...                through the product details page (PDP), accessing the cart, entering shipping information,
    ...                validating the shipping cost, selecting PayPal as the payment method, logging into PayPal, and
    ...                completing the order using PayPal.
    [Tags]    Guest    Shipping     PayPal    Checkout
    Search for a product from header search  883932208184 
    Click search icon from header search
    Close the Get the First Look modal
    Open the Product from PLP product list  1
    Select Size    5
    Capture product price from PDP
    Capture product primary name from PDP
    Capture product secondary name from PDP
    Save the product subtitle on PDP
    Sleep  2s
    Click Add To Cart Button from PDP
    Click on My Bag
    Check shipping method group title in minicart  Delivery
    Compare item details in minicart with PDP  5
    Click on View Bag from minicart
    Check shipping method icon  Delivery
    Compare item details in cart with minicart
    Verify order summary in correct in cart page
    Generate Timestamp Email
    IF   '${shopLocale}' in ['US','CN']
    Click on Checkout button from Cart page
    Compare item details in cart with checkout
    Enter valid Shipping details    ${guest_valid}    ${FIRST_NAME}   ${LAST_NAME}   ${ADDRESS}   ${ADDRESS2}   ${ZIP}   ${PHONE}
    Select Delivery    2-day
    Check delivery date for the shipping method  2-day
    Check if the Shipping cost was update in the Summary
    Click on Continue To Payment button
    Select an Address from Address Suggestion modal    entered
    Select the PayPal payment method
    Sleep  2s
    Log into PayPal
    On Paypal Account click on Save and Continue
    Click on Place Order CTA for payment    paypal
    Order Confirmation page is displayed
    END
    IF    '${shopLocale}' in ['UK','FR','GR','IT']
    Click checkout as guest button
    Verify if Order Summary data is correct    5    1
    Enter valid Shipping details for EU    ${guest_valid}    ${FIRST_NAME}   ${LAST_NAME}   ${ADDRESS}   ${ADDRESS2}   ${ZIP}   ${PHONE}  ${CITY}
    Click on Place Order CTA for payment for EU  paypal
    Log into PayPal
    On Paypal Account click on complete purchase
    Order Confirmation page is displayed
    END

Guest User/Simple Product/ Deliver to address/ 2Day Delivery/ PayPal Express from Cart
    [Documentation]    Verifies the guest user's streamlined purchase process using PayPal Express directly from the
    ...                cart. Steps include navigating through the product details page (PDP), accessing the cart,
    ...                initiating PayPal Express from the cart page, logging into PayPal, and completing the order
    ...                with PayPal.
    [Tags]    Guest    PayPalExpress    Checkout
    Skip If    '${shopLocale}' in ['UK','FR','GR','IT']
    Search for a product from header search  BC0100MSS
    Click search icon from header search
    Close the Get the First Look modal
    Open the Product from PLP product list  1
    Select Size    S
    Sleep  2s
    Capture product price from PDP
    Capture product primary name from PDP
    Capture product secondary name from PDP
    Click Add To Cart Button from PDP
    Click on My Bag
    Click on View Bag from minicart
    Click on Paypal button from Page    cart
    Log into PayPal
    On Paypal Account click on Save and Continue
    Click on Place Order CTA for payment    paypal
    Order Confirmation page is displayed

Guest User/Simple Product/ Deliver to address/ 2Day Delivery/ PayPal Express from Identification Page
    [Documentation]    Validates the guest user's purchase flow for a simple product with 2-day delivery, utilizing
    ...                PayPal Express directly from the identification page. Steps include navigating through the
    ...                product details page (PDP), accessing the cart, proceeding to checkout, initiating PayPal Express
    ...                from the identification page, logging into PayPal, and completing the order using PayPal.
    [Tags]    Guest    PayPalExpress    Checkout
    Skip If    '${shopLocale}' in ['UK','FR','GR','IT']
    Search for a product from header search  BC0100MSS
    Click search icon from header search
    Close the Get the First Look modal
    Open the Product from PLP product list  1
    Select Size    XS
    Sleep  2s
    Capture product price from PDP
    Capture product primary name from PDP
    Capture product secondary name from PDP
    Click Add To Cart Button from PDP
    Click on My Bag
    Click on View Bag from minicart
    Click on Checkout button from Cart page
    Click on Paypal button from Page    identification
    Log into PayPal
    On Paypal Account click on Save and Continue
    Click on Place Order CTA for payment    paypal
    Order Confirmation page is displayed

Guest User/Simple Product/ Deliver to address/ Overnight Delivery/ Affirm
    [Documentation]    Validates the guest user's purchase journey for a simple product with overnight delivery,
    ...                utilizing the Affirm payment method. Steps include navigating through the product details page
    ...                (PDP), accessing the cart, selecting overnight delivery, entering shipping details, reviewing the
    ...                order, choosing Affirm as the payment method, interacting with the Affirm Checkout modal,
    ...                selecting a payment plan, verifying identity, and completing the order with confirmation on the
    ...                Order Confirmation page.
    [Tags]    Guest    Shipping     OrderReview    Affirm    Checkout
    Skip If    '${shopLocale}' in ['UK','FR','GR','IT']
    Search for a product from header search  BC0100MSS
    Click search icon from header search
    Close the Get the First Look modal
    Open the Product from PLP product list  1
    Select Size    S
    Sleep  2s
    Capture product price from PDP
    Capture product primary name from PDP
    Capture product secondary name from PDP
    Click Add To Cart Button from PDP
    Click on My Bag
    Click on View Bag from minicart
    Click on Checkout button from Cart page
    Generate Timestamp Email
    Enter valid Shipping details    ${guest_valid}    ${FIRST_NAME}   ${LAST_NAME}   ${ADDRESS}   ${ADDRESS2}   ${ZIP}   ${PHONE}
    Select Delivery    Overnight
    Check delivery date for the shipping method  Overnight
    Check if the Shipping cost was update in the Summary
    Click on Continue To Payment button
    Select an Address from Address Suggestion modal    entered
    Select the Affirm payment method
    Check that the Affirm Checkout modal is displayed
    Enter and submit the phone number on Affirm Checkout modal
    Enter Affirm PIN within the "We just texted you" modal
    Choose and Affirm payment plan for number of months    3
    Click on Choose This Affirm Plan button
    Run Keyword And Ignore Error    Verify identity on Affirm Payment Plan modal
    Agree to DY policy on Affirm Review And Pay modal
    Confirm the Affirm payment
    Order Confirmation page is displayed

Checkout a 0$ item
    [Documentation]    Validates the checkout process for a $0 item as a guest user. Steps include opening the product
    ...                details page (PDP), accessing the cart, proceeding to checkout, entering shipping details,
    ...                selecting standard delivery, confirming the address, and completing the order for a $0 item,
    ...                resulting in the display of the Order Confirmation page.
    [Tags]   Guest    ZeroDollarOrder    Checkout
    Skip If    '${shopLocale}' in ['UK','FR','GR','IT']
    Search for a product from header search  192740696091
    Click search icon from header search
    Close the Get the First Look modal
    Open the Product from PLP product list  1
    Click Add To Cart Button from PDP
    Click on My Bag
    Click on View Bag from minicart
    Click on Checkout button from Cart page
    Generate Timestamp Email
    Enter valid Shipping details    ${guest_valid}    ${FIRST_NAME}   ${LAST_NAME}   ${ADDRESS}   ${ADDRESS2}   ${ZIP}   ${PHONE}
    Select Delivery    Standard
    Click on Continue To Payment button
    Select an Address from Address Suggestion modal    entered
    Click on Place Order CTA for payment    zero_order
    Order Confirmation page is displayed

Checkout a non SKU merch item
    [Documentation]    Validates the checkout process for a non-SKU merchandise item as a guest user. Steps include
    ...                opening the product details page (PDP), accessing the cart, proceeding to checkout, entering
    ...                shipping details, selecting USPS delivery, confirming the address, entering payment details,
    ...                and completing the order for the non-SKU merch item, resulting in the display of the Order
    ...                Confirmation page.
    [Tags]   Guest    nonSKUmerch    Checkout
    Skip If    '${shopLocale}' in ['UK','FR','GR','IT']
    Search for a product from header search  883932208184
    Click search icon from header search
    Close the Get the First Look modal
    Capture product price from PDP
    Capture product primary name from PDP
    Capture product secondary name from PDP
    Click Add To Cart Button from PDP
    Click on My Bag
    Click on View Bag from minicart
    Click on Checkout button from Cart page
    Generate Timestamp Email
    Enter valid Shipping details    ${guest_valid}    ${FIRST_NAME}   ${LAST_NAME}   ${ADDRESS}   ${ADDRESS2}   ${ZIP}   ${PHONE}
    Select Delivery    Standard
    Click on Continue To Payment button
    Select an Address from Address Suggestion modal    entered
    Enter payment details    ${visa_number}    ${card_exp}    ${csv}    ${card_holder}
    Click on Place Order CTA for payment    cc
    Order Confirmation page is displayed

Logged In User/Simple Product/ Deliver to address/ 2Day Delivery/ Affirm
    [Documentation]    Validates the purchase process for a logged-in user ordering a simple product with 2-day delivery,
    ...                utilizing the Affirm payment method. Steps include navigating through the product details page
    ...                (PDP), accessing the cart, signing in during checkout, selecting 2-day delivery, entering shipping
    ...                details, choosing Affirm as the payment method, interacting with the Affirm Checkout modal,
    ...                selecting a payment plan, verifying identity, and completing the order with confirmation on the
    ...                Order Confirmation page.
    [Tags]    LoggedIn    Shipping     OrderReview    Affirm    Checkout
    Skip If    '${shopLocale}' in ['UK','FR','GR','IT']
    Search for a product from header search  BC0100MSS
    Click search icon from header search
    Close the Get the First Look modal
    Open the Product from PLP product list  1
    Select Size    XS
    Sleep  2s
    Capture product price from PDP
    Capture product primary name from PDP
    Capture product secondary name from PDP
    Click Add To Cart Button from PDP
    Click on My Bag
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
    Enter and submit the phone number on Affirm Checkout modal
    Enter Affirm PIN within the "We just texted you" modal
    Choose and Affirm payment plan for number of months    3
    Click on Choose This Affirm Plan button
    Verify identity on Affirm Payment Plan modal
    Agree to DY policy on Affirm Review And Pay modal
    Confirm the Affirm payment
    Order Confirmation page is displayed

Logged In User/Pre-Order Product/ Deliver to address/ Overnight Delivery/ Gift Message/ Discover CC
    [Documentation]    Validates the purchase process for a logged-in user ordering a pre-order product with overnight
    ...                delivery, utilizing a Discover credit card. Steps include navigating through the product details
    ...                page (PDP), accessing the cart, signing in during checkout, adding a gift message, verifying the
    ...                gift message preview, selecting overnight delivery, validating shipping information, confirming
    ...                unavailable payment options for pre-order, entering payment details with a Discover card, and
    ...                completing the order with confirmation on the Order Confirmation page.
    [Tags]    LoggedIn    Shipping     OrderReview    PreOrder    Checkout
    Skip If    '${shopLocale}' in ['UK','FR','GR','IT']
    Search for a product from header search  R14202DSS
    Click search icon from header search
    Close the Get the First Look modal
    Open the Product from PLP product list  1
    Select Color    AMETHYST
    Select Size    9
    Sleep  2s
    Capture product price from PDP
    Capture product primary name from PDP
    Capture product secondary name from PDP
    Check that the button label is Pre-Order
    Click Add To Cart Button from PDP
    Click on My Bag
    Click on View Bag from minicart
    Click on Checkout button from Cart page
    Sign in during checkout
    Click on Add Gift Message CTA
    Check that the Gifting Image is visible
    Fill in the Gifting Form from Shipping step    unu    doi    trei
    Click on Preview Gift Message from Shipping step and verify the entered texts
    Select Delivery    Overnight
    Click on Continue To Payment button
    Select an Address from Address Suggestion modal    entered
    Verify that the shipping information is correct on Payment page    ${REGISTERED_email}    ${Reg_FIRST_NAME}   ${Reg_LAST_NAME}   ${Reg_ADDRESS}   ${ADDRESS2}   ${ZIP}   ${PHONE}
    Verify that the shipping method is correct on Payment page    Overnight
    Check that PayPal and affirm payment options are not listed when buying preorder items
    Click on Continue To Payment button
    Select an Address from Address Suggestion modal    entered
    Click on Add New Card
    Enter payment details    ${discover_number}    ${card_exp}    ${csv_discover}    ${card_holder}
    Click on Place Order CTA for payment    cc
    Order Confirmation page is displayed

Check Virtual GC Purchase
    [Documentation]    Validates the process of purchasing a virtual gift card as a guest user. Steps include opening
    ...                the gift card product details page (PDP), selecting an amount, filling out the virtual gift card
    ...                details, adding it to the cart, navigating through the cart and checkout process, checking
    ...                virtual gift card fields during checkout, entering payment details, verifying address suggestions,
    ...                completing billing details, and placing the order with a credit card.
    [Tags]    Guest    Shipping     OrderReview    Affirm  GiftCard    Checkout
    Skip If  '${shopLocale}' in ['UK','FR','GR','IT']
    Open Gift Card PDP
    Close the Get the First Look modal
    Select Amount Gift Card PDP      1
    Fill Virtual GC PDP
    Click Add To Cart Button from PDP
    Click on My Bag
    Click on View Bag from minicart
    Click on Checkout button from Cart page
    Check VGC fields on the checkout
    Enter Gift message
    Enter payment details    ${visa_number}    ${card_exp}    ${csv}    ${card_holder}
    Enter text in Billing address       123
    Sleep  5s
    Select suggestion number    2
    Sleep  5s
    Generate Timestamp Email
    Fill in the remaining Billing details    ${guest_valid}    ${FIRST_NAME}   ${LAST_NAME}    ${PHONE}
    Click on Place Order CTA for payment    cc
    IF    '${shopLocale}' in ['UK','FR','GR','IT']
    Click checkout as guest button
    Enter valid Shipping details for EU    ${guest_valid}    ${FIRST_NAME}   ${LAST_NAME}   ${ADDRESS}   ${ADDRESS2}   ${ZIP}   ${PHONE}  ${CITY}
    Enter payment details for EU    ${visa_number}    ${card_exp}    ${csv}    ${card_holder}
    Verify if Order Summary data is correct    M    1
    Click on Place Order CTA for payment    cc
    Order Confirmation page is displayed
    END

Check Physical GC Purchase
    [Documentation]    Validates the process of purchasing a physical gift card as a guest user. Steps include opening
    ...                the gift card product details page (PDP), selecting an available physical gift card, adding it
    ...                to the cart, navigating through the cart and checkout process, verifying address suggestions,
    ...                completing shipping details, checking the default delivery method, proceeding to payment,
    ...                selecting an address, checking payment options, verifying default billing settings, entering
    ...                payment details, and placing the order with a credit card.
    [Tags]    Guest    CreditCard  GiftCard    Checkout
    Skip If  '${shopLocale}' in ['UK','FR','GR','IT']
    Open Gift Card PDP    False
    Close the Get the First Look modal
    Select an Available Physical Gift Card PDP
    Scroll To Top
    Click Add To Cart Button from PDP
    Click on My Bag
    Click on View Bag from minicart
    Click on Checkout button from Cart page
    Click on Continue To Payment button
    Enter text in shipping address       123
    Verify the address suggestions are displayed
    Select suggestion number    2
    Generate Timestamp Email
    Fill in the remaining Shipping details    ${guest_valid}    ${FIRST_NAME}   ${LAST_NAME}    ${PHONE}
    Check that the default Delivery Method is selected    2-day
    Click on Continue To Payment button
    Select an Address from Address Suggestion modal    suggested
    Check that Credit Card payment option is preselected and expanded
    Check that Billing Same As Shipping checkbox is selected by default
    Enter payment details    ${amex_number}    ${card_exp}    ${amex_csv}    ${card_holder}
    Click on Place Order CTA for payment    cc


Guest User/Simple Product/ Deliver to address/ 2Day Delivery/ PayPal Express from Mini Cart
    [Tags]  DY
    Skip If  '${shopLocale}' in ['UK','FR','GR','IT']
    Search for a product from header search  B13779 SS
    Click search icon from header search
    Sleep  5s
    Close the Get the First Look modal
    Open the Product from PLP product list  1
    Select Size    L
    Click Add To Cart Button from PDP
    Click on Paypal button from Page    minicart
    Log into PayPal
    On Paypal Account click on Save and Continue
    Click on Place Order CTA for payment    paypal
    Order Confirmation page is displayed

Check Multiple BOPIS
    [Documentation]    Validates the Buy Online, Pick Up In Store (BOPIS) functionality for a guest user purchasing
    ...                multiple items. The test involves opening the product details page (PDP), selecting size, opening
    ...                the BOPIS modal, choosing an available store, adding the item to the cart, opening the BOPIS modal
    ...                again, selecting another store, adding the item to the cart, proceeding to checkout, entering valid
    ...                store pickup guest details, entering payment and billing details, and placing the order. Note that
    ...                the test is currently skipped until products with perpetual inventory are available.
    [Tags]    Guest    CreditCard  BOPIS    Checkout  RUNME
    Skip If  '${shopLocale}' in ['UK','FR','GR','IT']
    Open PDP for product with id    R15752MBB
    Close the Get the First Look modal
    Select Size    5
    Sleep  2s
    Open BOPIS modal
    IF    '${shopLocale}' in ['US']
    Select available store at       92626
    Click Add To Cart Button from PDP
    Close the minicart
    Open BOPIS modal
    Select available store at       92628
    END
    IF    '${shopLocale}' in ['CN']
    Select available store at       AB T2P 4H9
    Click Add To Cart Button from PDP
    Close the minicart
    Open BOPIS modal
    Select available store at       T9V 4N6
    END
    Click Add To Cart Button from PDP
    Sleep  3s
    Click on My Bag
    Click on View Bag from minicart
    Click on Checkout button from Cart page
    Sleep  3s
    Enter valid Shipping details    ${GUEST_email}    ${FIRST_NAME}   ${LAST_NAME}   ${ADDRESS}   ${ADDRESS2}   ${ZIP}   ${PHONE}
    Click on Continue To Payment button
    Select an Address from Address Suggestion modal    suggested
    Sleep  2s
    Enter payment details    ${visa_number}    ${card_exp}    ${csv}    ${card_holder}
    Check that Billing Same As Shipping checkbox is selected by default
    Click on Place Order CTA for payment    cc
    Order Confirmation Pickup Store page is displayed
    Order Confirmation Billing Information page is displayed

Check BOPIS + Delivery
    [Documentation]    Validates the Pick Up In Store (BOPIS) functionality combined with delivery for a guest user. The
    ...                test involves opening the product details page (PDP), selecting size, opening the BOPIS modal,
    ...                choosing an available store, adding the item to the cart, selecting another size, selecting address
    ...                pickup, adding the item to the cart, proceeding to checkout, entering valid shipping details, adding
    ...                a gift message, continuing to payment, selecting an address, checking billing details, checking the
    ...                billing data is same as shipping, entering payment details, and placing the order. The Order
    ...                Confirmation page, Pickup Store page, and Billing Information page are displayed.
    [Tags]    Guest    CreditCard  BOPIS    Checkout
    Skip If  '${shopLocale}' in ['UK','FR','GR','IT']
    Open PDP for product with id    R15752MBB
    Close the Get the First Look modal
    Open the Product from PLP product list  1
    Select Size    5
    Sleep  2s
    IF    '${shopLocale}' in ['US']
    Select available store at       92626
    Click Add To Cart Button from PDP
    Close the minicart
    Open BOPIS modal
    Select available store at       92628
    END
    IF    '${shopLocale}' in ['CN']
    Select available store at       AB T2P 4H9
    Click Add To Cart Button from PDP
    Close the minicart
    Open BOPIS modal
    Select available store at       T9V 4N6
    Close the minicart
    Select Size    6
    Select Address Pickup
    END
    Click Add To Cart Button from PDP
    Sleep  3s
    Click on My Bag
    Click on View Bag from minicart
    Click on Checkout button from Cart page
    Sleep  3s
    Enter valid Shipping details    ${GUEST_email}    ${FIRST_NAME}   ${LAST_NAME}   ${ADDRESS}   ${ADDRESS2}   ${ZIP}   ${PHONE}
    Click on Add Gift Message CTA
    Fill in the Gifting Form from Shipping step    unu    doi    trei
    Click on Continue To Payment button
    Select an Address from Address Suggestion modal    entered
    Check that Billing Same As Shipping checkbox is selected by default
    Select/Unselect Billing Same As Shipping checkbox
    Enter payment details    ${visa_number}    ${card_exp}    ${csv}    ${card_holder}
    Click on Place Order CTA for payment    cc
    Order Confirmation page is displayed
    Order Confirmation Pickup Store page is displayed
    Order Confirmation Billing Information page is displayed