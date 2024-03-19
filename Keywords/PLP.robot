*** Settings ***
Library           SeleniumLibrary    screenshot_root_directory=EMBED
Resource          ../Resources/Locators.robot
Resource          ../Keywords/CommonWeb.robot
Resource          ../Keywords/Checkout.robot
*** Variables ***
${product_count}
*** Keywords ***
Open the PDP with nth number from PLP product list
    [Arguments]    ${nr}
    Wait Until Element Is Visible    css:.product-grid div:nth-child(${nr}).region a.link     20s     error=Product Tile is not visible
    ${text}    Get Text    css:.product-grid div:nth-child(${nr}).region a.link
    Append To List    ${added_to_wishlist}    ${text}
    Click Element    css:.product-grid div:nth-child(${nr}).region a.link
    Wait Until Page Contains Element    ${pdp_product_show_l}     20s     error=Product Page is not entirely loaded

Add first number of products to wishlist from PLP
    [Arguments]    ${nr}
    Close the Get the First Look modal
    ${added_to_wishlist}    Create List
    FOR    ${nr_i}    IN RANGE    1    ${nr}+1
        Wait Until Element Is Visible    css:.product-grid div:nth-child(${nr_i}).region a.link    10s     error=First Product Tile is not visible
        Mouse Over    css:.product-grid div:nth-child(${nr_i}).region a.link
        Click Element    css:.product-grid div:nth-child(${nr_i}).region .icon-favorite-unselected
        Mouse Over    css:.product-grid div:nth-child(${nr_i}).region a.link
        Wait Until Element Is Visible    css:.product-grid div:nth-child(${nr_i}).region .icon-favorite-selected-red    10s     error=Red Heart icon is not visible
        ${text}    Get Text    css:.product-grid div:nth-child(${nr_i}).region a.link
        Append To List    ${added_to_wishlist}    ${text}
    END
    Set Test Variable    ${added_to_wishlist}

Check value in PLP search box
     [Arguments]    ${search_value}
     ${attribute_value}=    Get Element Attribute    xpath:(//form[@role='search']/input)[2]    value
     Should Contain Text    ${attribute_value}    ${search_value}

Open the Product from PLP product list
    [Arguments]    ${nr}
    Wait Until Element Is Visible    xpath:(//div[@class='pdp-link'])[${nr}]     40s     error=Product Tile is not visible
    Click Element    xpath:(//div[@class='pdp-link'])[${nr}]
    Wait Until Page Contains Element    xpath:(//span[contains(@class,'product-name')])[1]     20s     error=Product Page is not entirely loaded
    
Open the Product quick view modal
     [Arguments]    ${nr}
     Mouse Over    xpath:(//div[@class='pdp-link'])[${nr}]
     Sleep  1s
     Wait Until Element Is Visible      xpath:(//a[contains(text(),'Quick View')])[1]   timeout=10s
     Click by JS    xpath:(//a[contains(text(),'Quick View')])[1]
     Sleep  1s
     Wait Until Element Is Visible    xpath://div[@class='row product-quickview-wrapper js-product-container m-0']   timeout=20s

Click add to bag
     Click Element   xpath://button[contains(text(),'Add to Bag')]

Go to womens amulet stacker
     Mouse Over    xpath://a[@id='womens']
     Sleep  2s
     Click Element    xpath://a[@id='womens-charms-and-amulets']
     Sleep  5s
     Close the Get the First Look modal
     Location Should Contain    /charms-and-amulets.html

Go to mens bracelet stacker
     Mouse Over    id:#mens
     Mouse Over    id:#mens-bracelets
     Click Element    id:#mens-beaded-bracelets
     Wait Until Element Is Visible    xpath:(//h1[contains(text(),'Men’s Beaded')])[1]


Check Lazy Loading
     ${elements} =    Get WebElements    xpath://div[@class='pdp-link']
     ${elements_length} =   Get Length    ${elements}
     Should Be Equal As Integers    ${elements_length}    32
     Scroll To Element    xpath:(//div[@class='pdp-link'])[32]
     Sleep  10s
     Wait Until Element Is Visible    xpath:(//div[@class='pdp-link'])[64]  timeout=50s
     ${elements_1} =    Get WebElements    xpath://div[@class='pdp-link']
     ${elements_length_1} =   Get Length    ${elements_1}
     Should Be Equal As Integers    ${elements_length_1}    64

Check category link
    [Arguments]  ${category}
    Click Element     xpath://a[@href="/${category}.html"]
    Sleep  1s
    Click Element     xpath://a[@href="/${category}.html"]
    ${current_location}=    Get Location
    Should End With    ${current_location}    ${category}.html

Go to Womens Category
    Click Element     xpath://a[@id='womens']