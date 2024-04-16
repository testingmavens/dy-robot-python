*** Settings ***
Library           SeleniumLibrary    screenshot_root_directory=EMBED
Library           Collections
Resource          ../Resources/Locators.robot
Resource          ../Resources/Variables.robot
Resource          ../Keywords/CommonWeb.robot
Resource          ../Keywords/PDP.robot

*** Keywords ***
Enter payment details
    [Arguments]    @{varargs}
    Wait Until Page Contains Element    ${payment_section_l}    20s    Payment method are not displayed
    ${expandedcc}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${card_number}    timeout=3s
    IF    '${expandedcc}' == 'True'
        Scroll Element Into View    ${card_number}
        Input text    ${card_number}    ${varargs}[0]
        Scroll Element Into View    ${name_field}
        Input text    ${name_field}    ${varargs}[3]
        Scroll Element Into View    ${expiration_month_label}
        Click Element    ${expiration_month_label}
        Wait Until Element Is Visible    ${expiration_month}    10s
        Click Element    ${expiration_month}
        Scroll Element Into View    ${expiration_year_label}
        Click Element    ${expiration_year_label}
        Scroll Element Into View    ${expiration_year}
        Click Element    ${expiration_year}
        Scroll Element Into View    ${security_code}
        CommonWeb.Check and Input text    ${security_code}    ${varargs}[2]
    END

Click on Place Order CTA for payment
    [Arguments]    ${po_type}
    Execute Javascript    window.scrollTo(0,document.body.scrollHeight/2)
    IF    "${po_type}" == "paypal"
        ${paypal_po_available}=    Run Keyword And Return Status    Wait Until Page Contains Element      ${payment_submit_paypal_l}    20s
        Run Keyword If    ${paypal_po_available}     Scroll Element Into View    ${payment_submit_paypal_l}
        Run Keyword If    ${paypal_po_available}     Click Element    ${payment_submit_paypal_l}
    ELSE IF    "${po_type}" == "zero_order"
        Run Keyword And Warn On Failure    Wait Until Page Contains Element      ${payment_submit_zero_order_l}    20s    Submit Payment button is not fully loaded
        Scroll Element Into View    ${payment_submit_zero_order_l}
        Sleep  3s
        Click by JS     ${payment_submit_zero_order_l}
    ELSE
        Run Keyword And Warn On Failure    Wait Until Page Contains Element      ${payment_submit_cc_l}    20s    Submit Payment button is not fully loaded
        Scroll Element Into View    ${payment_submit_cc_l}
        CommonWeb.Click by JS    ${payment_submit_cc_l}
    END
    Wait Until Location Contains    /Order-Confirm    120s    Order Confirmation page is not fully loaded

Click on Place Order CTA
    CommonWeb.Scroll And Click by JS    ${payment_submit_cc_l}

Select the PayPal payment method
    CommonWeb.Check and Click    ${paypal_link_l}
    Wait Until Page Contains Element    ${paypal_option_l}    10s     Paypal option is not visible
    Click Element    ${paypal_content_l}
    Sleep    10s    #to be improved

Log into PayPal
    @{winHandles}=    Get Window Handles
    @{winTitles}=    Get Window Titles
    Switch Window    ${winHandles}[1]
    Wait Until Page Contains Element    ${paypal_email_l}     100s    Email field is not loaded
    CommonWeb.Check and Input text     ${paypal_email_l}       ${PAYPAL_user}
    Click Button    ${affirm_next_l}
    CommonWeb.Check and Input text     ${paypal_pwd_l}       ${PAYPAL_pass}
    Click Button    ${affirm_login_l}
    Wait Until Page Contains Element    ${paypal_consent_l}     100s    Consent text is not loaded
    Set Test Variable    @{winHandles}

On Paypal Account click on Save and Continue
    Click Element    ${paypal_consent_l}
    sleep    10s    #to be improved
    Switch Window    ${winHandles}[0]

Select the Affirm payment method
    Click Element    ${affirm_link_l}
    Wait Until Page Contains Element    ${affirm_options_l}    30s    Affirm options were not loaded in 30s
    CommonWeb.Scroll And Click by JS    ${affirm_show_submit_l}

Check that the Affirm Checkout modal is displayed
    Wait Until Page Contains Element    ${affirm_frame_one_l}    30s    Affirm frame was not loaded in 30s
    Select Frame    ${affirm_frame_one_l}
    Wait Until Element Is Visible    ${affirm_mobile_l}    30s    Affirm mobile field is not loaded

