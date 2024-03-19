*** Settings ***
Test Setup        Run Keywords    Open website
Test Teardown     Run Keywords    Close All Browsers
Force Tags        prod    automation
Library           SeleniumLibrary    screenshot_root_directory=EMBED
Resource          ../Resources/Locators.robot
Resource          ../Resources/Variables.robot
Resource          ../Resources/Errors.robot
Resource          ../Keywords/CommonWeb.robot
Resource          ../Keywords/Login.robot
Resource          ../Keywords/Homepage.robot
Resource          ../Keywords/Checkout.robot
Resource          ../Keywords/PDP.robot
Resource          ../Keywords/Cart.robot
Resource          ../Keywords/Shipping.robot
Resource          ../Keywords/Wishlist.robot
Resource          ../Keywords/Login.robot
Resource          ../Keywords/Search.robot
Resource          ../Keywords/PLP.robot
*** Test Cases ***
PRD_SMK_Wishlist - 01 - Add to bag and Remove from wishlist
    [Tags]   Generic   Wishlist  RUNME
    Check if Login is accessible from header
    Fill in Login Form  ${REGISTERED_email}   ${REGISTERED_pwd}
    Click on Login
    Search for a product from header search  B13779 SS
    Click search icon from header search
    Sleep  1s
    Close the Get the First Look modal
    Open the Product from PLP product list  1
    Get product primary name from PDP
    Select Size    M
    Click add to wishlist button
    Click go to wishlist
#   Sleep  1s
    Check whether added item is displayed in wishlist
#    Sleep  3s
    Click Move to bag button from wishlist
    Click on Add to Bag from quickview modal
    Click on View Bag from minicart
    Check whether product is added to cart
    Click go to wishlist
    Click Remove from wishlist button
    Sleep  2s
    Check whether wishlist is empty


