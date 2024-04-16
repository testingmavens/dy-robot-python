*** Settings ***
Test Setup        Run Keywords    Open website
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
Resource          ../../Keywords/MiniCart.robot

*** Test Cases ***
Check empty minicart elements for guest user
    [Tags]  minicart
    Click on My Bag
    Verify whether title is displayed in empty guest minicart
    Verify whether shopping bag empty message is displayed
    Verify whether women and men toggle is displayed
    Verify whether shop by rails are displayed
    Verify whether trending now rails are displayed
    Verify by default women is selected

Check navigation from empty minicart for guest user
    [Tags]  minicart
    Click on My Bag
    Verify navigation from shop braclets for women
    Click on My Bag
    Verify whether user can toggle to men
    Verify whether the shop by rails changes to men
    Verify whether user can toggle to women
    Verify whether the shop by rails changes to women
    Verify whether user navigates to correct PLP page from trending now


Check minicart elements with delivery item in bag for guest user
    [Tags]  minicart
    Search for a product from header search  883932208184
    Click search icon from header search
    Close the Get the First Look modal
    Open the Product from PLP product list  1
    Select Size    5
    Capture product price from PDP
    Capture product primary name from PDP
    Capture product secondary name from PDP
    Save the product subtitle on PDP
    Sleep  2s
    Click Add To Cart Button from PDP
    Verify whether title is displayed in guest minicart
    Verify whether item count is displayed in minicart  1
    Verify whether delivery type for item is displayed in minicart  Delivery
    Compare item details in minicart with PDP  5
    Verify whether remove button is displayed for the product
    Verify whether quantity selector is displayed for the product
    Verify whether discover more rails are displayed
    Verify minicart buttons



Check minicart elements with pre order item in bag for guest user
    [Tags]  minicart
    Skip If  '${shopLocale}' in ['UK','FR','GR','IT']
    Search for a product from header search  192740636189
    Click search icon from header search
    Close the Get the First Look modal
    Open the Product from PLP product list  1
    Select Size    S
    Capture product price from PDP
    Capture product primary name from PDP
    Capture product secondary name from PDP
    Save the product subtitle on PDP
    Sleep  2s
    Click Pre order Button from PDP
    Verify whether title is displayed in guest minicart
    Verify whether item count is displayed in minicart  1
    Verify whether delivery type for item is displayed in minicart  Pre-Order
    Compare item details in minicart with PDP  S
    Verify whether remove button is displayed for the product
    Verify whether quantity selector is displayed for the product
    Verify whether discover more rails are displayed
    Verify minicart buttons


Check minicart elements with BOPIS item in bag for guest user
    [Tags]  minicart
    Skip If  '${shopLocale}' in ['UK','FR','GR','IT']
    Search for a product from header search  R15752MBB
    Click search icon from header search
    Close the Get the First Look modal
    Open the Product from PLP product list  1
    Select Size     6
    Capture product price from PDP
    Capture product primary name from PDP
    Capture product secondary name from PDP
    Save the product subtitle on PDP
    Sleep  2s
    Open BOPIS modal
    IF    '${shopLocale}' in ['US']
    Select available store at       92626
    END
    IF    '${shopLocale}' in ['CN']
    Select available store at       AB T2P 4H9
    END
    Get store location shown with product
    Click Add To Cart Button from PDP
    Verify whether title is displayed in guest minicart
    Verify whether item count is displayed in minicart  1
    Verify whether delivery type for item is displayed in minicart  Pick up
    Compare item details in minicart with PDP  6
    Verify whether remove button is displayed for the product
    Verify whether quantity selector is displayed for the product
    Verify whether discover more rails are displayed
    Verify minicart buttons

Check button actions from minicart for guest user
    [Tags]  minicart
    Search for a product from header search  883932208184
    Click search icon from header search
    Close the Get the First Look modal
    Open the Product from PLP product list  1
    Select Size    5
    Sleep  2s
    Capture product primary name from PDP
    Click Add To Cart Button from PDP
    Verify navigation to PDP from mini cart
    Click Add To Cart Button from PDP
    Verify navigation from view bag button
    Click on My Bag
    Verify navigation from continue checkout button
    Click Back to bag button from checkout page
    Click on My Bag
    IF    '${shopLocale}' in ['US','CN']
    Verify navigation from paypal
    END
    Verify quantity selector functionality
    Verify validation messages for item not available in minicart






