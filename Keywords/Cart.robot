*** Settings ***
Library           SeleniumLibrary    screenshot_root_directory=EMBED
Resource          ../Resources/Locators.robot
Resource          ../Keywords/CommonWeb.robot
Resource          ../Keywords/PDP.robot
*** Keywords ***
Hover over My Bag
    Mouse Over    ${minicart_icon_l}

Click on My Bag
    ${minicart_already_opened}    Run Keyword And Return Status    Element Should Be Visible    ${minicart_close_l}
    IF    "${minicart_already_opened}" == "True"
        Close the minicart
    END
    Click Element    ${minicart_icon_l}
   # Wait Until Element Is Visible    ${minicart_close_l}    10s    error=Minicart is not visible

Click on View Bag from minicart
    Click Element    ${minicart_view_bag_l}
    Wait Until Page Contains Element    ${cart_page_data_action_l}    10s    error=Cart Page is not visible

Close the minicart
    Click Element    ${minicart_close_l}
    Wait Until Element Is Not Visible    ${minicart_close_l}    10s    error=Minicart is still visible

Close the empty minicart
    Click Element    ${minicart_empty_close_l}
    Wait Until Element Is Not Visible    ${minicart_empty_close_l}    10s    error=Minicart is still visible


Click on Checkout button from Cart page
    Execute Javascript    window.scrollTo(0,document.body.scrollHeight/2)
    CommonWeb.Click by JS    ${cart_checkout_l}

Click on Chekout button from Minicart modal
    Scroll Element Into View    ${cart_checkout_l}

Submit the empty Promo Code field from Cart page and check the error message
    Press Keys    ${cart_coupon_input_l}    CONTROL+A DELETE
    CommonWeb.Check and Click    ${cart_coupon_submit_l}
    Wait Until Element Is Visible    ${cart_coupon_err_l}    10s    error=Promo Code Error Message is not visible
    Run Keyword And Warn On Failure    Element Text Should Be    ${cart_coupon_err_l}    ${cart_coupon_err}

Remove all products from the Cart
    Retreive the number of items in the cart
    ${elements_in_cart}    Run Keyword And Return Status    Page Should Contain Element    ${cart_rem_prod_one_l}
    IF    "${elements_in_cart}" == "True"
        FOR    ${i}    IN RANGE    1    ${minicart_nr_of_items}+1
            Check and Click    css:.card:nth-child(${i}) .d-none .remove-product
        END
    END
    Wait Until Element Is Not Visible    ${cart_rem_prod_one_l}     5s     error=Remove CTA is still visible

Check empty Cart message
    Wait Until Page Contains Element     ${home_empty_minicart_l}     5s     error=Empty Minicart is not loaded
    Wait Until Element Is Visible     ${home_empty_minicart_l}     5s     error=Empty Minicart is not visible
    Run Keyword And Warn On Failure    Element Text Should Be    ${home_empty_minicart_l}    ${home_empty_minicart_exp}

Check the elements of the Cart page
    Retreive the number of items in the cart
    FOR    ${nr}    IN RANGE    1    ${minicart_nr_of_items}+1
        Element Should Be Visible    css:.card:nth-child(${nr}) .line-item-primary-title
        Element Should Be Visible    css:.card:nth-child(${nr}) .d-none .line-item-total-price-amount
    END

Check Cart Subtotal after promo code is applied
    Run Keyword And Warn On Failure    Element Should Contain     ${cart_grand_total_l}    ${expected_subtotal}

Click on first Edit link from Cart
    Scroll Element Into View    ${cart_quick_edit_l}
    Click by JS    ${cart_quick_edit_l}
    Wait Until Page Contains Element    ${cart_quick_edit_show_l}     5s     error=Quick Edit modal is not loaded
    Wait Until Element Is Visible    ${cart_quick_edit_show_l}     5s     error=Quick Edit modal is not visible

Modify the Size of the first product from the cart
    [Arguments]    ${size_to_update}
    Click Element    css:button[data-attr-value="${size_to_update}"]
    Set Test Variable    ${size_to_update}
    Sleep    2s

Click on Update button from Update Product modal
    Click Element    css:.edit-button-cart
    Sleep  10s
    Wait Until Element Is Not Visible    ${cart_quick_edit_show_l}     5s     error=Quick Edit modal is still visible

Verify if the size was modified in the Cart
    Element Text Should Be    ${cart_size_prod_one_l}    ${size_to_update}

Click on Move to Wishlist link from the Cart and verify if the product was added to Wishlist
    Retrieve the number of items before removal
    Scroll Element Into View    ${cart_wish_prod_one_l}
    Click by JS    ${cart_wish_prod_one_l}
    Wait until success message is displayed in Cart
    Retreive the number of items in the cart
    Check if the quantity was decreased

Remove the first item from the Cart
    Retrieve the number of items before removal
    Scroll Element Into View    ${cart_rem_prod_one_l}
    Click by JS    ${cart_rem_prod_one_l}
    Wait until success message is displayed in Cart
    Retreive the number of items in the cart
    Check if the quantity was decreased

