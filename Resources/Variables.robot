*** Variables ***
# Access
${DEV_URL}                              https://storefront:TwistedCable23@dev.davidyurman.com/
${UAT_URL}                              https://dytest:TwistedCable23@uat.davidyurman.com/
${PROD_URL}                             https://davidyurman.com/
${EPS_URL}                              https://uat-employeepurchase.davidyurman.com/
${cookies_closed}                       ${False}
${GTFL_already_closed}                  false

#${dev_preorder_product}                 B25992M88BFG
#${uat_preorder_product}                 192740696091

# Desktop
# Browsers
${chrome}                               chrome
${safari}                               safari
${edge}                                 edge
${samsung}                              samsung

# MyAccount

# Login

# SHIPPING DATA
${REGISTERED_email}                     johnDoeTm@mailsac.com
${REGISTERED_pwd}                       P@ssword00
${GUEST_email}                          johnDoeTMGuest@mailsac.com
${PASSWORD}                             P@ssword00
${FIRST_NAME}                           JohnAutomation
${Reg_FIRST_NAME}                       automation-fn
${LAST_NAME}                            Doe
${Reg_LAST_NAME}                        automation-ln
${PHONE}                                2143236555
${PHONE_two}                            92345678929
${ADDRESS}                              123 William Street
${Reg_ADDRESS}                          6201 baird ave
${ADDRESS_two}                          123 Main St
${ADDRESS2}                             Fake Address
${ADDRESS2_two}                         Second Fake Address
${CITY}                                 New York
${STATE}                                NY
${ZIP}                                  91335
${ZIP_two}                              90022
${ZIP_two}                              10038-3804
${invalid_email}                        mail@mail.
${invalid_phone}                        92345678
${invalid_city}                         a
${invalid_zip}                          1%a
${shipping_method_overnight}            Overnight
${shipping_method_2D}                   2 Day
${complimentary_shipping}               Complimentary

# Payment
${visa_number}                          4695370000000009
${mastercard_number}                    5387200000000008
${discover_number}                      6011500080009080
${discover_2_number}                    6445644564456445
${amex_2_number}                        370000000000002
${amex_number}                          378282246310005
${diners_number}                        36006666333344
#${jcb_number}                           3569990010095841
${jcb_number}                           3566111111111113
${invalid_number}                       1
${invalid_csv}                          0
${invalid_card_holder}                  .
${card_exp}                             0330
${csv}                                  737
${csv_discover}                         123
${amex_csv}                             7373
${card_holder}                          test order
${visa_number_3ds}                      4917610000000000
@{credit_card_flags}                    Visa    Mastercard    Amex    Discover
@{credit_card_numbers}
...                                     ${visa_number}
...                                     ${mastercard_number}
...                                     ${discover_number}
...                                     ${amex_number}
...                                     ${visa_number_3ds}
${visa_number_expired}                  4444333322221111
${card_exp_expired}                     1020
${visa_csv_expired}                     737
${card_holder_expired}                  J. De Tester
${invalid_gcn}                          1234567890123456
${invalid_pin}                          1234

###Affirm
#${affirm_phone_no}                      2025550199
${affirm_phone_no}                      2143236555
${affirm_pin_no}                        123456
${REG_affirm_account}                   ana.nanu20@ro.osf-global.com
${REG_affirm_pwd}                       Test*1234Test*1234

###Paypal
${PAYPAL_user}                  Dypaypalsandbox_buyer3@davidyurman.com
${PAYPAL_pass}                  Yurman2017!

###Order Confirmation
@{invalid_pwds}
...                                     Le6c!
...                                     Numbpwd!
...                                     nocaps1@
...                                     NOLOWR2#
...                                     Nospecl1
${valid_password}                       Test#1234

# Country selector
@{REGIONS_ORACLE}                              Americas    Europe    Asia/Pacific    Other locations
@{COUNTRIES_ORACLE}
...    United States
...    United Kingdom
...    France

