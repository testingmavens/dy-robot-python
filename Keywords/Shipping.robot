*** Settings ***
Library           SeleniumLibrary    screenshot_root_directory=EMBED
Resource          ../Resources/Locators.robot
Resource          ../Resources/Errors.robot
Resource          ../Keywords/CommonWeb.robot
Resource          ../Keywords/Checkout.robot


*** Keywords ***
Click on Add Gift Message CTA
    CommonWeb.Scroll And Click    ${gift_msg_l}
    Wait Until Page Contains Element    ${gift_msg_show_l}    timeout=3s    error=Add Gift Message form is not displayed

Click on Remove Gift Message CTA
    Click Element    ${gift_msg_l}
    Wait Until Page Does Not Contain Element    ${gift_msg_show_l}    timeout=3s    error=Add Gift Message form is still displayed

Fill in the Gifting Form from Shipping step
    [Arguments]    ${gift_recipent}   ${gift_sender}   ${gift_message}
    ${recipent_true}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${giftRecipient_l}    timeout=3s    error=Recipent field is not visible
    Run Keyword If    ${recipent_true}    CommonWeb.Scroll To Element    ${giftRecipient_l}
    Run Keyword If    ${recipent_true}    Input text    ${giftRecipient_l}    ${gift_recipent}
    ${sender_true}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${giftSender_l}    timeout=3s    error=Sender field is not visible
    Run Keyword If    ${sender_true}    CommonWeb.Scroll To Element    ${giftSender_l}
    Run Keyword If    ${sender_true}    Input text    ${giftSender_l}    ${gift_sender}
    ${gift_true}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${giftMessage_l}    timeout=3s    error=Gift Message field is not visible
    Run Keyword If    ${gift_true}    CommonWeb.Scroll To Element    ${giftMessage_l}
    Run Keyword If    ${gift_true}    Input text    ${giftMessage_l}    ${gift_message}
    Set Test Variable    ${gift_recipent}
    Set Test Variable    ${gift_sender}
    Set Test Variable    ${gift_message}

Click on Preview Gift Message from Shipping step and verify the entered texts
    Click Element    ${gift_preview_l}
    Wait Until Page Contains Element    ${gift_preview_show_l}    timeout=3s        error=Preview Image did not appeared
    ${recipent_preview_text}    Get Text    ${gift_preview_rec_l}
    ${sender_preview_text}    Get Text    ${gift_preview_sen_l}
    ${gift_preview_text}    Get Text    ${gift_preview_txt_l}
    Run Keyword And Warn On Failure    Should Be Equal As Strings    ${recipent_preview_text}    ${gift_recipent}
    Run Keyword And Warn On Failure    Should Be Equal As Strings    ${sender_preview_text}    ${gift_sender}
    Run Keyword And Warn On Failure    Should Be Equal As Strings    ${gift_preview_text}    ${gift_message}

Check that the Gifting Image is visible
    Element Should Be Visible    ${gifting_image_l}

Enter valid Shipping details
    [Arguments]    ${GUEST_EMAIL}   ${FIRST_NAME}   ${LAST_NAME}   ${ADDRESS}   ${ADDRESS2}   ${ZIP}   ${PHONE}
    ${shippingMail}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${shipping_email}    timeout=3s
    Run Keyword If    ${shippingMail}     Scroll To Element   ${shipping_email}
    Run Keyword If    ${shippingMail}     CommonWeb.Check and Input text          ${shipping_email}    ${GUEST_email}
    ${shippingName}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${shipping_fn}    timeout=3s
    Run Keyword If    ${shippingName}     Scroll To Element   ${shipping_fn}
    Run Keyword If    ${shippingName}     CommonWeb.Check and Input text          ${shipping_fn}    ${FIRST_NAME}
    ${shippingLastName}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${shipping_ln}    timeout=3s
    Run Keyword If    ${shippingLastName}     Scroll To Element   ${shipping_ln}
    Run Keyword If    ${shippingLastName}     CommonWeb.Check and Input text          ${shipping_ln}    ${LAST_NAME}
    ${shippingPhoneNumber}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${shipping_phone}    timeout=3s
    Run Keyword If    ${shippingPhoneNumber}     Scroll To Element   ${shipping_phone}
    Run Keyword If    ${shippingPhoneNumber}     CommonWeb.Check and Input text          ${shipping_phone}    ${PHONE}
    ${shippingAddress1}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${shipping_address_one}    timeout=3s
    Run Keyword If    ${shippingAddress1}   Scroll To Element   ${shipping_address_one}
    Run Keyword If    ${shippingAddress1}   CommonWeb.Check and Input text          ${shipping_address_one}    ${ADDRESS}
    ${shippingCityName}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${shipping_city}    timeout=3s
    Run Keyword If    ${shippingCityName}     Scroll To Element   ${shipping_city}
    Run Keyword If    ${shippingCityName}     CommonWeb.Check and Input text          ${shipping_city}    ${CITY}
    CommonWeb.Scroll To Element    ${shipping_address_one}
    ${shippingStateName}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${shipping_state}    timeout=5s
    Run Keyword If    ${shippingStateName}    Click Element    ${shipping_state_lbl}
    Run Keyword If    ${shippingStateName}    Click Element    xpath://fieldset[@class="shipping-address-block "]//li[contains(.,'New York')]
    ${shippingZipCode}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${shipping_zip}    timeout=3s
    Run Keyword If    ${shippingZipCode}     Scroll To Element   ${shipping_zip}
    Sleep  2s
    Run Keyword If    ${shippingZipCode}     CommonWeb.Check and Input text  ${shipping_zip}   ${ZIP}

