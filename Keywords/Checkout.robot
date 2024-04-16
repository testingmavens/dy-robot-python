*** Settings ***
Library           SeleniumLibrary    screenshot_root_directory=EMBED
Resource          ../Resources/Locators.robot
Resource          ../Resources/Variables.robot
Resource          ../Keywords/CommonWeb.robot

*** Keywords ***
Click on Sign In button from Checkout
    Wait Until Page Contains Element    ${shipping_stage}   10s    Checkout page is not entirely loaded
    Wait Until Element Is Visible    ${checkout_signin_l}    10s    Sign In button is not displayed
    Click Element    ${checkout_signin_l}
    Wait Until Element Is Visible    ${checkout_email_l}    10s    Email field is not displayed
    Wait Until Element Is Visible    ${checkout_pwd_l}    10s    Password field is not displayed

Click on Paypal button from Page
    [Arguments]    ${page}
    IF    "${page}" == "identification"
        Wait Until Page Contains Element    ${paypal_idntf_btn_l}    30s    Paypal button is not yet visible
    END
    Select Frame    ${paypal_iframe_l}
    Wait Until Page Contains Element    ${paypal_btn_container_l}    30s    Paypal button is not yet visible
    CommonWeb.Scroll and Click    ${paypal_btn_container_l}
    Sleep    10s    #to be improved

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
    Scroll To Bottom
    Sleep  3s
    Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//a[@data-content='two-day-shipping'])[2]   ${checkout_info_2day_shipping_message}
    CommonWeb.Check and Click    xpath:(//a[@data-content='two-day-shipping'])[2]
    Wait Until Page Contains Element    ${checkout_info_modal_show_l}    10s    Info Modal is not visible
    Wait Until Element Is Visible    ${checkout_info_modal_title_l}    10s    Info Modal is not visible
    Run Keyword And Warn On Failure    Element Text Should Be    ${checkout_info_modal_title_l}   ${checkout_info_2day_shipping_title}
    ${2DayText}  Get Text    xpath://div[@class='order-summary-content']
    Run Keyword And Warn On Failure    Should Contain Text    ${2DayText}   ${checkout_info_2day_shipping_message}
    CommonWeb.Check and Click    ${checkout_info_modal_close_l}
    Wait Until Element Is Not Visible    ${checkout_info_modal_title_l}    10s    Info Modal is still visible
    
    Scroll To Element    xpath:(//a[@data-content='30-day-returns'])[2]
    Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//a[@data-content='30-day-returns'])[2]   ${checkout_info_30day_returns_title}
    CommonWeb.Check and Click    xpath:(//a[@data-content='30-day-returns'])[2]
    Wait Until Page Contains Element    ${checkout_info_modal_show_l}    10s    Info Modal is not visible
    Wait Until Element Is Visible    ${checkout_info_modal_title_l}    10s    Info Modal is not visible
    Run Keyword And Warn On Failure    Element Text Should Be    ${checkout_info_modal_title_l}   ${checkout_info_30day_returns_title}
    ${30DayText}  Get Text    xpath://div[@class='order-summary-content']
    Run Keyword And Warn On Failure    Should Contain Text    ${30DayText}   ${checkout_info_30day_returns_message}
    CommonWeb.Check and Click    ${checkout_info_modal_close_l}
    Wait Until Element Is Not Visible    ${checkout_info_modal_title_l}    10s    Info Modal is still visible

    Scroll To Element    xpath:(//a[@data-content='complimentary-boutique-pick-up'])[2]
    Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//a[@data-content='complimentary-boutique-pick-up'])[2]   ${checkout_info_boutique_pick_up_title}
    CommonWeb.Check and Click    xpath:(//a[@data-content='complimentary-boutique-pick-up'])[2]
    Wait Until Page Contains Element    ${checkout_info_modal_show_l}    10s    Info Modal is not visible
    Wait Until Element Is Visible    ${checkout_info_modal_title_l}    10s    Info Modal is not visible
    Run Keyword And Warn On Failure    Element Text Should Be    ${checkout_info_modal_title_l}   ${checkout_info_boutique_pick_up_title}
    ${boutiqueText}  Get Text    xpath://div[@class='order-summary-content']
    Run Keyword And Warn On Failure    Should Contain Text    ${boutiqueText}   ${checkout_info_boutique_pickup_message}
    CommonWeb.Check and Click    ${checkout_info_modal_close_l}
    Wait Until Element Is Not Visible    ${checkout_info_modal_title_l}    10s    Info Modal is still visible




Hover over Minicart
    Mouse Over    ${minicart_icon_l}

Click on Checkout button from Minicart
    Mouse Over    ${minicart_icon_l}
    Wait Until Element Is Visible    css:.popover.show a[href*='checkout']    10s    Minicart modal is not visible
    Click Element    css:.popover.show a[href*='checkout']


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

Click checkout as guest button
    Click Element    xpath://a[contains(text(),'Checkout as Guest')]

Click Back to bag button from checkout page
   Click Element    xpath:(//a[@title='Continue Shopping'])[1]

Capture product price from checkout
    Scroll Element Into View    xpath:(//div[contains(@class,'line-item-total-price-amount')])[1]
    ${checkout_product_price}    Get Text    xpath:(//div[contains(@class,'line-item-total-price-amount')])[1]
    ${checkout_product_price}    Remove currency and comma from price    ${checkout_product_price}
    Set Test Variable    ${checkout_product_price}    ${checkout_product_price}

Capture product primary name from checkout
    Scroll Element Into View    xpath://div[@class='line-product-name']
    ${checkout_product_primary_name}    Get Text    xpath://div[@class='line-product-name']
    Set Test Variable    ${checkout_product_primary_name}    ${checkout_product_primary_name}


Capture product secondary name from checkout
    Scroll Element Into View    xpath://span[@class='line-product-description']
    ${checkout_product_secondary_name}    Get Text    xpath://span[@class='line-product-description']
    Set Test Variable    ${checkout_product_secondary_name}    ${checkout_product_secondary_name}