Wait until success message is displayed in Cart
    Wait Until Page Contains Element    ${cart_success_msg_l}     5s     error=Success Message is not loaded
    Wait Until Element Is Visible    ${cart_success_msg_l}     5s     error=Success Message is not visible

Update the quantity of the first item from the Cart
    Scroll Element Into View    ${cart_plus_qty_l}
    Sleep  5s
    Click by JS    ${cart_plus_qty_l}
    Wait Until Page Contains Element    ${cart_qty_input_l}     10     error=Product Quantity is not loaded
    Wait Until Element Is Visible    ${cart_qty_input_l}     10     error=Product Quantity is not visible
    Run Keyword And Warn On Failure    Element Attribute Value Should Be    ${cart_qty_input_l}    value    2

Check if the quantity was decreased
    ${expected_nr_of_items}    Evaluate    ${total_items_before_remove}-1
    Sleep    5s
    Element Text Should Be    ${minicart_nr_of_items_l}    ${expected_nr_of_items}

Retreive the number of items in the cart
    ${minicart_nr_of_items}    Check and Get text    ${minicart_nr_of_items_l}
    Set Test Variable    ${minicart_nr_of_items}

Retrieve the number of items before removal
    ${total_items_before_remove}    Set Variable    ${minicart_nr_of_items}
    Set Test Variable    ${total_items_before_remove}

Return to Cart
    Check and Click    ${shipping_back_to_cart_l}
    Wait Until Page Contains Element    ${cart_page_data_action_l}     5s     error=Cart Body is not loaded
    Wait Until Element Is Visible    ${cart_page_title_l}     5s     error=Cart Title is not visible

Check Minicart elements
    Wait Until Element Is Visible    ${minicart_title_l}     5s     error=Minicart Title is not visible
    Wait Until Element Is Visible    ${minicart_prod_img_l}     5s     error=Minicart Product Image is not visible
    Wait Until Element Is Visible    ${minicart_view_cart_l}     5s     error=Minicart View Cart Button is not visible
    Wait Until Element Is Visible    ${minicart_checkout_btn_l}     5s     error=Minicart Checkout Button is not visible

Check if product price and total price is correct
    Run Keyword And Warn On Failure     Element Should Contain    ${minicart_price_line_l}    ${expected_subtotal}
    Run Keyword And Warn On Failure     Element Should Contain    ${minicart_subtotal_price_l}    ${subtotal_without_currency}


Capture product price from MiniCart

    ${miniCart_product_price_1}    Get Text    xpath://div[contains(@class,'line-item-total-price-amount')]
    Set Global Variable  ${miniCart_product_price}   ${miniCart_product_price_1}

Capture product primary name from MiniCart
    Scroll Element Into View    xpath://div[@class='line-item-header line-item-primary-title']/a
    ${miniCart_product_primary_name}    Get Text    xpath://div[@class='line-item-header line-item-primary-title']/a
    Set Global Variable   ${miniCart_product_primary_name}   ${miniCart_product_primary_name}


Capture product secondary name from MiniCart
    Scroll Element Into View    xpath://div[@class='line-item-header line-item-secondary-title ']/a
    ${miniCart_product_secondary_name}    Get Text    xpath://div[@class='line-item-header line-item-secondary-title ']/a
    Set Global Variable   ${miniCart_product_secondary_name}     ${miniCart_product_secondary_name}