Enter invalid Shipping details
    [Arguments]    ${invalid_EMAIL}   ${invalid_PHONE}    ${invalid_CITY}    ${invalid_ZIP}
    ${shippingMail}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${shipping_email}    timeout=3s
    Run Keyword If    ${shippingMail}     Scroll To Element   ${shipping_email}
    Run Keyword If    ${shippingMail}     CommonWeb.Check and Input text          ${shipping_email}    ${invalid_EMAIL}
    ${shippingPhoneNumber}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${shipping_phone}    timeout=3s
    Run Keyword If    ${shippingPhoneNumber}     Scroll To Element   ${shipping_phone}
    Run Keyword If    ${shippingPhoneNumber}     CommonWeb.Check and Input text          ${shipping_phone}    ${invalid_PHONE}
    ${shippingCityName}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${shipping_city}    timeout=3s
    Run Keyword If    ${shippingCityName}     Scroll To Element   ${shipping_city}
    Run Keyword If    ${shippingCityName}     CommonWeb.Check and Input text          ${shipping_city}    ${invalid_CITY}
    CommonWeb.Scroll To Element    ${shipping_address_one}
    ${shippingZipCode}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${shipping_zip}    timeout=3s
    Run Keyword If    ${shippingZipCode}     Scroll To Element   ${shipping_zip}
    Run Keyword If    ${shippingZipCode}     CommonWeb.Check and Input text          ${shipping_zip}   ${invalid_ZIP}

Clear the Checkout Shipping form
    Press Keys     ${shipping_email}     CONTROL+A   DELETE
    Press Keys     ${shipping_fn}     CONTROL+A   DELETE
    Press Keys     ${shipping_ln}     CONTROL+A   DELETE
    Press Keys     ${shipping_phone}     CONTROL+A   DELETE
    Press Keys     ${shipping_address_one}     CONTROL+A   DELETE
    Press Keys     ${shipping_address_two}     CONTROL+A   DELETE
    Press Keys     ${shipping_city}     CONTROL+A   DELETE
    Press Keys     ${shipping_zip}     CONTROL+A   DELETE
    Click Element    ${shipping_state_lbl}
    Click Element    css:.selectric-shippingState [data-index="1"]

