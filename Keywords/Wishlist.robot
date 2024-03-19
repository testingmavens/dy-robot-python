*** Settings ***
Library           SeleniumLibrary    screenshot_root_directory=EMBED
Resource          ../Resources/Locators.robot
Resource          ../Resources/Locators/WishListLocators.robot
Resource          ../Keywords/CommonWeb.robot
Resource          ../Keywords/PDP.robot

** Keywords ***
Click email wishlist button
   Click Element  ${email_wishlist}

Click add to wishlist button
   Scroll And Click by JS    ${add_to_wishlish}
   Sleep  2s

Click go to wishlist
   Scroll Element Into View  ${go_to_wishlish}
   Click Element    ${go_to_wishlish}

Get product name from wishlist
   ${wishlist_product_name} =  Get Text    ${wishlist_product_name_locator}
   Set Test Variable   ${wishlist_product_name}

Check whether added item is displayed in wishlist
   Get product name from wishlist
   Should Contain Text   ${wishlist_product_name}   ${product_primary_name}

Click Move to bag button from wishlist
   Scroll Element Into View    xpath://span[text()='Add to Bag']
   Click Element    xpath://span[text()='Add to Bag']
   Wait Until Element Is Visible    xpath://div[contains(@class,'product-quickview-description')]

Click Remove from wishlist button
   Scroll Element Into View    xpath://span[contains(text(),'Remove')]
   Click Element    xpath://span[contains(text(),'Remove')]
   
Check whether wishlist is empty
   Element Should Be Visible    xpath://p[text()='This list is empty.']
   
Click on Add to Bag from quickview modal
    Scroll Element Into View    xpath://button[contains(@class,'add-to-cart btn btn-primary')]
    Click Element    xpath://button[contains(@class,'add-to-cart btn btn-primary')]
    Wait Until Element Is Visible    xpath://a[@title='View Bag']
   





