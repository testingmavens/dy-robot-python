*** Settings ***
Library           SeleniumLibrary    screenshot_root_directory=EMBED
Resource          ../Resources/Locators.robot
Resource          ../Resources/Variables.robot
Resource          ../Keywords/CommonWeb.robot
Resource          ../Keywords/Cart.robot

*** Keywords ***
Check if empty minicart is accessible from header
    Click Element    ${home_minicart_l}
    Wait Until Page Contains Element    ${home_mpopover_show_l}     10s     error=Minicart Modal is not loaded
    Wait Until Element Is Visible    ${home_mpopover_show_l}     10s     error=Minicart Modal is not visible
    Wait Until Element Is Visible    ${home_empty_minicart_l}     10s     error=Minicart Text is not visible
    Run Keyword And Warn On Failure     Element Text Should Be    ${home_empty_minicart_l}    ${home_empty_minicart_exp}
    Close the empty minicart

Check if Login is accessible from header
    Click Element    ${home_login_icon_l}
    Wait Until Page Contains Element    ${home_login_show_l}     10s     error=Login Page is not visible

Check if Country Selector is accessible from Footer
    Scroll To Element    ${home_choose_country_l}
    Click Element    ${home_choose_country_l}
    Wait Until Page Contains Element    ${home_csc_popup_l}     20s     error=Country Selector modal is not visible
    Wait Until Element Is Visible    ${home_csc_popup_l}     20s     error=Country Selector modal is not visible

Close the Country Selector modal
    Click Element    ${home_csc_popup_close_l}
    Wait Until Element Is Not Visible    ${home_csc_popup_l}    10s     error=Country Selector modal is still visible

Access the Wishlist page
    Click Element    ${home_fav_uns_l}
    Wait Until Page Contains Element    ${home_show_wishlist_l}     20s     error=Login Page is not visible

Access the Wishlist page and check the empty message
    Access the Wishlist page
    Check the empty message on Wishlist page

Check the empty message on Wishlist page
    Run Keyword And Warn On Failure    Element Text Should Be    ${home_wishlist_count_l}    (0)
    Run Keyword And Warn On Failure    Element Should Be Visible    ${home_wishlist_empty_l}
    Run Keyword And Warn On Failure    Element Text Should Be    ${home_wishlist_empty_l}   This list is empty.

Click on every link from footer and verify the correct pages are opened
    Access Support Links
    Access Legal Links
    Access About Us Links

Social media links
    Wait Until Page Contains Element    ${instagram_icon_l}    20s     error=Instagram icon is not visible
    ${instagram_link}=   Get Element Attribute     ${instagram_icon_l}    href
    ${youtube_link}=   Get Element Attribute     ${youtube_icon_l}    href
    ${facebook_link}=   Get Element Attribute    ${facebook_icon_l}    href
    ${pinterest_link}=   Get Element Attribute    ${pinterest_icon_l}    href
    ${twitter_link}=   Get Element Attribute    ${twitter_icon_l}    href
    ${tiktok_link}=   Get Element Attribute    ${tiktok_icon_l}    href
    Run Keyword And Warn On Failure     Should Be Equal    ${instagram_link}    ${expected_instagram_link}
    Run Keyword And Warn On Failure     Should Be Equal    ${youtube_link}    ${expected_youtube_link}
    Run Keyword And Warn On Failure     Should Be Equal    ${facebook_link}    ${expected_facebook_link}
    Run Keyword And Warn On Failure     Should Be Equal    ${pinterest_link}    ${expected_pinterest_link}
    Run Keyword And Warn On Failure     Should Be Equal    ${twitter_link}    ${expected_twitter_link}
    Run Keyword And Warn On Failure     Should Be Equal    ${tiktok_link}    ${expected_tiktok_link}

Check empty validation message for Stay in Touch Email field
    CommonWeb.Scroll And Click    ${home_subscribe_submit_l}

Subscribe to the newsletter
    [Arguments]    ${mail}
    Wait Until Page Contains Element    ${home_subscribe_input_l}    10s     error=Input field is not visible
    Input Text    ${home_subscribe_input_l}    ${mail}
    Click Element    ${home_subscribe_send_l}

