*** Settings ***
Library           SeleniumLibrary    screenshot_root_directory=EMBED
Resource          ../Resources/Locators.robot
Resource          ../Resources/Locators/CartLocators.robot
Resource          ../Keywords/CommonWeb.robot
Resource          ../Resources/Locators/WishListLocators.robot
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
    Wait Until Element Is Visible    ${minicart_close_l}    10s    error=Minicart is not visible

Access Cart page directly
    Go To    ${PROD_URL}user/shopping-bag
    Wait Until Page Contains    ${cart_checkout_l}  timeout=20s

Click on Checkout button from Cart page
    Scroll Page    0    60
    Scroll Element Into View    ${cart_checkout_l}
    CommonWeb.Click by JS    ${cart_checkout_l}

Click on Chekout button from Minicart modal
    Scroll Element Into View    ${cart_checkout_l}
    Click Element   ${cart_checkout_l}

Click on Add to wishlist button from Cart page
    Click Element   ${add_to_wishlish}

Capture payment summary from cart page
    ${preShippingSubTotal_cart} =  Get text    ${pre_shipping_total_locator_cart}
    ${shipping_charge_cart} =   Get text    ${shipping_charge_locator_cart}
    ${tax_total_cart} =  Get Text  ${tax_total_locatorcart}
    ${sub_total_cart} =  Get Text  ${sub_total_locator_cart}

    Set Test Variable    ${preShippingSubTotal_cart}   ${preShippingSubTotal_cart}
    Set Test Variable    ${shipping_charge_cart}       ${shipping_charge_cart}
    Set Test Variable    ${tax_total_cart}             ${tax_total_cart}
    Set Test Variable    ${sub_total_cart}             ${sub_total_cart}


Click on View Bag from minicart
    Scroll Element Into View    ${minicart_view_bag_l}
    Click Element    ${minicart_view_bag_l}
    Wait Until Page Contains Element    ${cart_page_data_action_l}    10s    error=Cart Page is not visible

Capture item details from cart page
    ${no_of_items_cart} =  Get text    ${no_of_items_locator_cart}
    ${product_primary_title_cart} =  Get text    ${product_primary_title_locator_cart}
    ${product_secondary_title_cart} =  Get text   ${product_secondary_title_locator_cart}
    ${item_size_cart} =  Get text   ${item_size_locator_cart}
    ${item_price_cart} =  Get text   ${item_price_locator_cart}

    Set Test Variable    ${no_of_items_cart}   ${no_of_items_cart}
    Set Test Variable    ${product_primary_title_cart}       ${product_primary_title_cart}
    Set Test Variable    ${product_secondary_title_cart}     ${product_secondary_title_cart}
    Set Test Variable    ${item_size_cart}                   ${item_size_cart}
    Set Test Variable    ${item_price_cart}                  ${item_price_cart}


Capture item details from mini cart
    ${no_of_items_mini_cart} =  Get text    xpath://span[@class='js-minicart-title-qty minicart-title-qty']
    ${product_primary_title_mini_cart} =  Get text    xpath://div[@class='line-item-header line-item-primary-title']/a
    ${product_secondary_title_mini_cart} =  Get text   xpath://div[@class='line-item-header line-item-secondary-title ']/a
    ${item_size_mini_cart} =  Get text   xpath://div[@class='line-item-attributes']/span[2]
    ${item_price_mini_cart} =  Get text  xpath://div[contains(@class,'line-item-total-price-amount')][2]
    ${sub_total_mini_cart} =  Get text   xpath://div[contains(@class,'total')]/div[@class='sub-total']


    Set Test Variable    ${no_of_items_mini_cart}                 ${no_of_items_mini_cart}
    Set Test Variable    ${product_primary_title_mini_cart}       ${product_primary_title_mini_cart}
    Set Test Variable    ${product_secondary_title_mini_cart}     ${product_secondary_title_mini_cart}
    Set Test Variable    ${item_size_mini_cart}                   ${item_size_mini_cart}
    Set Test Variable    ${item_price_mini_cart}                  ${item_price_mini_cart}
    Set Test Variable    ${sub_total_mini_cart}                   ${sub_total_mini_cart}

Compare item details are correct in mini cart and cart page
    Run Keyword And Warn On Failure    Should Be Equal As Strings    ${no_of_items_mini_cart}    ${no_of_items_cart}
    Run Keyword And Warn On Failure    Should Be Equal As Strings    ${product_primary_title_mini_cart}    ${product_primary_title_cart}
    Run Keyword And Warn On Failure    Should Be Equal As Strings    ${product_secondary_title_mini_cart}    ${product_secondary_title_cart}
    Run Keyword And Warn On Failure    Should Be Equal As Strings    ${item_size_mini_cart}    ${item_size_cart}
    Run Keyword And Warn On Failure    Should Be Equal As Strings    ${no_of_items_mini_cart}    ${no_of_items_cart}
    Run Keyword And Warn On Failure    Should Be Equal As Strings    ${item_price_mini_cart}    ${item_price_cart}
    Run Keyword And Warn On Failure    Should Be Equal As Strings    ${sub_total_mini_cart}    ${sub_total_cart}

Close the minicart
    Click Element    ${minicart_close_l}
    Wait Until Element Is Not Visible    ${minicart_close_l}    10s    error=Minicart is still visible

Get product name from cart
   ${cart_product_name} =  Get Text    xpath://div[@class='line-item-primary-title']
   Set Test Variable   ${cart_product_name}

Check whether product is added to cart
   Get product name from cart
   Should Contain Text    ${cart_product_name}    ${product_primary_name}