Verify the empty fields validation on Shipping Address step
    Run Keyword And Warn On Failure     Wait Until Element Is Visible      ${shipping_email_empty_err_l}      5s
    Run Keyword And Warn On Failure     Element Text Should Be    ${shipping_email_empty_err_l}    ${shipping_email_empty_err}
    Run Keyword And Warn On Failure     Wait Until Element Is Visible      ${shipping_fn_empty_err_l}      5s
    Run Keyword And Warn On Failure     Element Text Should Be    ${shipping_fn_empty_err_l}    ${shipping_fn_empty_err}
    Run Keyword And Warn On Failure     Wait Until Element Is Visible      ${shipping_ln_empty_err_l}      5s
    Run Keyword And Warn On Failure     Element Text Should Be    ${shipping_ln_empty_err_l}    ${shipping_ln_empty_err}
    Run Keyword And Warn On Failure     Wait Until Element Is Visible      ${shipping_phone_empty_err_l}   5s
    Run Keyword And Warn On Failure     Element Text Should Be    ${shipping_phone_empty_err_l}    ${shipping_phone_empty_err}
    Run Keyword And Warn On Failure     Wait Until Element Is Visible      ${shipping_city_empty_err_l}   5s
    Run Keyword And Warn On Failure     Element Text Should Be    ${shipping_city_empty_err_l}    ${shipping_city_empty_err}
    Run Keyword And Warn On Failure     Wait Until Element Is Visible      ${shipping_state_empty_err_l}   5s
    Run Keyword And Warn On Failure     Element Text Should Be    ${shipping_state_empty_err_l}    ${shipping_state_empty_err}
    Run Keyword And Warn On Failure     Wait Until Element Is Visible      ${shipping_zip_empty_err_l}     5s
    Run Keyword And Warn On Failure     Element Text Should Be    ${shipping_zip_empty_err_l}    ${shipping_zip_empty_err}

Click on Continue To Payment button
    CommonWeb.Scroll And Click by JS    ${submit_shipping_l}

Select an Address from Address Suggestion modal
    [Arguments]    ${selection}
    ${suggested_modal_true}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${shipping_show_verify_l}    10s
    Run Keyword If    ${suggested_modal_true}     CommonWeb.Check and Click    css:input[data-type='${selection}']+label
    Run Keyword If    ${suggested_modal_true}    Click on Continue button from Select An Address modal

Select the Suggested Address from Address Suggestion modal
    ${suggested_modal_true}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${shipping_show_verify_l}    10s
    Run Keyword If    ${suggested_modal_true}     CommonWeb.Check and Click           ${shipping_address_one_l}
    Run Keyword If    ${suggested_modal_true}    Click on Continue button from Select An Address modal

Click on Continue button from Select An Address modal
    Click Element    ${shipping_save_selected_add}
    Wait Until Location Contains    ?stage=payment#payment    10s    Payment step was not loaded in 10s

Check that the default Delivery Method is selected
    [Arguments]    ${del}
    Run Keyword And Warn On Failure    Element Text Should Be    ${shipping_selected_del_l}    ${del}

Select Delivery
    [Arguments]    ${del}
    IF    "${del}" == "2-day"
        CommonWeb.Scroll And Click by JS    ${shipping_2_day_del_l}
    ELSE IF    "${del}" == "Overnight"
        CommonWeb.Scroll And Click by JS    ${shipping_overnight_del_l}
        ${over_night_delivery_selected}=    Run Keyword And Return Status  Wait Until Page Contains Element    ${shipping_selected_shipping_l}    10s    Shipping is not yet selected
    ELSE IF    "${del}" == "Standard"
        CommonWeb.Scroll And Click by JS    ${shipping_standard_del_l}
    END
    Wait Until Page Contains Element    ${shipping_selected_shipping_l}    10s    Shipping is not yet selected
    ${selected_shipping_cost}     Check and Get text    ${shipping_sale_shipping_l}
    Set Test Variable    ${retrieved_shipping_cost}    ${selected_shipping_cost}

Check if the Shipping cost was update in the Summary
    ${summary_shipping}    Check and Get text    css:.d-lg-block .shipping-total-cost
    Run Keyword And Warn On Failure     Should Be Equal As Strings    ${summary_shipping}    ${retrieved_shipping_cost}

Verify the invalid fields validation on Shipping Address step
    Enter invalid Shipping details        ${invalid_email}    ${invalid_phone}    ${invalid_city}    ${invalid_zip}
    Click on Continue To Payment button
    Run Keyword And Warn On Failure     Wait Until Element Is Visible      ${shipping_email_empty_err_l}      5s
    Run Keyword And Warn On Failure     Element Text Should Be    ${shipping_email_empty_err_l}    ${shipping_email_empty_err}
    Run Keyword And Warn On Failure     Wait Until Element Is Visible      ${shipping_phone_empty_err_l}   5s
    Run Keyword And Warn On Failure     Element Text Should Be    ${shipping_phone_empty_err_l}    ${shipping_phone_invalid_err}
    Run Keyword And Warn On Failure     Wait Until Element Is Visible      ${shipping_city_empty_err_l}   5s
    Run Keyword And Warn On Failure     Element Text Should Be    ${shipping_city_empty_err_l}    ${shipping_city_invalid_err}
    Run Keyword And Warn On Failure     Wait Until Element Is Visible      ${shipping_zip_empty_err_l}     5s
    Run Keyword And Warn On Failure     Element Text Should Be    ${shipping_zip_empty_err_l}    ${shipping_zip_invalid_err}

