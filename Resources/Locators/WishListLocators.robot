*** Variables ***

##email-wishlist
${email_wishlist}                                  xpath://button[@data-target='#shareWishlistModal']
${email_wishlist_form_header}                      xpath://h1[text()='Email this Item']
${email_wishlist_form_yourName_txtField}           xpath://input[@id='wishlist-from-name']
${email_wishlist_form_yourName_placeHolder}        xpath://label[@for='wishlist-from-name']
${email_wishlist_form_yourEmail_txtField}          xpath://input[@id='wishlist-from-email']
${email_wishlist_form_yourEmail_placeHolder}       xpath://label[@for='wishlist-from-email']
${email_wishlist_form_recipientName_txtField}      xpath://input[@id='wishlist-to-name']
${email_wishlist_form_recipientName_placeHolder}   xpath//label[@for='wishlist-to-name']
${email_wishlist_form_recipientEmail_txtField}     xpath://input[@id='wishlist-to-email']
${email_wishlist_form_recipientEmail_placeHolder}  xpath://label[@for='wishlist-to-name']
${email_wishlist_form_message_txtField}            xpath://textarea[@id='wishlist-message']
${email_wishlist_form_send_button}                 xpath://button[contains(text(),'Send')]
${email_wishlist_recieve_email_checkbox}           xpath://label[@for='wishlistEmailSignupCheckbox']
${email_wishlist_form_character_count}             xpath://div[contains(@class,'character-count')]
${add_to_wishlish}                                 xpath://button[@type='submit' and contains(@class,'add-to-wish-list')]
${go_to_wishlish}                                  xpath://a[@class='header-icon ml-0']
${wishlist_product_name_locator}                   xpath://span[@class='item-name minion-pro']