Capture product quantity in minicart
    Scroll Element Into View     xpath:(//input[contains(@class,'quantity js-qty')])[1]
    ${minicart_product_quantity}  Get Text    xpath:(//input[contains(@class,'quantity js-qty')])[1]
    Set Global Variable    ${minicart_product_quantity}   ${minicart_product_quantity}

Compare item details in minicart with PDP
     [Arguments]  ${size}
     Capture product price from minicart
     Capture product primary name from minicart
     Capture product secondary name from MiniCart
     Check product size in minicart  ${size}
     Run Keyword And Warn On Failure     Should Be Equal As Strings    ${miniCart_product_price}    ${PDP_product_price}
     Run Keyword And Warn On Failure     Should Be Equal As Strings    ${miniCart_product_primary_name}    ${PDP_product_primary_name}
     Run Keyword And Warn On Failure     Should Be Equal As Strings    ${miniCart_product_secondary_name}    ${PDP_product_secondary_name}
     Run Keyword And Warn On Failure     Element Should Contain    xpath://div[@class='sub-total-title']    Total
     Run Keyword And Warn On Failure     Element Should Contain    xpath://div[@class='sub-total']    ${miniCart_product_price}

Capture product price from cart
    Scroll Element Into View    xpath:(//div[contains(@class,'line-item-total-price-amount')])[1]
    ${cart_product_price}    Get Text    xpath:(//div[contains(@class,'line-item-total-price-amount')])[1]
    ${cart_product_price}    Remove currency and comma from price    ${cart_product_price}
    Set Test Variable    ${cart_product_price}    ${cart_product_price}

Capture product primary name from cart
    Scroll Element Into View    xpath://div[@class='line-item-primary-title']
    ${cart_product_primary_name}    Get Text    xpath://div[@class='line-item-primary-title']
    Set Test Variable    ${cart_product_primary_name}    ${cart_product_primary_name}


Capture product secondary name from cart
    Scroll Element Into View    xpath://div[@class='line-item-secondary-title']
    ${cart_product_secondary_name}    Get Text    xpath://div[@class='line-item-secondary-title']
    Set Test Variable    ${cart_product_secondary_name}    ${cart_product_secondary_name}

Capture product quantity in cart
    ${cart_product_quantity}  Get Text    xpath:(//input[contains(@class,'quantity js-qty')])[1]
    Set Test Variable    ${cart_product_quantity}     ${cart_product_quantity}

Compare item details in cart with minicart
     Capture product price from cart
     Capture product primary name from cart
     Capture product secondary name from cart
     Capture product quantity in cart
     Check cart item count
     Run Keyword And Warn On Failure   Should Be Equal As Strings    ${cart_product_price}    ${miniCart_product_price}
     Run Keyword And Warn On Failure   Should Be Equal As Strings    ${cart_product_primary_name}      ${miniCart_product_primary_name}
     Run Keyword And Warn On Failure   Should Be Equal As Strings    ${cart_product_secondary_name}     ${miniCart_product_secondary_name}
     Run Keyword And Warn On Failure   Should Be Equal As Strings    ${cart_product_quantity}     ${minicart_product_quantity}

Verify order summary in correct in cart page
     ${order_summary_subtotal}   Get Text    xpath:(//span[contains(@class,'sub-total')])[1]
     ${order_summary_shipping}   Get Text    xpath:(//p[contains(@class,'text-right order-summary-item-value')])[1]
     ${order_summary_salesTax}   Get Text    xpath:(//p[contains(@class,'text-right order-summary-item-value')])[2]
     Run Keyword And Warn On Failure   Should Be Equal As Strings    ${order_summary_subtotal}    ${cart_product_price}
     Run Keyword And Warn On Failure   Should Be Equal As Strings    ${order_summary_shipping}    Complimentary
     Run Keyword And Warn On Failure   Should Be Equal As Strings    ${order_summary_subtotal}    Calculated at checkout
     
Check shipping method icon
    [Arguments]   ${method}
   IF  '${method}' in ['Delivery']
    Page Should Contain Element    xpath://*[local-name()='svg' and @class='icon icon-delivery-icon icon-delivery-icon-dims ']
   ELSE IF  '${method}' in ['Pick up']
     Page Should Contain Element    xpath://*[local-name()='svg' and @class='icon icon-pickup-in-store-icon icon-pickup-in-store-icon-dims ']
   ELSE IF  '${method}' in ['Pre-Order']
     Page Should Contain Element    xpath://*[local-name()='svg' and @class='icon icon-pre-order-icon icon-pre-order-icon-dims ']
   END

Check cart item count
    ${cart_item_count}    Get Text   xpath:(//span[contains(@class,'js-cart-items-group-count cart-items-group-count')])[3]
    ${cart_item_count}    Remove String    (
    ${cart_item_count}    Remove String    )
    Replace String  ${cart_item_count}    [a-zA-Z]   ${SPACE}
    ${cart_item_count}    Remove String    ${SPACE}
   Run Keyword And Warn On Failure    Should Be Equal As Strings    ${cart_item_count}    ${cart_product_quantity}

Compare item details in cart with checkout
     Capture product price from checkout
     Capture product primary name from checkout
     Capture product secondary name from checkout
     Run Keyword And Warn On Failure  Should Be Equal As Strings    ${checkout_product_price}    ${cart_product_price}
     Run Keyword And Warn On Failure  Should Be Equal As Strings    ${checkout_product_primary_name}      ${cart_product_primary_name}
     Run Keyword And Warn On Failure  Should Be Equal As Strings    ${checkout_product_secondary_name}     ${cart_product_secondary_name}
     
Check shipping method group title in minicart
    [Arguments]  ${shippingMethod}
   IF  '${shippingMethod}' in ['Delivery']
    Page Should Contain Element    xpath://div[@class='js-cart-items-group cart-items-group ship-to-home-items']/h2
    Element Should Contain    xpath://div[@class='js-cart-items-group cart-items-group ship-to-home-items']/h2    Delivery
   ELSE IF  '${shippingMethod}' in ['Pre-Order']
    Page Should Contain Element    xpath://div[@class='js-cart-items-group cart-items-group ship-to-home-items']/h2
    Element Should Contain    xpath://div[@class='js-cart-items-group cart-items-group ship-to-home-items']/h2    Pre-Order
    ELSE IF  '${shippingMethod}' in ['Pick up']
    Page Should Contain Element    xpath://div[@class='cart-items-group-title']/h2
    Element Should Contain    xpath://div[@class='js-cart-items-group cart-items-group ship-to-home-items']/h2   Pick Up In Store
   END

Check product size in minicart
    [Arguments]  ${size}
    Element Should Contain    xpath://div[@class='line-item-attributes']/span[2]    ${size}

Click on Checkout button from Cart page for EU
    Execute Javascript    window.scrollTo(0,document.body.scrollHeight/2)
    CommonWeb.Click by JS    xpath:(//a[@data-event-value='continue_checkout'])[1]

