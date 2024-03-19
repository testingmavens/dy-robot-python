*** Variables ***
##Cart
${minicart_icon_l}                           xpath://span[contains(text(),'My Bag')]
${cart_checkout_l}                           css:#checkout-form a[href*="checkout"]
${cart_coupon_input_l}                       css:#couponCode
${cart_coupon_submit_l}                      css:.promo-code-btn
${cart_title}                                xpath://h1[contains(text(),'Your Bag')]
${pre_shipping_total_locator_cart}          xpath:(//span[@class='sub-total cart-subtotal-text'])[1]
${shipping_charge_locator_cart}             xpath:(//p[@class='text-right order-summary-item-value'])[1]
${tax_total_locatorcart}                    xpath:(//p[@class='text-right order-summary-item-value'])[2]
${sub_total_locator_cart}                   xpath:(//span[@id='grandTotal'])[1]
${no_of_items_locator_cart}                 xpath:(//span[@class='js-cart-items-group-count cart-items-group-count'])[3]
${product_primary_title_locator_cart}       xpath://div[@class='line-item-primary-title']
${product_secondary_title_locator_cart}     xpath://div[@class='line-item-secondary-title']
${item_price_locator_cart}                  xpath:(//div[contains(@class,'line-item-total-price-amount')])[1]
${item_size_locator_cart}                  xpath://div[contains(@class,'line-item-attributes')]/span[2]

###Minicart
${minicart_checkout_l}                      css:a[href*='checkout']
${view_bag_button}                          xpath://a[@title='View Bag']