###02_Checkout
${checkout_info_2day_shipping_title}      Complimentary 2-day shipping
${checkout_info_30day_returns_title}      Complimentary 30-day returns
${checkout_info_boutique_pick_up_title}   Complimentary boutique pick up
${checkout_info_2day_shipping_message}    Your order should arrive in two business days if placed by 3PM ET on weekdays or if placed by 12PM ET on Saturday. Exclusions apply, including orders that ship via USPS.
...                                       Shipping estimates are based on the day and time your order is placed (excluding holidays). You can find a delivery estimate in the shipping step of checkout. Please note: all orders are subject to processing time.
${checkout_info_30day_return_message}     We are pleased to offer a full refund for DavidYurman.com and David Yurman store purchases returned within 30 days of their purchase date.
...                                       All refunds will be made to the purchaser and issued to the original form of payment except cash purchases, which will be refunded by company check. Gift recipients may receive a merchandise credit.
...                                       Please note: Returns must be accompanied by a sales receipt or packing slip and received unaltered, unworn and in sellable condition. Some exclusions may apply.

${checkout_info_boutique_pickup_message}  Our in-store pickup service allows you to make a purchase online at DavidYurman.com and pick up the item at a participating David Yurman boutique.
...                                       Our online store locator indicates if a David Yurman boutique currently offers store pick up services. You may also select the Pick up at David Yurman boutique button on an eligible product page to find a participating store location near you to pick up the item.


#Store Data
${store_expected_address}                    798 Americana Way
${store_expected_city_state}                 Glendale , CA 91210
${store_expected_phone_number}               (818) 241-2836

#Authorized Data
${authorized_expected_address}               400 South Baldwin Avenue
${authorized_expected_city_state}            Arcadia, CA 91007
${authorized_expected_phone_number}          (626) 821-6363

@{expected_services}        Gifting Services    Wedding & Engagement    Styling Services    Product Services & Repairs    Returns & Exchanges
@{expected_hours}           Sunday    11:00 am - 6:00 pm    Monday    10:00 am - 6:00 pm    Tuesday    10:00 am - 6:00 pm    Wednesday    10:00 am - 6:00 pm    Thursday    10:00 am - 6:00 pm    Friday    10:00 am - 7:00 pm    Saturday    10:00 am - 7:00 pm

@{expected_vdg_values}      ${FIRST_NAME}   ${REGISTERED_email}   ${ADDRESS2}


#View Store
${expected_store_name}                           DAVID YURMAN - GLENDALE
${store_directions}                              34.144258,-118.256393
#https://maps.google.com/?daddr=34.144258,-118.256393


#Social links
${expected_instagram_link}                      https://www.instagram.com/davidyurman
${expected_youtube_link}                        https://www.youtube.com/c/davidyurman
${expected_facebook_link}                       https://www.facebook.com/DavidYurman
${expected_pinterest_link}                      https://www.pinterest.com/davidyurman
${expected_twitter_link}                        https://www.twitter.com/davidyurman
${expected_wechat_link}                         https://www.wechat.com/
${expected_tiktok_link}                         https://www.tiktok.com/@davidyurman

#Footer Links
@{support_links}
...                                             https://dev.davidyurman.com/customer-service/customer-care.html
...                                             https://dev.davidyurman.com/assistance/customer-care/product-care-repairs.html
...                                             https://dev.davidyurman.com/assistance/customer-care/shipping-order-tracking.html
...                                             https://dev.davidyurman.com/assistance/customer-care/returns-exchanges.html
...                                             https://dev.davidyurman.com/assistance/customer-care/ordering-payments.html
...                                             https://davidyurman.jrni.com/book#/services
...                                             https://dev.davidyurman.com/gifts/gift-cards.html

@{legal_links}
...                                             https://dev.davidyurman.com/assistance/online-privacy-notice.html
...                                             https://dev.davidyurman.com/assistance/web-accessibility-statement.html
...                                             https://dev.davidyurman.com/assistance/report-fraud.html
...                                             https://dev.davidyurman.com/assistance/california-transparency-in-supply-chains-act-of-2010.html
...                                             https://dev.davidyurman.com/assistance/online-privacy-notice.html#SpecificJurisdictions
...                                             https://dev.davidyurman.com/assistance/do-not-sell-opt-out.html

@{aboutus_links}
...                                             https://dev.davidyurman.com/world-of-yurman.html
...                                             https://davidyurman.wd1.myworkdayjobs.com/DavidYurmanCareers
...                                             https://dev.davidyurman.com/assistance/terms-and-conditions.html
...                                             https://dev.davidyurman.com/sitemap