Enter and submit the phone number on Affirm Checkout modal
    CommonWeb.Check and Input text    ${affirm_mobile_l}    ${affirm_phone_no}
    Click Element    ${affirm_sign_in_submit_l}
    Wait Until Page Contains Element    ${affirm_phone_pin_l}    30s    Phone Pin is not loaded
    Wait Until Element Is Visible    ${affirm_phone_pin_l}    30s    Phone Pin is not visible

Enter Affirm PIN within the "We just texted you" modal
    CommonWeb.Check and Input text    ${affirm_phone_pin_l}    ${affirm_pin_no}
#    Wait Until Page Contains Element    ${affirm_choose_pay_plan_l}    100s    'Choose a payment plan' is not loaded
#    Wait Until Element Is Visible    ${affirm_choose_pay_plan_l}    100s    'Choose a payment plan' is not visible

Choose and Affirm payment plan for number of months
    [Arguments]    ${nr_months}
    Click Element    xpath://span[contains(.,'for ${nr_months} months')]

Click on Choose This Affirm Plan button
    Click Element    ${affirm_choose_this_plan_l}

Verify identity on Affirm Payment Plan modal
    Wait Until Page Contains Element    ${affirm_last4_ssn_l}    15s    'Last 4 of Social Security Number' was not loaded in 15s
    Wait Until Element Is Visible    ${affirm_last4_ssn_l}        10s     'Last 4 of Social Security Number' was not visivle in 10s
    CommonWeb.Check and Input text    ${affirm_last4_ssn_l}    1111
    Click Element    ${affirm_verify_l}

Agree to DY policy on Affirm Review And Pay modal
    Wait Until Page Contains Element    ${affirm_review_pay_l}    30s    'I have reviewed and agree to the' was not loaded in 30s
    Wait Until Element Is Visible    ${affirm_review_pay_l}    10s    'I have reviewed and agree to the' was not loaded in 30s
    CommonWeb.Scroll And Click    ${affirm_review_pay_l}

Confirm the Affirm payment
    Wait Until Page Contains Element    ${affirm_pof_submit_l}    30s    Confirm CTA is not loaded
    Click Element    ${affirm_pof_submit_l}
    Unselect Frame
    Wait Until Location Contains    /Order-Confirm    100s    Order Confirmation page was not fully loaded in 60s

Check that PayPal and affirm payment options are not listed when buying preorder items
    Page Should Not Contain Element    ${payment_hide_paypal_l}
    Page Should Not Contain Element    ${payment_hide_affirm_l}

Check that Credit Card payment option is preselected and expanded
    Page Should Contain Element    ${payment_preselected_cc_l}

Check that Billing Same As Shipping checkbox is selected by default
    Run Keyword And Warn On Failure    Checkbox Should Be Selected    ${billing_same_as_shipping}

Click on Add New Card
    ${addc}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${payment_add_new_card_l}    timeout=3s
    Run Keyword If    ${addc}     Scroll And Click    ${payment_add_new_card_l}

Verify that the shipping information is correct on Payment page
    [Arguments]    ${EMAIL}    ${FIRST_NAME}   ${LAST_NAME}   ${ADDRESS}   ${ADDRESS2}   ${ZIP}   ${PHONE}
    Run Keyword And Warn On Failure    Wait Until Element Is Visible    ${payment_ShipInfo_email_l}      10s   error=Shipping contact email not displayed
    Run Keyword And Warn On Failure    Wait Until Element Is Visible    ${payment_ShipInfo_fn_l}          10s   error=Shipping contact last name not displayed
    Run Keyword And Warn On Failure    Wait Until Element Is Visible    ${payment_ShipInfo_ln_l}          10s   error=Shipping contact last name not displayed
    Run Keyword And Warn On Failure    Wait Until Element Is Visible    ${payment_ShipInfo_addr1_l}    10s   error=Shipping contact Address1 not displayed
    Run Keyword And Warn On Failure    Wait Until Element Is Visible    ${payment_ShipInfo_zip_l}        10s   error=Shipping contact Postal Code not displayed
    Run Keyword And Warn On Failure    Wait Until Element Is Visible    ${payment_ShipInfo_phone_l}      10s   error=Shipping contact Phone Number not displayed

    Run Keyword And Warn On Failure    Element Should Contain    ${payment_ShipInfo_email_l}       ${EMAIL}
    Run Keyword And Warn On Failure    Element Should Contain    ${payment_ShipInfo_fn_l}              ${FIRST_NAME}
    Run Keyword And Warn On Failure    Element Should Contain    ${payment_ShipInfo_ln_l}              ${LAST_NAME}
    Run Keyword And Warn On Failure    Element Should Contain    ${payment_ShipInfo_addr1_l}    ${ADDRESS}
    Run Keyword And Warn On Failure    Element Should Contain    ${payment_ShipInfo_zip_l}         ${ZIP}
    Run Keyword And Warn On Failure    Element Should Contain    ${payment_ShipInfo_phone_l}         ${PHONE}

    ${populatedAddress2}=   Run Keyword And Return Status    Element Should Contain    ${payment_ShipInfo_addr2_l}     ${ADDRESS2}    timeout=3s
    Run Keyword If    ${populatedAddress2}    Element Should Contain    ${payment_ShipInfo_addr2_l}     ${ADDRESS2}