Verify if the previously added products from PLP are listed on Wishlist page
    ${total_wishlist}    Get Element Count    ${cart_wishlist_list_l}
    FOR    ${id}    IN RANGE    1    ${total_wishlist}+1
        ${current_value}    Get Text    css:div:nth-child(${id}).product-info .item-name
        Run Keyword And Warn On Failure     List Should Contain Value    ${pdp_open_from_plp}    ${current_value}
    END

Verify if the previously added product from PDP is displayed on Wishlist page
    ${current_value}    Get Text    ${home_wishlist_first_item_l}
    Run Keyword And Warn On Failure     Should Contain Text    ${current_value}    ${product_name_subtitle}

Remove all products from Wishlist
    ${total_wishlist}    Get Element Count    ${cart_wishlist_list_l}
    FOR    ${id}    IN RANGE    ${total_wishlist}    0    -1
        Click Element    css:div:nth-child(${id}).product-info .remove-btn span
        Wait Until Element Is Not Visible    css:div:nth-child(${id}).product-info .remove-btn span    5s     error=Product tile is still visible
    END

Access Support Links
    ${total_support}    Get Element Count    ${home_suport_col_l}
    FOR    ${id}    IN RANGE    2    ${total_support}+2
        Wait Until Page Contains Element    css:div:nth-child(1).footer-item .menu-footer li:nth-child(${id}) a     15s     error=Page is not visible
        CommonWeb.Scroll And Click by JS    css:div:nth-child(1).footer-item .menu-footer li:nth-child(${id}) a
        ${rez}    Evaluate    ${id}-2
        Run Keyword And Warn On Failure     Wait Until Location Is    ${support_links}[${rez}]    5s     Support link is not yet loaded
        Go To    ${URL}
    END

Access Legal Links
    ${total_legal}    Get Element Count    ${home_legal_col_l}
    FOR    ${id}    IN RANGE    2    ${total_legal}+1
        Wait Until Element Is Visible    css:div:nth-child(2).footer-item .menu-footer li:nth-child(${id}) a     15s     error=Page is not visible
        Click Element    css:div:nth-child(2).footer-item .menu-footer li:nth-child(${id}) a
        ${rez}    Evaluate    ${id}-2
        Run Keyword And Warn On Failure     Wait Until Location Is    ${legal_links}[${rez}]    5s     Legal link is not yet loaded
    END

Access About Us Links
    ${total_aboutus}    Get Element Count    ${home_aboutus_col_l}
    FOR    ${id}    IN RANGE    2    ${total_aboutus}+1
        Wait Until Page Contains Element    css:div:nth-child(3).footer-item .menu-footer li:nth-child(${id}) a     15s     error=Page is not visible
        CommonWeb.Scroll And Click by JS    css:div:nth-child(3).footer-item .menu-footer li:nth-child(${id}) a
        ${rez}    Evaluate    ${id}-2
        Run Keyword And Warn On Failure     Wait Until Location Is    ${aboutus_links}[${rez}]    5s     About Us link is not yet loaded
        Go To    ${URL}
    END

Click on Category
    [Arguments]    ${cat}
    Mouse Over    css:#${cat}
    Sleep  2s
    Click by JS    css:#${cat}
    IF   '${cat}'== 'womens'
    Wait Until Location Contains    /women.html    timeout=30s
    END
    IF   '${cat}'!= 'womens'
    Wait Until Location Contains    /${cat}.html    timeout=30s
    END

Click on Add To Bag for nth element from Wishlist page
    [Arguments]    ${nr}
    Wait Until Element Is Visible    css:div:nth-child(${nr}).product-info .quickview .item-action-text    5s     error=Add To Bag is not visible
    Click Element    css:div:nth-child(${nr}).product-info .quickview .item-action-text
    Wait Until Element Is Visible    ${cart_wishlist_qv_l}    5s     error=Add To Bag is not visible


Click on Back to Top
    CommonWeb.Scroll And Click by JS    css:.back-to-top span
    Wait Until Element Is Visible   css:.top-banner-carousel-item-text    20s     The top banner carousel is not visible