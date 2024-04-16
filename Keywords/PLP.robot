*** Settings ***
Library           SeleniumLibrary    screenshot_root_directory=EMBED
Resource          ../Resources/Locators.robot
Resource          ../Keywords/CommonWeb.robot
Resource          ../Keywords/Checkout.robot

*** Keywords ***
Open the PDP with nth number from PLP product list
    [Arguments]    ${nr}
    ${pdp_open_from_plp}    Create List
    Wait Until Element Is Visible    xpath://div[contains(@class, 'js-tile-item') and not(contains(@class, 'd-none'))][${nr}]//div[@class='tile-body']//a[contains(@class,'product-tile-item-link')]     20s     error=Product Tile is not visible
    ${text}    Get Text    xpath://div[contains(@class, 'js-tile-item') and not(contains(@class, 'd-none'))][${nr}]//div[@class='tile-body']//a[contains(@class,'product-tile-item-link')]
    #get the product price
    ${range_avalable}    run keyword and return status    Wait Until Element Is Visible    xpath://div[contains(@class, 'js-tile-item') and not(contains(@class, 'd-none'))][${nr}]//div[@class='tile-body']//div[@class='price']/span[@class='range']
    IF    "${range_avalable}" == "True"
        ${plp_product_price_if}    Get Text    xpath://div[contains(@class, 'js-tile-item') and not(contains(@class, 'd-none'))][${nr}]//div[@class='tile-body']//div[@class='price']/span[@class='range']
    ELSE
        ${plp_product_price_if}    Get Text    xpath://div[contains(@class, 'js-tile-item') and not(contains(@class, 'd-none'))][${nr}]//div[@class='tile-body']//div[@class='price ']//span[@class='value']
    END
    Set Test Variable    ${plp_product_price}    ${plp_product_price_if}

    Append To List    ${pdp_open_from_plp}    ${text}
    Click Element    xpath://div[contains(@class, 'js-tile-item') and not(contains(@class, 'd-none'))][${nr}]//div[@class='tile-body']//a[contains(@class,'product-tile-item-link')]
    Wait Until Page Contains Element    ${pdp_product_show_l}     20s     error=Product Page is not entirely loaded

Add first number of products to wishlist from PLP
    [Arguments]    ${nr}
    Close the Get the First Look modal
    ${added_to_wishlist}    Create List
    FOR    ${nr_i}    IN RANGE    1    ${nr}+1
        Wait Until Element Is Visible    xpath://div[contains(@class, 'js-tile-item') and not(contains(@class, 'd-none'))][${nr_i}]//div[@class='tile-body']//a[contains(@class,'product-tile-item-link')]    10s     error=First Product Tile is not visible
        Execute JavaScript    window.scrollTo(0, 300);
        Sleep  2s
        Mouse Over    xpath:(//a[@title='Wishlist'])[${nr_i}]
        Scroll Element Into View    xpath:(//a[@title='Wishlist'])[${nr_i}]
        Click Element    xpath:(//a[@title='Wishlist'])[${nr_i}]
        Mouse Over    xpath://div[contains(@class, 'js-tile-item') and not(contains(@class, 'd-none'))][${nr_i}]//div[@class='tile-body']//a[contains(@class,'product-tile-item-link')]
        Wait Until Element Is Visible    xpath://div[contains(@class, 'js-tile-item') and not(contains(@class, 'd-none'))][${nr_i}]//a[contains(@class,'wishlistTile')]//*[name()='svg' and contains(@class,'icon-favorite-selected-red')]    10s     error=Red Heart icon is not visible
        ${text}    Get Text    xpath://div[contains(@class, 'js-tile-item') and not(contains(@class, 'd-none'))][${nr_i}]//div[@class='tile-body']//a[contains(@class,'product-tile-item-link')]
        Append To List    ${added_to_wishlist}    ${text}
    END
    Set Test Variable    ${added_to_wishlist}


Open the Product from PLP product list
    [Arguments]    ${nr}
    Wait Until Element Is Visible    xpath:(//div[@class='pdp-link'])[${nr}]     40s     error=Product Tile is not visible
    Click Element    xpath:(//div[@class='pdp-link'])[${nr}]
    Wait Until Page Contains Element    xpath:(//span[contains(@class,'product-name')])[1]     20s     error=Product Page is not entirely loaded

Check product style
   [Arguments]  ${style}
   Scroll Element Into View    xpath:(//li[@class='product-style-number'])[1]
   Element Text Should Be    xpath:(//li[@class='product-style-number'])[1]    Style #${style}

Check value in PLP search box
     [Arguments]    ${search_value}
     ${attribute_value}=    Get Element Attribute    xpath:(//form[@role='search']/input)[2]    value
     Should Contain Text    ${attribute_value}    ${search_value}

Check product UPC
   [Arguments]  ${UPC}
   Scroll Element Into View    xpath:(//li[@class='upc'])[1]
   Sleep  1s
   Element Text Should Be    xpath:(//li[@class='upc'])[1]     UPC ${UPC}