#Gift Cards
&{gift_cards_dict}    6003920024403851=8194    6003920008015512=7584    6003920031754220=2622
...    6003920071752785=5060    6003920044177885=0751    6003920063842560=1156
...    6003920070218909=7722    6003920042780835=4579    6003920030721553=7344
...    6003920072860323=8341    6003920076220232=5706    6003920074045383=1015
...    6003920021862345=1897    6003920004844794=3375    6003920012688568=4386
...    6003920041426894=9516    6003920036788884=6031    6003920077121048=7272
...    6003920010293951=1407    6003920058904130=2420

${gift_card_number_100}         6003920015168469
${gift_card_pin_100}            8359

#PDP
${pdp_notify_me_msg_exp}                    YOU'RE ON THE LIST
${pdp_notify_me_title_exp}                  Our team will notify you once the product is available again.
${pdp_notify_me_btn_exp}                    NOTIFY ME WHEN AVAILABLE
${pdp_add_to_cart_exp}                      ADD TO BAG
${pdp_customer_care_exp}                    CONTACT CUSTOMER CARE
${pdp_designer_note_exp}                    Designer Notes
${pdp_care_exp}                             Details & Care
${pdp_gifting_exp}                          Gifting
${pdp_ymal_title_us_exp}                    You May Also Like
${pdp_emftc_title_us_exp}                   Explore More from this Collection
${pdp_trend_now_us_exp}                     Trending Now
${pdp_badge_exp}                            New Arrival
${LT_USERNAME}                              shariq.mohammed
${LT_ACCESS_KEY}                            PDKXggfbp3fFLe18WAr0H4eQ3Hm8qBl4hDniEHNEnawMNy2NWa


${reg_29_name}                          Auto Test
${reg_29_password}                      Test*1234
${reg_29_address}                       123 Main St
${reg_29_address_1}                     999 Main St
${reg_29_city}                          Los Angeles
${reg_29_city_1}                        New York
${reg_29_state}                         California
${reg_29_state_1}                       New York
${reg_29_zip}                           91335
${reg_29_zip_1}                         91338
${reg_29_tel}                           214-323-6591
${reg_29_tel_1}                         214-323-4578


${reg_29_name}                          Auto Test
${reg_29_password}                      Test*1234
${reg_29_address}                       123 Main St
${reg_29_address_1}                     999 Main St
${reg_29_city}                          Los Angeles
${reg_29_city_1}                        New York
${reg_29_state}                         California
${reg_29_state_1}                       New York
${reg_29_zip}                           91335
${reg_29_zip_1}                         91338
${reg_29_tel}                           214-323-6591
${reg_29_tel_1}                         214-323-4578


##Registration - 01
${register_firstname_err}                       css:#form-fname-error
${register_lastname_err}                        css:#form-lname-error
${register_email_err}                           css:#form-email-error
${register_confirm_email_err}                   css:#form-email-confirm-error
${register_password_err}                        css:#form-password-error
${register_confirm_password_err}                css:#form-password-confirm-error
${change_pass_link}                             css:.change-pass > a
${current_password_locator}                     css:#changePasswordContainer #currentPassword
${new_password_locator}                         css:#newPassword
${confirm_password_locator}                     css:#newPasswordConfirm
${submit_button}                                css:.password-submit
${header_icon_account}                          css:.header-icon-account > svg
${logout_link}                                  css:.popover a[href*='Logout']
${login_error_message}                          css:.alert-danger
${change_email_link}                            css:.change-email > a
${new_email_locator}                            css:#newEmail
${password_locator}                             css:#changeEmailContainer #currentPassword
${save_email_button}                            css:#btnUpdateEmailSubmit
${change_email_success_message}                 css:.change-email-success-message
${password_check_personal_info_chars}           css:.six-characters
${password_check_personal_info_uppercase}       css:.capital-lowercase
${password_check_personal_info_lowercase}       css:.capital-lowercase
${password_check_personal_info_number}          css:.one-number
${password_check_personal_info_space}           css:.no-spaces
${password_check_personal_info_email}           css:.no-email
${password_check_personal_info_specialchar}     css:.special-character
${first_name_personal_info_locator}             css:#dwfrm_profile #firstName
${last_name_personal_info_locator}              css:#dwfrm_profile #lastName
${birthday_personal_info_locator}               css:#dwfrm_profile #birthday
${anniversary_personal_info_locator}            css:#dwfrm_profile #anniversary
${save_personal_info_button}                    css:#dwfrm_profile .btn-save
${invalid_feedback}                             css:.invalid-feedback
${page_title_personal_info}                     css:.page-title