Verify that the shipping method is correct on Payment page
    [Arguments]    ${SHIP_M}
    Run Keyword And Warn On Failure    Wait Until Element Is Visible    ${payment_ShipInfo_method_l}     10s   error=Shipping contact Method not displayed
    Run Keyword And Warn On Failure    Element Should Contain    ${payment_ShipInfo_method_l}       ${SHIP_M}

Click on Edit Shipping link from Payment step
    Scroll Element Into View    ${payment_ShipInfo_edit_l}
    Sleep  3s
    Click Element    ${payment_ShipInfo_edit_l}
    Wait Until Location Contains    /checkout?stage=shipping#shipping

Expand the Redeem Gift Card section
    Scroll Element Into View    ${pay_gift_card_area_l}
    Click Element    ${pay_gift_card_area_l}
    Wait Until Page Contains Element    ${pay_gift_card_expanded_l}     5s     error=Gift Card Section is not expanded

Expand the Promo Code section
    Execute Javascript    window.scrollTo(0,document.body.scrollHeight/2)
    CommonWeb.Scroll And Click by JS    ${pay_promo_code_title_l}
    Wait Until Page Contains Element    ${pay_promo_code_input_l}     5s     error=Promo Code Section is not expanded

Click on Add Promo Code button
    CommonWeb.Scroll And Click by JS    ${pay_add_promo_code_l}

Verify the Empty field validation message for Promo Code
    Run Keyword And Warn On Failure     Wait Until Element Is Visible      ${pay_promo_empty_err_l}     5s     error=Error message is not visible
    Run Keyword And Warn On Failure     Element Text Should Be    ${pay_promo_empty_err_l}    ${pay_promo_empty_err}

Click on Apply button
    CommonWeb.Click by JS    ${pay_gift_card_apply_l}

Enter a valid promo code
    [Arguments]    ${promo}
    Input Text    ${pay_promo_code_input_l}    ${promo}
    Set Test Variable    ${promo}

Verify the successful promo code message
    Wait Until Element Is Visible    ${checkout_coupon_applied_l}     30s     error=Promo Code Success message is not visible
    ${expected_msg}=    set variable    ${promo} applied
    Run Keyword And Warn On Failure     Element Should Contain    ${checkout_coupon_applied_l}    ${expected_msg}

Extract Coupon Amount
    ${success_promo_msg}=    Get Text    ${checkout_coupon_applied_l}
    ${start_index}=    Evaluate    "${success_promo_msg}".find('$')
    ${amount}=    Get Substring    ${success_promo_msg}    ${start_index}
    ${amount_without_currency}=    Set Variable    ${amount.replace('$', '')}
    Set Test Variable    ${amount_without_currency}

Check if Subtotal was updated with promo code discount
    ${subtotal}=    Get Text    ${checkout_summary_subtotal_l}
    ${product_price}=    Get Text    ${checkout_summary_product_p_l}
    ${subtotal_without_currency}=    Set Variable    ${subtotal.replace('$', '')}
    ${product_price_without_currency}=    Set Variable    ${product_price.replace('$', '')}
    ${expected_subtotal}=    Evaluate    ${product_price_without_currency} - ${amount_without_currency}
    Run Keyword And Warn On Failure     Should Be Equal As Numbers    ${expected_subtotal}    ${subtotal_without_currency}
    Set Test Variable    ${subtotal_without_currency}
    Set Test Variable    ${expected_subtotal}

