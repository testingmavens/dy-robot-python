*** Settings ***
Test Setup        Run Keywords    Open website   Read Data From JSON File  Close dev tools icon
Test Teardown     Run Keywords    Close All Browsers
Force Tags        Regression    automation
Library           SeleniumLibrary    screenshot_root_directory=EMBED
Resource          ../../Resources/Locators.robot
Resource          ../../Resources/Variables.robot
Resource          ../../Resources/Errors.robot
Resource          ../../Keywords/Checkout.robot
Resource          ../../Keywords/Cart.robot
Resource          ../../Keywords/OrderConfirmation.robot
Resource          ../../Keywords/Shipping.robot
Resource          ../../Keywords/Payment.robot
Resource          ../../Keywords/PDP.robot
Resource          ../../Keywords/PLP.robot
Resource          ../../Keywords/CommonWeb.robot
Resource          ../../Keywords/Login.robot
Resource          ../../Keywords/Homepage.robot
Resource          ../../Keywords/StoreLocator.robot
Resource          ../../Keywords/GiftCard.robot
Resource          ../../Keywords/MyAccount.robot
Resource          ../../Keywords/Search.robot

*** Test Cases ***
Search - 01 - Search / Product name and Best Match Sort
  @{query_list}=    Create List    curb chain bracelet   silver bracelet   gold necklace
  FOR    ${search_query}    IN    @{query_list}
    Search for a product from header search    ${search_query}
    Check did you mean suggestion is not displayed
    Check search instead option for    ${search_query}
    Check top results displayed for search  ${search_query}
    Click View all products
    Check all products in PLP search results contain  ${search_query}
  END


Search - 02 - Search / Product partial name and Best Match Sort
  @{query_list}=    Create List    curb   brace   necklace
  FOR    ${search_query}    IN    @{query_list}
    Search for a product from header search    ${search_query}
    Check did you mean suggestion for    ${search_query}
    Check search instead option for    ${search_query}
    Check top results displayed for search  ${search_query}
    Click View all products
    Check all products in PLP search results contain  ${search_query}
  END

Search - 03 - Search / Product Style
    Search for a product from header search    D25358MSSABD
    Check did you mean suggestion is not displayed
    Check search instead option for  D25358MSSABD
    Click search icon from header search
    Check value in PLP search box  D25358MSSABD
    Open the Product from PLP product list  1
    Sleep  1s
    Check product style    D25358MSSABD


Search - 04 - Search / Product UPC
    Search for a product from header search  192740978661
    Check did you mean suggestion is not displayed
    Check search instead option for  192740978661
    Click search icon from header search
    Check value in PLP search box  192740978661
    Open the Product from PLP product list  1
    Sleep  2s
    Check product UPC    192740978661

Search - 05 - Search / Navigate to PLP from Did you mean option
    Search for a product from header search  gold
    Check did you mean suggestion for  gold
    Capture did you mean suggestion
    Click did you mean suggestion
    Check value in PLP search box  ${actual_did_you_mean_phrase}
    Check all products in PLP search results contain  ${actual_did_you_mean_phrase}

Search - 06 - Check lazy loading
  Search for a product from header search    diamond
  Click search icon from header search
  Close the Get the First Look modal
  Check Lazy Loading

Search - 07 - Navigation of all category products
  Check category link  womens
  Close the Get the First Look modal
  Check category link  mens
  Check category link  whats-new
  Check category link  gifts
  Check category link  high-jewelry
  Check category link  wedding
  Check category link  world-of-yurman

Search - 08 - Blank search
  Search for a product from header search   ${SPACE}
  Click search icon from header search
  Close the Get the First Look modal
  Verify no results found page
  Check customer care link


Search - 09 - Search item from no results page
  Search for a product from header search    ww
  Click search icon from header search
  Close the Get the First Look modal
  Sleep  1s
  Search item from no results page   D25358MSSABD
  Open the Product from PLP product list  1
  Sleep  1s
  Check product style    D25358MSSABD


Search - 10 - Search for Gift Card
  Skip If    '${shopLocale}' in ['UK','FR','GR','IT']
  Search for a product from header search    Gift Card
  Click View all products
  Check Gift card page location


Search - 11 - Filter product with price range
  Search for a product from header search    diamond
  Click search icon from header search
  Close the Get the First Look modal
  Filter item by price range  750-1499.99
  Sleep  1s
  Check if products are filtered with price range  750-1499.99

Search - 12 - Sort product from price low to high
  Search for a product from header search    diamond
  Click search icon from header search
  Close the Get the First Look modal
  Sort item by  Price Low To High
  Sleep  1s
  Check Products are sorted by Price low to high

Search - 13 - Sort product from price high to low
  Search for a product from header search    diamond
  Click search icon from header search
  Close the Get the First Look modal
  Sort item by  Price High to Low
  Sleep  1s
  Check Products are sorted by Price high to low

Search - 14 - Sort product for best sellers
  Search for a product from header search    diamond
  Click search icon from header search
  Close the Get the First Look modal
  Sort item by  Best Sellers
  Check Products all products contains best seller tags
