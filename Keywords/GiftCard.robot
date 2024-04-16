*** Settings ***
Library           SeleniumLibrary    screenshot_root_directory=EMBED
Resource          ../Resources/Locators.robot
Resource          ../Keywords/CommonWeb.robot
Resource          ../Keywords/Checkout.robot

*** Keywords ***
Fill Virtual GC PDP
    CommonWeb.Check and Input text          ${gift_card_pdp_fn}                     ${FIRST_NAME} 
    CommonWeb.Check and Input text          ${gift_card_pdp_ln}                     ${LAST_NAME} 
    CommonWeb.Check and Input text          ${gift_card_pdp_email}                  ${REGISTERED_email} 
    CommonWeb.Check and Input text          ${gift_card_pdp_sender}                 ${ADDRESS2}


Check VGC fields on the checkout
    ${li_elements}          Get WebElements                     ${gift_card_checkout_details}
    ${actual_services}      Convert WebElements to Strings      ${li_elements}
    CommonWeb.Check Substrings in List of String       ${actual_services}        ${expected_vdg_values}

Enter Gift message
     Scroll Element Into View    xpath://textarea[@id='giftMessageOrder']
     Input Text    //textarea[@id='giftMessageOrder']    Happy wishes
Get An Gift Card with Balance
    Open Gift Card PDP 
    Go to Check Balance modal
    ${actual_balance}       Set Variable    0

    FOR    ${gift_card_number}    IN    @{gift_cards_dict.keys()}
        ${gift_card_pin}=    Get From Dictionary    ${gift_cards_dict}    ${gift_card_number}
        ${actual_balance}           Get Gift Card Balance from Check Balance Modal    ${gift_card_number}     ${gift_card_pin}
        Run Keyword If                          ${actual_balance} > 0       Return From Keyword         ${gift_card_number}     ${gift_card_pin}
    END
    [Return]    ${None}    ${None}


Add Perpetual Gift Card
    Scroll Element Into View    ${payment_gift_card_expand_button}
    Click Element         ${payment_gift_card_expand_button} 
    Scroll Element Into View    ${check_balance_modal_gc_number}
    Input text    ${check_balance_modal_gc_number}        ${gift_card_number_100}         GC Number
    Scroll Element Into View    ${check_balance_modal_gc_pin}
    Input text    ${check_balance_modal_gc_pin}           ${gift_card_pin_100}            GC Pin
    Scroll Element Into View    ${payment_gift_card_apply_button}
    Sleep  2s
    Click Element         ${payment_gift_card_apply_button}

Open Gift Card PDP
    [Arguments]    ${is_virtual}=True
    Scroll To Bottom
    Check and Click                         ${gift_card_footer}
    Wait Until Page Contains Element         ${virtual_gift_card_img_initial_page}     10s     error=Virtual Card Initail page is not visible
    Run Keyword If          ${is_virtual}               Check and Click                         ${virtual_gift_card_img_initial_page}
    Run Keyword If          not ${is_virtual}           Check and Click                         ${physical_gift_card_img_initial_page}


Get Gift Card Balance from Check Balance Modal
    [Arguments]    ${gift_card_number}    ${gift_card_pin}
    Check and Input text                ${check_balance_modal_gc_number}    ${gift_card_number}     Gift Card Number
    Check and Input text                ${check_balance_modal_gc_pin}       ${gift_card_pin}        Gift Card Pin
    Check and Click                     ${check_balance_modal_gc_button}    Check Balance Button
    ${element_exists}                   Check Element Existence             ${check_balance_modal_gc_balance}
    IF      ${element_exists}
            ${balance}    Check and Get text    ${check_balance_modal_gc_balance}    Gift Card Balance
            ${amount_number}    Convert String with Currency to Number   ${balance}    
    ELSE
            ${amount_number}    Set Variable    0
    END
    [Return]    ${amount_number}


Select Amount Gift Card PDP
    [Arguments]     ${index}
    CommonWeb.Scroll And Click by JS            css:.selectric
    CommonWeb.Scroll And Click by JS            css:.product-variations-wrapper .selectric-items [data-index="${index}"]
    Wait Until Element Is Not Visible           css:.product-variations-wrapper .selectric-items [data-index="${index}"]     10s     error=Amount Gift Card PDP is still visible


Select an Available Physical Gift Card PDP
    ${gc_found}     Set Variable    False
    ${vector}       Create List    100    250    500    1000    2000
    ${count}        Set Variable    1

    FOR    ${value}    IN    @{vector}
        Select Amount Gift Card PDP     ${count}
        Wait Until Element Contains    css:.product-name-title    ${value}    timeout=10s
        ${text}=   Check and Get text      ${pdp_add_to_cart_l}
        IF    '${text}' == "ADD TO BAG"
            ${gc_found}    Set Variable    True
            Exit For Loop
        END
        ${count}    Evaluate    ${count} + 1
    END
    Run Keyword If    not ${gc_found}    Fail    No available physical gift card found

Check Gift card page location
    ${url}  Get Location
    Wait Until Location Contains        /gifts/gift-cards   timeout=10s   message= Gift Card Page Not loaded