Verify the Empty fields validation messages for Gift Card
    Run Keyword And Warn On Failure     Wait Until Element Is Visible      ${payment_nr_empty_err_l}     5s     error=Error message is not visible
    Run Keyword And Warn On Failure     Element Text Should Be    ${payment_nr_empty_err_l}    ${payment_number_empty_err}
    Run Keyword And Warn On Failure     Wait Until Element Is Visible      ${payment_pin_empty_err_l}     5s     error=Error message is not visible
    Run Keyword And Warn On Failure     Element Text Should Be    ${payment_pin_empty_err_l}    ${payment_pin_empty_err}

Verify the invalid fields validation message for Gift Card
    Fill in the Redeem Gift Card form    ${invalid_gcn}    ${invalid_pin}
    Click on Apply button
    Wait Until Page Contains Element    ${pay_gift_card_err_l}     5s     error=Error message is not visible
    Wait Until Element Is Visible    ${pay_gift_card_err_l}     5s     error=Error message is not visible
    Run Keyword And Warn On Failure     Element Text Should Be    ${pay_gift_card_err_l}    ${pay_gift_card_err}

Fill in the Redeem Gift Card form
    [Arguments]    ${gcn}    ${pin}
    ${gcn_visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${payment_gcn_l}     5s     error=Gift Card Number is not visible
    Run Keyword If    ${gcn_visible}     Scroll To Element   ${payment_gcn_l}
    Run Keyword If    ${gcn_visible}     CommonWeb.Check and Input text          ${payment_gcn_l}    ${gcn}
    ${pin_visible}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${payment_pin_l}     5s     error=Gift Card Pin is not visible
    Run Keyword If    ${pin_visible}     Scroll To Element   ${payment_pin_l}
    Run Keyword If    ${pin_visible}     CommonWeb.Check and Input text          ${payment_pin_l}    ${pin}

Select/Unselect Billing Same As Shipping checkbox
    Scroll Element Into View    ${billing_same_as_ship_l}
    Sleep  2s
    Click by JS    ${billing_same_as_ship_l}
    Wait Until Page Contains Element    ${billing_fn_l}     5s     error=First Name field is not loaded

Verify the Empty fields validation messages for Credit Card section
    Run Keyword And Warn On Failure     Wait Until Page Contains Element      ${payment_cc_nr_empty_err_l}     5s     error=Error message is not visible
    Execute Javascript    window.scrollTo(0,document.body.scrollHeight/2)
    CommonWeb.Scroll To Element    ${payment_cc_nr_empty_err_l}
    Run Keyword And Warn On Failure     Element Text Should Be    ${payment_cc_nr_empty_err_l}    ${payment_cc_nr_empty_err}
    Run Keyword And Warn On Failure     Wait Until Page Contains Element      ${payment_cc_owner_empty_err_l}     5s     error=Error message is not visible
    Run Keyword And Warn On Failure     Element Text Should Be    ${payment_cc_owner_empty_err_l}    ${payment_cc_name_empty_err}
    Run Keyword And Warn On Failure     Wait Until Page Contains Element      ${payment_cc_exp_m_empty_err_l}     5s     error=Error message is not visible
    Run Keyword And Warn On Failure     Element Text Should Be    ${payment_cc_exp_m_empty_err_l}    ${payment_cc_exp_m_empty_err}
    Run Keyword And Warn On Failure     Wait Until Page Contains Element      ${payment_cc_exp_y_empty_err_l}     5s     error=Error message is not visible
    Run Keyword And Warn On Failure     Element Text Should Be    ${payment_cc_exp_y_empty_err_l}    ${payment_cc_exp_y_empty_err}
    Run Keyword And Warn On Failure     Wait Until Page Contains Element      ${payment_cc_cvv_empty_err_l}     5s     error=Error message is not visible
    Run Keyword And Warn On Failure     Element Text Should Be    ${payment_cc_cvv_empty_err_l}    ${payment_cc_cvv_empty_err}

Verify the Empty fields validation messages for Billing Address section
    Run Keyword And Warn On Failure     Wait Until Element Is Visible      ${pay_bill_fn_empty_err_l}     5s     error=Error message is not visible
    Run Keyword And Warn On Failure     Element Text Should Be    ${pay_bill_fn_empty_err_l}    ${pay_bill_fn_empty_err}
    Run Keyword And Warn On Failure     Wait Until Element Is Visible      ${pay_bill_ln_empty_err_l}     5s     error=Error message is not visible
    Run Keyword And Warn On Failure     Element Text Should Be    ${pay_bill_ln_empty_err_l}    ${pay_bill_ln_empty_err}
    Run Keyword And Warn On Failure     Wait Until Element Is Visible      ${pay_bill_addr_empty_err_l}     5s     error=Error message is not visible
    Run Keyword And Warn On Failure     Element Text Should Be    ${pay_bill_addr_empty_err_l}    ${pay_bill_addr_empty_err}
    Run Keyword And Warn On Failure     Wait Until Element Is Visible      ${pay_bill_city_empty_err_l}     5s     error=Error message is not visible
    Run Keyword And Warn On Failure     Element Text Should Be    ${pay_bill_city_empty_err_l}    ${pay_bill_city_empty_err}
    Run Keyword And Warn On Failure     Wait Until Element Is Visible      ${pay_bill_state_empty_err_l}     5s     error=Error message is not visible
    Run Keyword And Warn On Failure     Element Text Should Be    ${pay_bill_state_empty_err_l}    ${pay_bill_state_empty_err}
    Run Keyword And Warn On Failure     Wait Until Element Is Visible      ${pay_bill_zip_empty_err_l}     5s     error=Error message is not visible
    Run Keyword And Warn On Failure     Element Text Should Be    ${pay_bill_zip_empty_err_l}    ${pay_bill_zip_empty_err}

Verify the invalid fields validation on Billing Address step
    Enter invalid Billing details        ${invalid_city}    ${invalid_zip}
    Click on Place Order CTA
    Run Keyword And Warn On Failure     Wait Until Element Is Visible      ${bill_city_invalid_err_l}     5s     error=Error message is not visible
    Run Keyword And Warn On Failure     Element Text Should Be    ${bill_city_invalid_err_l}    ${bill_city_invalid_err}
    Run Keyword And Warn On Failure     Wait Until Element Is Visible      ${bill_zip_invalid_err_l}     5s     error=Error message is not visible
    Run Keyword And Warn On Failure     Element Text Should Be    ${bill_zip_invalid_err_l}    ${shipping_zip_invalid_err}

Enter invalid Billing details
    [Arguments]    ${invalid_CITY}    ${invalid_ZIP}
    ${billingCityName}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${billing_city}     5s     error=Error message is not visible
    Run Keyword If    ${billingCityName}     Scroll To Element   ${billing_city}
    Run Keyword If    ${billingCityName}     CommonWeb.Check and Input text          ${billing_city}    ${invalid_CITY}
    CommonWeb.Scroll To Element    ${shipping_address_one}
    ${billingZipCode}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${billing_zip}     5s     error=Error message is not visible
    Run Keyword If    ${billingZipCode}     Scroll To Element   ${billing_zip}
    Run Keyword If    ${billingZipCode}     CommonWeb.Check and Input text          ${billing_zip}   ${invalid_ZIP}

Verify the invalid fields validation for Credit Card section
    Enter payment details    ${invalid_number}    ${card_exp}    ${invalid_csv}    ${invalid_card_holder}
    Click on Place Order CTA
    Wait Until Page Contains Element    ${billing_error_message_text}     5s     error=Error message is not loaded
    Wait Until Element Is Visible    ${billing_error_message_text}     5s     error=Error message is not visible
    Run Keyword And Warn On Failure     Element Text Should Be    ${billing_error_message_text}    ${billing_error_message_text_err}

Gift Card ID list
    IF    '${env}' == 'dev'
        &{giftCardID}=    Create Dictionary    6003920343559550=7715    6003920344000310=2574
    ELSE IF    '${env}' == 'uat'
        &{giftCardID}=    Create Dictionary    6003920343559550=7715    6003920344000310=2574
    ELSE IF    '${env}' == 'prod'
        &{giftCardID}=    Create Dictionary        6003920343559550=7715    6003920344000310=2574
    END
    Set Test Variable    &{giftCardID}    &{giftCardID}

Check the Gift Card Balances
    Gift Card ID list
    FOR    ${key}    IN    @{giftCardID.keys()}
        Fill in the Redeem Gift Card form    ${key}    ${giftCardID["${key}"]}
        Click on Apply button
        ${result}=    Run Keyword And Return Status    Page Should Contain Element    ${pay_gift_card_success_l}     15s
        Exit For Loop If    '${result}' == 'True'
    END

Remove the applied gift card
    ${result}=    Run Keyword And Return Status    Element Should Be Visible    ${pay_gift_card_success_l}     15s
    Run Keyword If    ${result}    CommonWeb.Scroll And Click by JS    ${pay_gift_card_remove_l}
    Wait Until Element Is Not Visible    ${pay_gift_card_success_l}     20s     error=Success message is not visible

Check that the correct tax was applied for state
    [Arguments]    ${STATE}
    ${state_taxes}    Create Dictionary    California=0.08876    Hawaii=0.045    Alaska=0
    Wait Until Element Is Visible    ${checkout_summary_tax_total_l}     15s     error=Order Summary Tax Total is not visible
    ${sales_tax}=    Get Text    ${checkout_summary_tax_total_l}
    ${sales_tax_without_currency}=    Set Variable    ${sales_tax.replace('$', '')}
    ${product_price}=    Get Text    ${checkout_summary_product_p_l}
    ${product_price_without_currency}=    Set Variable    ${product_price.replace('$', '')}
    ${expected_tax}=    Evaluate    ${product_price_without_currency} * ${state_taxes['${STATE}']}
    Run Keyword And Warn On Failure     Should Be Equal As Numbers    ${expected_tax}    ${sales_tax_without_currency}

Verify if Order Summary data is correct
    [Arguments]    ${size}    ${qty}
    ${os_variant}=    Get Text    ${checkout_summary_descript_l}
    Run Keyword And Warn On Failure     Should Be Equal As Strings    ${product_name_subtitle}    ${os_variant}
    ${os_size}=    Get Text    ${checkout_summary_size_l}
    Run Keyword And Warn On Failure     Element Text Should Be    ${checkout_summary_size_l}    Size ${size}
    ${os_qty}=    Get Text    ${checkout_summary_qty_l}
    ${os_qty_just_nr}=    Set Variable    ${os_qty.replace('Qty', '')}
    Run Keyword And Warn On Failure     Element Text Should Be    ${checkout_summary_qty_l}    Qty ${qty}
    ${subtotal}=    Get Text    ${checkout_summary_subtotal_l}
    ${product_price}=    Get Text    ${checkout_summary_product_p_l}
    ${subtotal_without_currency}=    Set Variable    ${subtotal.replace('$', '')}
    ${product_price_without_currency}=    Set Variable    ${product_price.replace('$', '')}
    ${expected_subtotal}=    Evaluate    ${product_price_without_currency} * ${${os_qty_just_nr}}
    Run Keyword And Warn On Failure     Should Be Equal As Numbers    ${expected_subtotal}    ${subtotal_without_currency}


Enter payment details for EU
    [Arguments]    @{varargs}
    Select Frame    xpath://iframe[@id='Intrnl_CO_Container']
    Select Frame    xpath://iframe[@id='secureWindow']
    Wait Until Page Contains Element    xpath://input[@id='cardNum']    20s    Payment method are not displayed
    ${expandedcc}=    Run Keyword And Return Status    Wait Until Element Is Visible    xpath://input[@id='cardNum']    timeout=3s
    IF    '${expandedcc}' == 'True'
        Scroll Page    0    document.getElementById('cardNum').offsetTop
        CommonWeb.Check and Input text    xpath://input[@id='cardNum']    ${varargs}[0]
        Scroll Page    0    document.getElementById('cardExpiryMonth').offsetTop
        Select From List By Label    xpath://select[@id='cardExpiryMonth']   03
        Scroll Page    0    document.getElementById('cardExpiryYear').offsetTop
        Select From List By Label    xpath://select[@id='cardExpiryYear']   2030
        Scroll Page    0    document.getElementById('cvdNumber').offsetTop
        CommonWeb.Check and Input text    xpath://input[@id='cvdNumber']    ${varargs}[2]
        Unselect Frame
    END

Verify if Order Summary data is correct for EU
    [Arguments]    ${size}    ${qty}
    Select Frame    xpath://iframe[@id='Intrnl_CO_Container']
    ${os_variant}=    Get Text    xpath:(//div[@class='attr-name productName'])[1]
    Run Keyword And Warn On Failure     Should Be Equal As Strings    ${product_name_subtitle}    ${os_variant}
    ${os_size}=    Get Text    xpath:(//div[@class='attr-value'])[1]
    Run Keyword And Warn On Failure     Element Text Should Be    ${checkout_summary_size_l}    Size ${size}
    ${os_qty}=    Get Text    (//div[@class='valign-cell product-qty'])[1]
    ${os_qty_just_nr}=    Set Variable    ${os_qty.replace('Qty', '')}
    Run Keyword And Warn On Failure     Element Text Should Be    ${checkout_summary_qty_l}    Qty ${qty}
    ${subtotal}=    Get Text    (//div[@class='valign-cell product-price'])[2]
    ${product_price}=    Get Text    xpath:(//div[@class='valign-cell product-price'])[1]
    ${subtotal_without_currency}=    Remove currency and comma from price  ${subtotal}
    ${product_price_without_currency}=    Remove currency and comma from price    ${product_price}
    ${expected_subtotal}=    Evaluate    ${product_price_without_currency} * ${${os_qty_just_nr}}
    Run Keyword And Warn On Failure     Should Be Equal As Numbers    ${expected_subtotal}    ${subtotal_without_currency}
    Unselect Frame


Verify if Billing Summary data is correct for EU
    ${billing_summary_total_price}  Get Text    xpath://div[@id='BillingSummaryTotalPrice']
    ${billing_summary_total_price}=   Remove currency and comma from price  ${billing_summary_total_price}
    ${billing_summary_total_total}  Get Text    xpath://div[@id='BillingSummaryTotalPrice']
    ${billing_summary_total_price}=   Remove currency and comma from price  ${billing_summary_total_price}


Check that the correct tax was applied for state cn
   [Arguments]    ${STATE}
    ${state_taxes}    Create Dictionary    Ottawa=0.13    Ontario=0.13
    Wait Until Element Is Visible    ${checkout_summary_tax_total_l}     15s     error=Order Summary Tax Total is not visible
    ${sales_tax}=    Get Text    ${checkout_summary_tax_total_l}
    ${sales_tax_currency}   Remove currency and comma from price  ${sales_tax}
    ${sales_tax_without_currency}=    Set Variable    ${sales_tax_currency}
    ${product_price}=    Get Text    ${checkout_summary_product_p_l}
    ${product_price_currency}   Remove currency and comma from price  ${product_price}
    ${product_price_without_currency}=    Set Variable    ${product_price_currency}
    ${expected_tax}=    Evaluate    ${product_price_without_currency} * ${state_taxes['${STATE}']}
    Run Keyword And Warn On Failure     Should Be Equal As Numbers    ${expected_tax}    ${sales_tax_without_currency}

Click on Place Order CTA for payment for EU
    [Arguments]    ${po_type}
    Select Frame    xpath://iframe[@id='Intrnl_CO_Container']
    Execute Javascript    window.scrollTo(0,document.body.scrollHeight/2)
    IF    "${po_type}" == "paypal"
        ${paypal_po_available}=    Run Keyword And Return Status    Wait Until Page Contains Element      xpath://*[@id="pmContainer"]/div[5]/span    20s
        Run Keyword If    ${paypal_po_available}     Scroll Element Into View    xpath://*[@id="pmContainer"]/div[5]/span
        Run Keyword If    ${paypal_po_available}     Click Element    xpath://*[@id="pmContainer"]/div[5]/span
        Run Keyword If    ${paypal_po_available}     CommonWeb.Click by JS    xpath://button[@id='btnPay']
    ELSE IF    "${po_type}" == "zero_order"
        Run Keyword And Warn On Failure    Wait Until Page Contains Element      ${payment_submit_zero_order_l}    20s    Submit Payment button is not fully loaded
        Scroll Element Into View    ${payment_submit_zero_order_l}
        Sleep  3s
        Click by JS     ${payment_submit_zero_order_l}
    ELSE
        Run Keyword And Warn On Failure    Wait Until Page Contains Element      xpath://button[@id='btnPay']    20s    Submit Payment button is not fully loaded
        Scroll Page    0    document.getElementById('btnPay').offsetTop
        CommonWeb.Click by JS    xpath://button[@id='btnPay']
    END
    Wait Until Location Contains    checkout#Global-e_International_Checkout    120s    Order Confirmation page is not fully loaded


On Paypal Account click on complete purchase
    Click Element    //button[@id='payment-submit-btn']
    Sleep    10s
    Switch Window    ${winHandles}[0]