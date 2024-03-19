*** Settings ***
Library           SeleniumLibrary    screenshot_root_directory=EMBED
Resource          ../Resources/Locators.robot
Resource          ../Resources/Variables.robot
Resource          ../Keywords/CommonWeb.robot
Resource          ../Keywords/Cart.robot

*** Keywords ***
Click on Sign In button from Checkout
    Wait Until Page Contains Element    ${shipping_stage}   10s    Checkout page is not entirely loaded
    Wait Until Element Is Visible    ${checkout_signin_l}    10s    Sign In button is not displayed
    Click Element    ${checkout_signin_l}
    Wait Until Element Is Visible    ${checkout_email_l}    10s    Email field is not displayed
    Wait Until Element Is Visible    ${checkout_pwd_l}    10s    Password field is not displayed

Click on Paypal button from Page
    [Arguments]    ${page}
    IF    "${page}" in ['checkout', 'cart']
        Wait Until Page Contains Element    ${paypal_idntf_btn_l}    20s    Paypal button is not yet visible
        Click Element    xpath:(//div[@class='paypal-button-label-container'])[1]
    ELSE
        Wait Until Page Contains Element    ${paypal_idntf_btn_l}    20s    Paypal button is not yet visible
        Click Element    xpath://div[@class='paypal-button-label-container']
    END
        Select Frame    ${paypal_iframe_l}
        Wait Until Page Contains Element    ${paypal_btn_container_l}    30s    Paypal button is not yet visible
    CommonWeb.Scroll and Click    ${paypal_btn_container_l}
         Wait Until Page Contains Element    ${paypal_btn_container_l}    30s    Paypal button is not yet visible

Enter login credentials during checkout
    [Arguments]    ${user}    ${pwd}
    CommonWeb.Check and Input text    ${checkout_email_l}    ${user}
    CommonWeb.Check and Input text    ${checkout_pwd_l}    ${pwd}

Click on Sign In button during checkout
    Click Element    ${checkout_signin_submit_l}
    Wait Until Page Contains Element    ${checkout_signin_email_l}    10s    Email is not displayed
    Wait Until Element Is Visible    ${checkout_signin_email_l}    10s    Email is not visible

Sign in during checkout
    Click on Sign In button from Checkout
    Enter login credentials during checkout    ${REGISTERED_email}    ${REGISTERED_pwd}
    Click on Sign In button during checkout

Check Info Texts During Checkout
     Scroll To Element    xpath:(//a[@data-content='two-day-shipping'])[2]
    Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//a[@data-content='two-day-shipping'])[2]   ${checkout_info_2day_shipping_message}
    CommonWeb.Check and Click    xpath:(//a[@data-content='two-day-shipping'])[2]
    Wait Until Page Contains Element    ${checkout_info_modal_show_l}    10s    Info Modal is not visible
    Wait Until Element Is Visible    ${checkout_info_modal_title_l}    10s    Info Modal is not visible
    Run Keyword And Warn On Failure    Element Text Should Be    ${checkout_info_modal_title_l}   ${checkout_info_2day_shipping_title}
    Run Keyword And Warn On Failure    Element Text Should Be    xpath://div[@class='order-summary-content']   ${checkout_info_2day_shipping_message}
    CommonWeb.Check and Click    ${checkout_info_modal_close_l}
    Wait Until Element Is Not Visible    ${checkout_info_modal_title_l}    10s    Info Modal is still visible

    Scroll To Element    xpath:(//a[@data-content='30-day-returns'])[2]
    Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//a[@data-content='30-day-returns'])[2]   ${checkout_info_30day_returns_title}
    CommonWeb.Check and Click    xpath:(//a[@data-content='30-day-returns'])[2]
    Wait Until Page Contains Element    ${checkout_info_modal_show_l}    10s    Info Modal is not visible
    Wait Until Element Is Visible    ${checkout_info_modal_title_l}    10s    Info Modal is not visible
    Run Keyword And Warn On Failure    Element Text Should Be    ${checkout_info_modal_title_l}   ${checkout_info_30day_returns_title}
    Run Keyword And Warn On Failure    Element Text Should Be    xpath://div[@class='order-summary-content']   ${checkout_info_30day_return_message}
    CommonWeb.Check and Click    ${checkout_info_modal_close_l}
    Wait Until Element Is Not Visible    ${checkout_info_modal_title_l}    10s    Info Modal is still visible

    Scroll To Element    xpath:(//a[text()='Complimentary boutique pick up'])[2]
    Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//a[@data-content='Complimentary boutique pick up'])[2]   ${checkout_info_boutique_pick_up_title}
    CommonWeb.Check and Click    xpath:(//a[@data-content='Complimentary boutique pick up'])[2]
    Wait Until Page Contains Element    ${checkout_info_modal_show_l}    10s    Info Modal is not visible
    Wait Until Element Is Visible    ${checkout_info_modal_title_l}    10s    Info Modal is not visible
    Run Keyword And Warn On Failure    Element Text Should Be    ${checkout_info_modal_title_l}   ${checkout_info_boutique_pick_up_title}
    Run Keyword And Warn On Failure    Element Text Should Be    xpath://div[@class='order-summary-content']   ${checkout_info_boutique_pickup_message}
    CommonWeb.Check and Click    ${checkout_info_modal_close_l}
    Wait Until Element Is Not Visible    ${checkout_info_modal_title_l}    10s    Info Modal is still visible

Hover over Minicart
    Mouse Over    ${minicart_icon_l}

Click on Checkout button from Minicart
    Mouse Over    ${minicart_icon_l}
    Wait Until Element Is Visible    css:.popover.show a[href*='checkout']    10s    Minicart modal is not visible
    Click Element    css:.popover.show a[href*='checkout']

Capture delivery details from checkout page
    ${no_of_items_checkout_delivery} =  Get text    xpath://h2[contains(@class,'card-header-custom shipping-header-checkout delivery-icon')]/span
    ${product_primary_title_checkout_delivery} =  Get text    xpath:(//div[contains(@class,'line-product-name')])[1]
    ${product_secondary_title_checkout_delivery} =  Get text  xpath:(//div[contains(@class,'line-product-name')])[1]/span
    ${item_size_checkout_delivery} =  Get text   xpath:(//p[contains(@class,'line-item-attributes')])[1]

    Set Test Variable    ${no_of_items_checkout_delivery}   ${no_of_items_checkout_delivery}
    Set Test Variable    ${product_primary_title_checkout_delivery}       ${product_primary_title_checkout_delivery}
    Set Test Variable    ${product_secondary_title_checkout_delivery}     ${product_secondary_title_checkout_delivery}
    Set Test Variable    ${item_size_checkout_delivery}                   ${item_size_checkout_delivery}

Capture payment details from checkout page
    ${product_primary_title_checkout_payment} =  Get text    xpath:(//div[contains(@class,'line-product-name')])[3]
    ${product_secondary_title_checkout_payment} =   Get text    xpath:(//div[contains(@class,'line-product-name')])[3]/span
    ${product_price_checkout_payment} =  Get Text  xpath:(//p[contains(@class,'line-item-attributes')])[4]
    ${sub_total_checkout_payment} =  Get Text  xpath:(//span[@class='sub-total'])[2]
    ${shipping_total_checkout_payment} =  Get Text  xpath:(//span[@class='shipping-total-cost'])[2]
    ${sales_tax_total_checkout_payment} =  Get Text  xpath:(//span[@class='tax-total font-italic'])[2]
    ${grand_total_checkout_payment} =  Get Text   xpath:(//span[@class='grand-total-sum'])[2]

    Set Test Variable    ${product_primary_title_checkout_payment}   ${product_primary_title_checkout_payment}
    Set Test Variable    ${product_secondary_title_checkout_payment}       ${product_secondary_title_checkout_payment}
    Set Test Variable    ${product_price_checkout_payment}             ${product_price_checkout_payment}
    Set Test Variable    ${sub_total_checkout_payment}             ${sub_total_checkout_payment}
    Set Test Variable    ${shipping_total_checkout_payment}        ${shipping_total_checkout_payment}
    Set Test Variable    ${sales_tax_total_checkout_payment}             ${sales_tax_total_checkout_payment}
    Set Test Variable    ${grand_total_checkout_payment}             ${grand_total_checkout_payment}

Compare item details are correct in cart and checkout page
    Run Keyword And Warn On Failure    Should Be Equal As Strings    ${no_of_items_checkout_delivery}    ${no_of_items_cart}
    Run Keyword And Warn On Failure    Should Be Equal As Strings    ${product_primary_title_checkout_delivery}      ${product_primary_title_cart}
    Run Keyword And Warn On Failure    Should Be Equal As Strings    ${product_secondary_title_checkout_delivery}    ${product_secondary_title_cart}
    Run Keyword And Warn On Failure    Should Be Equal As Strings    ${item_size_checkout_delivery}    ${item_size_cart}
    Run Keyword And Warn On Failure    Should Be Equal As Strings    ${product_primary_title_checkout_payment}      ${product_primary_title_cart}
    Run Keyword And Warn On Failure    Should Be Equal As Strings    ${product_secondary_title_checkout_payment}     ${product_secondary_title_cart}
    Run Keyword And Warn On Failure    Should Be Equal As Strings    ${product_price_checkout_payment}    ${item_price_cart}
    Run Keyword And Warn On Failure    Should Be Equal As Strings    ${sub_total_checkout_payment}    ${preShippingSubTotal_cart}
    Run Keyword And Warn On Failure    Should Be Equal As Strings    ${shipping_total_checkout_payment}    ${shipping_charge_cart}
    Run Keyword And Warn On Failure    Should Be Equal As Strings    ${sales_tax_total_checkout_payment}    ${tax_total_cart}
    Run Keyword And Warn On Failure    Should Be Equal As Strings    ${grand_total_checkout_payment}    ${sub_total_cart}


## EU KEYWORDS
Click checkout as guest button
    Click Element    xpath://a[contains(text(),'Checkout as Guest')]

Enter valid billing details for eu
    [Arguments]    ${GUEST_EMAIL}   ${FIRST_NAME}   ${LAST_NAME}   ${ADDRESS}   ${ADDRESS2}   ${ZIP}   ${PHONE}
    ${billing_firstname_eu} =    Run Keyword And Return Status    Wait Until Element Is Visible    ${billing_fn_eu}    timeout=3s
    Run Keyword If    ${billing_firstname_eu}     Scroll To Element   ${billing_fn_eu}
    Run Keyword If    ${billing_firstname_eu}     CommonWeb.Check and Input text          ${billing_fn_eu}    ${FIRST_NAME}
    ${billing_lastname_eu}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${billing_ln_eu}    timeout=3s
    Run Keyword If    ${billing_lastname_eu}     Scroll To Element   ${billing_ln_eu}
    Run Keyword If    ${billing_lastname_eu}     CommonWeb.Check and Input text          ${billing_ln_eu}    ${LAST_NAME}
    ${billing_email}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${billing_email_eu}    timeout=3s
    Run Keyword If    ${billing_email}     Scroll To Element   ${billing_email_eu}
    Run Keyword If    ${billing_email}     CommonWeb.Check and Input text          ${billing_email_eu}    ${GUEST_EMAIL}
    ${billing_country}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${billing_country_eu}    timeout=3s
    Run Keyword If    ${billing_country}     Click Element   ${billing_country_eu}
    Wait Until Page Contains Element    xpath://select[@id='BillingCountryID']
    Scroll Element Into View    xpath://select[@id='BillingCountryID']
  IF  '${shopLocale}' in ['UK']
    Select From List By Label   xpath://select[@id='BillingCountryID']     United Kingdom
  ELSE IF '${shopLocale}' in ['FR']
     Select From List By Label   xpath://select[@id='BillingCountryID']     France
  END
    ${billing_address1}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${billing_address_one_eu}    timeout=3s
    Run Keyword If    ${billing_address1}     Scroll To Element   ${billing_address_one_eu}
    Run Keyword If    ${billing_address1}     CommonWeb.Check and Input text  ${billing_address_one_eu}  ${ADDRESS}
    ${billing_address2}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${billing_address_two_eu}    timeout=3s
    Run Keyword If    ${billing_address2}     Scroll To Element   ${billing_address_two_eu}
    Run Keyword If    ${billing_address2}     CommonWeb.Check and Input text  ${billing_address_two_eu}  ${ADDRESS2}
    ${billing_city}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${billing_city_eu}    timeout=3s
    Run Keyword If    ${billing_city}     Scroll To Element   ${billing_city_eu}
  IF  '${shopLocale}' in ['UK']
    CommonWeb.Check and Input text  ${billing_city_eu}  Britain
  ELSE IF '${shopLocale}' in ['FR']
    CommonWeb.Check and Input text  ${billing_city_eu}  Paris
  END
    ${billing_zip}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${billing_zipCode_eu}    timeout=3s
    Run Keyword If    ${billing_zip}     Scroll To Element   ${billing_zipCode_eu}
    Run Keyword If    ${billing_zip}     CommonWeb.Check and Input text  ${billing_zipCode_eu}  ${ZIP}
    ${billing_phone}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${billing_phone_eu}    timeout=3s
    Run Keyword If    ${billing_phone}     Scroll To Element   ${billing_phone_eu}
    Run Keyword If    ${billing_phone}     CommonWeb.Check and Input text  ${billing_phone_eu}  ${PHONE}

Enter valid Store PickUp Guest details for eu
    [Arguments]    ${GUEST_EMAIL}   ${FIRST_NAME}   ${LAST_NAME}  ${PHONE}
    ${shippingMail}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${guest_bopis_email}    timeout=3s
    Run Keyword If    ${shippingMail}     Scroll To Element   ${guest_bopis_email}
    Run Keyword If    ${shippingMail}     CommonWeb.Check and Input text          ${guest_bopis_email}    ${GUEST_email}
    ${shippingName}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${guest_bopis_fn}    timeout=3s
    Run Keyword If    ${shippingName}     Scroll To Element   ${guest_bopis_fn}
    Run Keyword If    ${shippingName}     CommonWeb.Check and Input text          ${guest_bopis_fn}    ${FIRST_NAME}
    ${shippingLastName}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${guest_bopis_ln}    timeout=3s
    Run Keyword If    ${shippingLastName}     Scroll To Element   ${guest_bopis_ln}
    Run Keyword If    ${shippingLastName}     CommonWeb.Check and Input text          ${guest_bopis_ln}    ${LAST_NAME}
    ${shippingPhoneNumber}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${guest_bopis_phone}    timeout=3s
    Run Keyword If    ${shippingPhoneNumber}     Scroll To Element   ${guest_bopis_phone}
    Run Keyword If    ${shippingPhoneNumber}     CommonWeb.Check and Input text          ${guest_bopis_phone}    ${PHONE}

Capture delivery details from checkout page for eu
    ${no_of_items_checkout_delivery} =  Get text    xpath://h2[contains(@class,'card-header-custom shipping-header-checkout delivery-icon')]/span
    ${product_primary_title_checkout_delivery} =  Get text    xpath:(//div[contains(@class,'line-product-name')])[1]
    ${product_secondary_title_checkout_delivery} =  Get text  xpath:(//div[contains(@class,'line-product-name')])[1]/span
    ${item_size_checkout_delivery} =  Get text   xpath:(//p[contains(@class,'line-item-attributes')])[1]

    Set Test Variable    ${no_of_items_checkout_delivery}   ${no_of_items_checkout_delivery}
    Set Test Variable    ${product_primary_title_checkout_delivery}       ${product_primary_title_checkout_delivery}
    Set Test Variable    ${product_secondary_title_checkout_delivery}     ${product_secondary_title_checkout_delivery}
    Set Test Variable    ${item_size_checkout_delivery}                   ${item_size_checkout_delivery}

Capture payment details from checkout page for eu
    ${product_primary_title_checkout_payment} =  Get text    xpath:(//div[contains(@class,'line-product-name')])[3]
    ${product_secondary_title_checkout_payment} =   Get text    xpath:(//div[contains(@class,'line-product-name')])[3]/span
    ${product_price_checkout_payment} =  Get Text  xpath:(//p[contains(@class,'line-item-attributes')])[4]
    ${sub_total_checkout_payment} =  Get Text  xpath:(//span[@class='sub-total'])[2]
    ${shipping_total_checkout_payment} =  Get Text  xpath:(//span[@class='shipping-total-cost'])[2]
    ${sales_tax_total_checkout_payment} =  Get Text  xpath:(//span[@class='tax-total font-italic'])[2]
    ${grand_total_checkout_payment} =  Get Text   xpath:(//span[@class='grand-total-sum'])[2]

    Set Test Variable    ${product_primary_title_checkout_payment}   ${product_primary_title_checkout_payment}
    Set Test Variable    ${product_secondary_title_checkout_payment}       ${product_secondary_title_checkout_payment}
    Set Test Variable    ${product_price_checkout_payment}             ${product_price_checkout_payment}
    Set Test Variable    ${sub_total_checkout_payment}             ${sub_total_checkout_payment}
    Set Test Variable    ${shipping_total_checkout_payment}        ${shipping_total_checkout_payment}
    Set Test Variable    ${sales_tax_total_checkout_payment}             ${sales_tax_total_checkout_payment}
    Set Test Variable    ${grand_total_checkout_payment}             ${grand_total_checkout_payment}

Compare item details are correct in cart and checkout page for eu
    Run Keyword And Warn On Failure    Should Be Equal As Strings    ${no_of_items_checkout_delivery}    ${no_of_items_cart}
    Run Keyword And Warn On Failure    Should Be Equal As Strings    ${product_primary_title_checkout_delivery}      ${product_primary_title_cart}
    Run Keyword And Warn On Failure    Should Be Equal As Strings    ${product_secondary_title_checkout_delivery}    ${product_secondary_title_cart}
    Run Keyword And Warn On Failure    Should Be Equal As Strings    ${item_size_checkout_delivery}    ${item_size_cart}
    Run Keyword And Warn On Failure    Should Be Equal As Strings    ${product_primary_title_checkout_payment}      ${product_primary_title_cart}
    Run Keyword And Warn On Failure    Should Be Equal As Strings    ${product_secondary_title_checkout_payment}     ${product_secondary_title_cart}
    Run Keyword And Warn On Failure    Should Be Equal As Strings    ${product_price_checkout_payment}    ${item_price_cart}
    Run Keyword And Warn On Failure    Should Be Equal As Strings    ${sub_total_checkout_payment}    ${preShippingSubTotal_cart}
    Run Keyword And Warn On Failure    Should Be Equal As Strings    ${shipping_total_checkout_payment}    ${shipping_charge_cart}
    Run Keyword And Warn On Failure    Should Be Equal As Strings    ${sales_tax_total_checkout_payment}    ${tax_total_cart}
    Run Keyword And Warn On Failure    Should Be Equal As Strings    ${grand_total_checkout_payment}    ${sub_total_cart}

Enter valid alternate billing details for eu
    [Arguments]    ${GUEST_EMAIL}   ${FIRST_NAME}   ${LAST_NAME}   ${ADDRESS}   ${ADDRESS2}   ${ZIP}   ${PHONE}
    ${billing_firstname_eu} =    Run Keyword And Return Status    Wait Until Element Is Visible    ${billing_fn_eu}    timeout=3s
    Run Keyword If    ${billing_firstname_eu}     Scroll To Element   ${billing_fn_eu}
    Run Keyword If    ${billing_firstname_eu}     CommonWeb.Check and Input text          ${billing_fn_eu}    ${FIRST_NAME}
    ${billing_lastname_eu}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${billing_ln_eu}    timeout=3s
    Run Keyword If    ${billing_lastname_eu}     Scroll To Element   ${billing_ln_eu}
    Run Keyword If    ${billing_lastname_eu}     CommonWeb.Check and Input text          ${billing_ln_eu}    ${LAST_NAME}
    ${billing_email}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${billing_email_eu}    timeout=3s
    Run Keyword If    ${billing_email}     Scroll To Element   ${billing_email_eu}
    Run Keyword If    ${billing_email}     CommonWeb.Check and Input text          ${billing_email_eu}    ${GUEST_EMAIL}
    ${billing_country}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${billing_country_eu}    timeout=3s
    Run Keyword If    ${billing_country}     Click Element   ${billing_country_eu}
  IF  '${shopLocale}' in ['UK']
    Click Element   xpath://select[@id='BillingCountryID']/option[text()='United Kingdom']
  ELSE IF '${shopLocale}' in ['FR']
    Click Element   xpath://select[@id='BillingCountryID']/option[text()='France']
  END
    ${billing_address1}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${billing_address_one_eu}    timeout=3s
    Run Keyword If    ${billing_address1}     Scroll To Element   ${billing_address_one_eu}
    Run Keyword If    ${billing_address1}     CommonWeb.Check and Input text  ${billing_address_one_eu}  ${ADDRESS}
    ${billing_address2}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${billing_address_two_eu}    timeout=3s
    Run Keyword If    ${billing_address2}     Scroll To Element   ${billing_address_two_eu}
    Run Keyword If    ${billing_address2}     CommonWeb.Check and Input text  ${billing_address_two_eu}  ${ADDRESS2}
    ${billing_city}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${billing_city_eu}    timeout=3s
    Run Keyword If    ${billing_city}     Scroll To Element   ${billing_city_eu}
  IF  '${shopLocale}' in ['UK']
    CommonWeb.Check and Input text  ${billing_city_eu}  Britain
  ELSE IF '${shopLocale}' in ['FR']
    CommonWeb.Check and Input text  ${billing_city_eu}  Paris
  END
    ${billing_zip}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${billing_zipCode_eu}    timeout=3s
    Run Keyword If    ${billing_zip}     Scroll To Element   ${billing_zipCode_eu}
    Run Keyword If    ${billing_zip}     CommonWeb.Check and Input text  ${billing_zipCode_eu}  ${ZIP}
    ${billing_phone}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${billing_phone_eu}    timeout=3s
    Run Keyword If    ${billing_phone}     Scroll To Element   ${billing_phone_eu}
    Run Keyword If    ${billing_phone}     CommonWeb.Check and Input text  ${billing_phone_eu}  ${PHONE}
    
Click add new address
  Click Element    xpath://select[text()='New adress']

Enter valid Store PickUp Guest details
    [Arguments]    ${GUEST_EMAIL}   ${FIRST_NAME}   ${LAST_NAME}  ${PHONE}
    ${shippingMail}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${guest_bopis_email}    timeout=3s
    Run Keyword If    ${shippingMail}     Scroll To Element   ${guest_bopis_email}
    Run Keyword If    ${shippingMail}     CommonWeb.Check and Input text          ${guest_bopis_email}    ${GUEST_email}
    ${shippingName}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${guest_bopis_fn}    timeout=3s
    Run Keyword If    ${shippingName}     Scroll To Element   ${guest_bopis_fn}
    Run Keyword If    ${shippingName}     CommonWeb.Check and Input text          ${guest_bopis_fn}    ${FIRST_NAME}
    ${shippingLastName}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${guest_bopis_ln}    timeout=3s
    Run Keyword If    ${shippingLastName}     Scroll To Element   ${guest_bopis_ln}
    Run Keyword If    ${shippingLastName}     CommonWeb.Check and Input text          ${guest_bopis_ln}    ${LAST_NAME}
    ${shippingPhoneNumber}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${guest_bopis_phone}    timeout=3s
    Run Keyword If    ${shippingPhoneNumber}     Scroll To Element   ${guest_bopis_phone}
    Run Keyword If    ${shippingPhoneNumber}     CommonWeb.Check and Input text          ${guest_bopis_phone}    ${PHONE}