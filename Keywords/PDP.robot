*** Settings ***
Library           SeleniumLibrary    screenshot_root_directory=EMBED
Resource          ../Resources/Locators.robot
Resource          ../Keywords/CommonWeb.robot
Resource          ../Keywords/Checkout.robot

*** Keywords ***
Open PDP for product with id
    [Arguments]    ${id}
    Go To    ${URL}${id}.html
    Wait Until Element Is Visible    ${pdp_product_name_l}    15s    error=Product Name is not visible

Select Size
    [Arguments]    ${size}
    Scroll Element Into View    css:button[data-attr-value='${size}']
    Mouse Over       css:button[data-attr-value='${size}']
    Click Element    css:button[data-attr-value='${size}']
    Wait Until Page Contains Element    ${pdp_selected_size_l}     10s    error=Size is not visible
    Sleep    3s    #tried with waits without success; the click is too fast

Check product style
   [Arguments]  ${style}
   Scroll Element Into View    xpath:(//li[@class='product-style-number'])[1]
   Element Text Should Be    xpath:(//li[@class='product-style-number'])[1]    Style #${style}

Check product UPC
   [Arguments]  ${UPC}
   Scroll Element Into View    xpath:(//li[@class='upc'])[1]
   Sleep  1s
   Element Text Should Be    xpath:(//li[@class='upc'])[1]     UPC ${UPC}

Select Color
    [Arguments]    ${color}
    Click Element    css:button[aria-label*='${color}']
    Wait Until Page Contains Element    ${pdp_selected_size_l}     10s    error=Size is not visible

Click Add To Cart Button from PDP
    Wait until underlay dissapears
    Click Element    ${pdp_add_to_cart_l}
    Verify Minicart modal is displayed

Wait until underlay dissapears
    Wait Until Page Contains Element    ${pdp_add_to_cart_l}     10s    error=Add To Cart is not loaded
    Wait Until Element Is Visible    ${pdp_add_to_cart_l}     10s    error=Add To Cart is not visible
    Wait Until Page Does Not Contain Element    ${pdp_underlay_l}    10s    error=Underlay is still visible

Verify Minicart modal is displayed
    Wait Until Page Contains Element    ${pdp_minicart_l}     10s    error=Minicart is not visible
    #Wait Until Element Is Visible    ${pdp_minicart_l}     10s    error=Minicart is not visible

Check that the button label is Pre-Order
    Wait until underlay dissapears
    Run Keyword And Continue On Failure    Element Text Should Be    ${pdp_add_to_cart_l}    PRE-ORDER

Add multiple products to the cart
    [Arguments]    @{products_with_sizes}
    FOR    ${product_with_size}    IN    @{products_with_sizes}
        ${split_product_with_size}=    Evaluate    $product_with_size.split('=')
        ${product_id}=    Set Variable    ${split_product_with_size[0]}
        ${size}=    Set Variable    ${split_product_with_size[1]}
        Open PDP for product with id    ${product_id}
        Close the Get the First Look modal
        Select Size    ${size}
        Click Add To Cart Button from PDP
    END

Navigate to Category
    [Arguments]    ${category}
    Mouse Over    css:#${category}
    Wait Until Page Contains Element    css:#${category}+button+.mega-menu.show     5s    error=Category is not loaded
    Wait Until Element Is Visible    css:#${category}+button+.mega-menu.show     5s    error=Category is not visible
    Set Test Variable    ${category}

Navigate to Subcategory
    [Arguments]    ${subcategory}
    Mouse Over    css:#${category}-${subcategory}
    Wait Until Page Contains Element    css:.show [aria-label="${category}"] li:nth-child(1).dropdown-item.level-2     5s    error=Category is not loaded
    Wait Until Element Is Visible    css:.show [aria-label='${category}'] li:nth-child(1).dropdown-item.level-2     5s    error=Category is not visible
    Set Test Variable    ${subcategory}

Navigate to l3 subcategory
    [Arguments]    ${l3subcategory}
    Wait Until Element Is Visible    css:.dropdown-menu [href*='/${category}/${subcategory}/${l3subcategory}-bracelets.html']    5s    error=Category is not visible
    Mouse Over    css:.dropdown-menu [href*='/${category}/${subcategory}/${l3subcategory}-bracelets.html']
    Click Element    css:.dropdown-menu [href*='/${category}/${subcategory}/${l3subcategory}-bracelets.html']

Get product primary name from PDP
    ${product_primary_name}=  Get Text    ${primary_name_locator}
    Set Test Variable    ${product_primary_name}    ${product_primary_name}

Get product secondary name
    ${product_secondary_name}=  Get Text    ${secondary_name_locator}
    Set Test Variable    ${product_secondary_name}   ${product_secondary_name}

Click on Subcategory
    Click Element    css:#${category}-${subcategory}

Navigate and click on Subcategory
    [Arguments]    ${subcategory}
    Navigate to Subcategory    ${subcategory}
    Click on Subcategory

Click on Wish icon from PDP
    CommonWeb.Scroll And Click by JS    ${pdp_wish_icon_l}

Check if PDP is displayed correctly (general information, buttons, tabs, price)
    Run Keyword And Warn On Failure     Element Text Should Be       ${pdp_add_to_cart_l}           ${pdp_add_to_cart_exp}
    Run Keyword And Warn On Failure     Element Text Should Be       ${pdp_customer_care_l}         ${pdp_customer_care_exp}
    Run Keyword And Warn On Failure     Element Should Be Visible    ${pdp_complimentary_links_l}
    Run Keyword And Warn On Failure     Element Text Should Be       ${pdp_designer_note_l}         ${pdp_designer_note_exp}
    Run Keyword And Warn On Failure     Element Text Should Be       ${pdp_care_l}                  ${pdp_care_exp}
    Run Keyword And Warn On Failure     Element Text Should Be       ${pdp_gifting_l}               ${pdp_gifting_exp}

Compare the price from PLP to the one from PDP
    ${range_available}    Run Keyword And Return Status    Wait Until Element Is Visible    ${pdp_price_range_l}    5s    Price range is not visible
    IF    "${range_available}" == "True"
        ${pdp_product_price}    Get Text    ${pdp_price_range_l}
    ELSE
        ${pdp_product_price}    Get Text    ${pdp_price_value_l}
    END
    Run Keyword And Warn On Failure  Should Be Equal As Strings    ${pdp_product_price}    ${plp_product_price}

Check if a product with no stock is displayed correctly
    Run Keyword And Warn On Failure     Wait Until Element Is Visible    ${pdp_notify_me_btn_l}     10s    Notify Me button is not visible
    Run Keyword And Warn On Failure     Element Text Should Be    ${pdp_notify_me_btn_l}    ${pdp_notify_me_btn_exp}


Save the product subtitle on PDP
    ${product_name_subtitle}    Get Text    ${pdp_product_subtitle_l}
    Set Test Variable    ${product_name_subtitle}

Check if a product with variations is displayed correctly
    Wait Until Element Is Visible    ${pdp_variant_l}
    ${total_variants}    Get Element Count    ${pdp_variant_title_l}
    FOR    ${nr}    IN RANGE    1    ${total_variants}+1
        Mouse Over    css:.attribute-variants-pdp [data-secondarytitle]:nth-child(${nr})
        ${variant_title}    Get Element Attribute    css:.attribute-variants-pdp [data-secondarytitle]:nth-child(${nr})    data-secondarytitle
        Save the product subtitle on PDP
        Run Keyword And Warn On Failure     Should Be Equal As Strings    ${product_name_subtitle}    ${variant_title}
    END

Click on Notify Me button
    Click Element    ${pdp_add_to_cart_l}
    Wait Until Page Contains Element    ${pdp_notify_me_title_l}    5s    Notify Me button is not loaded
    Wait Until Element Is Visible    ${pdp_notify_me_title_l}    5s    Notify Me button is not visible
    Run Keyword And Warn On Failure     Element Text Should Be    ${pdp_notify_me_title_l}    ${pdp_notify_me_title_exp}

Fill in the Notify Me form
    [Arguments]    ${fn}    ${ln}    ${mail}
    Input Text    ${pdp_notify_me_fn_l}    ${fn}
    Input Text    ${pdp_notify_me_ln_l}    ${ln}
    Input Text    ${pdp_notify_me_mail_l}    ${mail}
    Wait Until Page Contains Element    ${pdp_notify_me_mail_fill_l}     5s    error=Submit button is not activated

Submit the Notify Me form and check the result
    Click Element    ${pdp_notify_me_l}
    Wait Until Element Is Visible    ${pdp_notify_me_msg_l}     20s    error=Notify Me modal is not yet closed
    Run Keyword And Warn On Failure     Element Text Should Be    ${pdp_notify_me_msg_l}    ${pdp_notify_me_msg_exp}

Click on Contact Customer Care button from PDP
    Click Element    ${pdp_customer_care_l}
    Wait Until Element Is Visible    ${pdp_customer_care_title_l}     10s    error=We’re here to help modal is not yet opened

Close the Contact Customer Care modal
    Click Element    ${pdp_customer_care_close_l}
    Wait Until Element Is Not Visible    ${pdp_customer_care_title_l}     10s    error=We’re here to help modal is not yet closed

Click on Size Guide button from PDP
    Click Element    ${pdp_size_guide_l}
    Wait Until Element Is Visible    ${pdp_size_guide_title_l}    10s    error=Find the Perfect Fit modal is not yet opened

Close the Size Guide modal
    Click Element    ${pdp_size_guide_close_l}
    Wait Until Element Is Not Visible    ${pdp_size_guide_title_l}    10s    error=Find the Perfect Fit modal is not yet opened

Capture the product price from PDP
    ${product_price_from_pdp} =    Get Text    ${pdp_price_value_l}
    ${product_price_pdp}    Set Test Variable    ${product_price_from_pdp}

Click on image number from PDP image gallery
    [Arguments]    ${open_img}
    Click Element    css:.pdp-img-container:nth-child(${open_img}) a img
    Wait Until Element Is Visible    ${pdp_open_image_l}    10s    error=PDP image is not visible
    ${img_total}    Get Element Count    ${pdp_total_image_l}
    Set Test Variable    ${img_total}
    Set Test Variable    ${open_img}

Swipe to last image (on PDP image gallery)
    FOR    ${img}    IN RANGE    ${open_img}    ${img_total}
        Click Element    ${pdp_img_next_arrow_l}
        ${current_img}=    Evaluate    ${img}+1
        Run Keyword And Warn On Failure     Element Text Should Be    ${pdp_img_counter_l}    "${current_img} / ${img_total}"
    END

Click on Zoom icon from PDP image gallery
    Click Element    ${pdp_img_zoom_l}
    Wait Until Page Contains Element    ${pdp_img_zoom_in_l}    10s    error=Image is not zoomed in

Click on Close icon from PDP image gallery
    Click Element    ${pdp_img_close_l}
    Wait Until Element Is Not Visible    ${pdp_img_close_l}    10s    error=Close icon is still visible

Click on Pick up at David Yurman boutique
    Click Element    ${pdp_pickup_store_btn_l}
    Wait Until Element Is Visible    ${pdp_pickup_store_close_l}    10s    error=Pick Up modal is not visible

Fill in the Zip and Distance on Pickup In Store modal
    [Arguments]    ${zip}    ${distance}
    Input Text    ${pdp_pickup_store_zip_l}    ${zip}
    Click Element    ${pdp_pickup_store_dist_l}
    Wait Until Page Contains Element    ${pdp_pickup_store_drop_l}    10s    error=Distance list is not visible
    Click Element    xpath://div[contains(@class, 'selectric-open')]//li[contains(.,'${distance}')]

Click on Search from Pickup In Store modal
    Click Element    ${pdp_pickup_store_search_l}
    Wait Until Element Is Visible    ${pdp_pickup_search_first_res_l}    10s    error=Stores list is not visible

Click on Select This Store for available store nr
    [Arguments]    ${store_no}
    ${store_total}    Get Element Count    ${pdp_pickup_store_list_l}
    ${modal_store_title}    set variable    ""
    FOR    ${i}    IN RANGE    1    ${store_total}+1
        ${select_visible}    Run Keyword And Return Status    Wait Until Element Is Visible    xpath://div[contains(@class, 'mx-0')][${i}]//button[contains(.,'Select This Store')]    10s
        IF    "${select_visible}" == "True"
            ${modal_store_title}    Get Text    xpath://div[contains(@class, 'mx-0')][${i}]//span[contains(@class, 'title')]
            Click Element    xpath://div[contains(@class, 'mx-0')][${i}]//button[contains(.,'Select This Store')]
            Wait Until Element Is Not Visible    ${pdp_pickup_store_close_l}    10s    error=Pick Up modal is not visible
        END
    END
    Set Test Variable    ${modal_store_title}

Check that the selected store appears on PDP pick up
    Wait Until Element Is Visible    ${pdp_selected_store_l}    10s    error=Pick Up store name is not visible
    Run Keyword And Warn On Failure     Element Text Should Be    ${pdp_selected_store_l}    ${modal_store_title}

Verify the You May Also Like carousel
    Run Keyword And Warn On Failure     Element Text Should Be    ${pdp_ymal_title_l}    ${pdp_ymal_title_us_exp}
    Run Keyword And Warn On Failure     Element Should Be Visible    ${pdp_ymal_carousel_l}

Verify the Explore More From This Collection carousel
    Run Keyword And Warn On Failure     Element Text Should Be    ${pdp_emftc_title_l}    ${pdp_emftc_title_us_exp}
    Run Keyword And Warn On Failure     Element Should Be Visible    ${pdp_emftc_carousel_l}

Verify the Trending Now carousel
    Run Keyword And Warn On Failure     Element Text Should Be    ${pdp_trend_now_l}    ${pdp_trend_now_us_exp}
    Run Keyword And Warn On Failure     Element Should Be Visible    ${pdp_trend_now_carousel_l}

Check that badge is displayed on PDP
    Run Keyword And Warn On Failure     Wait Until Element Is Visible    ${pdp_badge_l}    10s    error=Badge is not visible
    Run Keyword And Warn On Failure     Element Text Should Be    ${pdp_badge_l}    ${pdp_badge_exp}

Select available store at
    [Arguments]    ${zip_code}
    CommonWeb.Check and Input text          ${store_locator_zipcode}            ${zip_code}
    CommonWeb.Check and Click               ${store_locator_distance_btn}
    CommonWeb.Check and Click               ${store_locator_distance_list}
    CommonWeb.Check and Click               ${store_locator_search_btn}
    Sleep  3s
    CommonWeb.Check and Click               ${store_locator_available_store}


Open BOPIS modal
    Scroll Element Into View    ${store_pickup_button}
    Check and Click                         ${store_pickup_button}
    Wait Until Element Is Visible           ${bopis_modal}             timeout=5s        error=BOPIS Modal is not visible

Select Address Pickup
    Check and Click                         ${address_pickup_button}
    Wait Until Element Is Enabled           ${address_pickup_button}        timeout=5s

Wait Until Minibag is Close
    Wait Until Element is not Visible       ${minicart_modal}         timeout=5s

Close mini cart modal
    Click Element    xpath://div[@class='minicart-close-btn']/button

Check Info Texts
        Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//a[@data-content='two-day-shipping'])[1]   ${checkout_info_2day_shipping_message}
        CommonWeb.Check and Click    xpath:(//a[@data-content='two-day-shipping'])[1]
        Wait Until Page Contains Element    ${checkout_info_modal_show_l}    10s    Info Modal is not visible
        Wait Until Element Is Visible    ${checkout_info_modal_title_l}    10s    Info Modal is not visible
        Run Keyword And Warn On Failure    Element Text Should Be    ${checkout_info_modal_title_l}   ${checkout_info_2day_shipping_title}
        Run Keyword And Warn On Failure    Element Text Should Be    xpath://div[@class='order-summary-content']   ${checkout_info_2day_shipping_message}
        CommonWeb.Check and Click    ${checkout_info_modal_close_l}
        Wait Until Element Is Not Visible    ${checkout_info_modal_title_l}    10s    Info Modal is still visible

        Run Keyword And Warn On Failure    Element Text Should Be    xpath:(//a[@data-content='30-day-returns'])[1]   ${checkout_info_30day_returns_title}
        CommonWeb.Check and Click    xpath:(//a[@data-content='30-day-returns'])[1]
        Wait Until Page Contains Element    ${checkout_info_modal_show_l}    10s    Info Modal is not visible
        Wait Until Element Is Visible    ${checkout_info_modal_title_l}    10s    Info Modal is not visible
        Run Keyword And Warn On Failure    Element Text Should Be    ${checkout_info_modal_title_l}   ${checkout_info_boutique_pick_up_title}
        Run Keyword And Warn On Failure    Element Text Should Be    xpath://div[@class='order-summary-content']   ${checkout_info_boutique_pickup_message}
        CommonWeb.Check and Click    ${checkout_info_modal_close_l}
        Wait Until Element Is Not Visible    ${checkout_info_modal_title_l}    10s    Info Modal is still visible


Check currency in PDP Page
     ${element_text}    Get Text    xpath:(//span[@class='value' and @content])[2]
 IF  '${shopLocale}' in ['US']
    Should Contain Text   ${element_text}    $
 ELSE IF '${shopLocale}' in ['CN']
    Should Contain Text   ${element_text}    C$
 ELSE IF '${shopLocale}' in ['UK']
    Should Contain Text   ${element_text}    £
ELSE IF '${shopLocale}' in ['FR']
    Should Contain Text   ${element_text}    €