Enter text in shipping address
    [Arguments]     ${add}
    Scroll To Element   ${shipping_address_one}
    CommonWeb.Check and Input text          ${shipping_address_one}     ${add}

Verify the address suggestions are NOT displayed
    Wait Until Page Contains Element    ${dqe_disabled}      20s     error= Address Suggestions are displayed

Verify the address suggestions are displayed
    Wait Until Page Contains Element    ${dqe_enabled}    20s     error= Address Suggestions are not loaded
    Scroll Page    0    30
    Wait Until Element Is Visible    ${dqe_enabled}     20s     error= Address Suggestions are not visible
    Wait Until Element Is Visible    ${dqe_enabled_lbl}     20s     error= Address Suggestions are not visible

Select suggestion number
    [Arguments]     ${nr}
    Wait Until Element Is Visible    ${dqe_enabled_list}     20s     error= Address Suggestions are not visible
    Click Element   css:.pac-container .pac-item:nth-child(${nr}) .pac-item-query+span

Fill in the remaining Shipping details
    [Arguments]     ${mail}    ${fn}    ${ln}    ${phone}
    Execute Javascript    window.scrollTo(0,document.body.scrollHeight/2)
    Scroll To Element   ${shipping_email}
    CommonWeb.Check and Input text          ${shipping_email}    ${mail}
    Scroll To Element   ${shipping_fn}
    CommonWeb.Check and Input text          ${shipping_fn}    ${fn}
    Scroll To Element   ${shipping_ln}
    CommonWeb.Check and Input text          ${shipping_ln}    ${ln}
    Scroll To Element   ${shipping_phone}
    CommonWeb.Check and Input text          ${shipping_phone}    ${phone}

Check delivery date for the shipping method
   [Arguments]  ${shipping_method}
   ${currentDate}    Get Current Date
   ${currentDay}    Get Current Date    result_format=%A
   IF  "${shipping_method}" == "2-day"
     IF  '${currentDay}' == 'Thursday'
       ${deliveryDate}=  Add Time To Date    ${currentDate}    4 days
     ELSE IF  '${currentDay}' == 'Friday'
        ${deliveryDate}=  Add Time To Date    ${currentDate}    3 days
     ELSE
        ${deliveryDate}=  Add Time To Date    ${currentDate}    2 days
     END
     ${converted_delivery_Date}=  Convert Date   ${deliveryDate}    date_format=%Y-%m-%d %H:%M:%S.%f     result_format=%A, %m/%d
     Run Keyword And Warn On Failure    Element Text Should Be     ${shipping_method_message_l}    ${shipping_delivery_date_message} by ${converted_delivery_Date}.
   ELSE IF  "${shipping_method}" == "Overnight"
      ${deliveryDate}=  Add Time To Date    ${currentDate}    1 days
      ${converted_delivery_Date}=  Convert Date   ${deliveryDate}    date_format=%Y-%m-%d %H:%M:%S.%f     result_format=%A, %m/%d
      Run Keyword And Warn On Failure    Element Text Should Be     ${shipping_method_message_l}   ${shipping_delivery_date_message} on ${converted_delivery_Date}.
   END



Change the state and zip
    [Arguments]    ${STATE}    ${ZIP}
    CommonWeb.Scroll To Element    ${shipping_address_one}
    ${shippingStateName}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${shipping_state}    timeout=5s
    Run Keyword If    ${shippingStateName}    Click Element    ${shipping_state_lbl}
    Scroll Element Into View    xpath://fieldset[@class="shipping-address-block "]//li[contains(.,'${STATE}')]
    Run Keyword If    ${shippingStateName}    Click Element    xpath://fieldset[@class="shipping-address-block "]//li[contains(.,'${STATE}')]
    ${shippingZipCode}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${shipping_zip}    timeout=3s
    Run Keyword If    ${shippingZipCode}     Scroll To Element   ${shipping_zip}
    Run Keyword If    ${shippingZipCode}     CommonWeb.Check and Input text  ${shipping_zip}   ${ZIP}

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