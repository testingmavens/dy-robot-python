*** Settings ***
Test Setup        Run Keywords    Open website
Test Teardown     Run Keywords    Close All Browsers
Force Tags        Regression    automation
Library           SeleniumLibrary    screenshot_root_directory=EMBED
Resource          ../Resources/Locators.robot
Resource          ../Resources/Variables.robot
Resource          ../Resources/Errors.robot
Resource          ../Keywords/Checkout.robot
Resource          ../Keywords/Cart.robot
Resource          ../Keywords/OrderConfirmation.robot
Resource          ../Keywords/Shipping.robot
Resource          ../Keywords/Payment.robot
Resource          ../Keywords/PDP.robot
Resource          ../Keywords/PLP.robot
Resource          ../Keywords/CommonWeb.robot
Resource          ../Keywords/Login.robot
Resource          ../Keywords/Homepage.robot
Resource          ../Keywords/StoreLocator.robot
Resource          ../Keywords/GiftCard.robot
Resource          ../Keywords/MyAccount.robot

*** Test Cases ***
PRD_SMK_StoreLocator - 01 - Search store by Zip code and Map pin details
    [Tags]  DY
    Open Store Locator page
    Fill and Search a Store ZipCode from Store Locator page
    Check Store Locator fields
    Check Map pin details

PRD_SMK_StoreLocator - 02 - Search store by locality and Check distance filters
    [Tags]  DY
    Open Store Locator page
    Fill and Search a Store locality from Store Locator page
    Check Distance filter

PRD_SMK_StoreLocator - 03 - Check store services and details
    [Tags]  DY
    Open Store Locator page
    Fill and Search a Store ZipCode from Store Locator page
    Check Services
    Click View Store
    Check View Store Name
    Check View Store Details

PRD_SMK_StoreLocator - 04 - Check Get directions
    [Tags]  DY
    Open Store Locator page
    Fill and Search a Store locality from Store Locator page
    Check Get Directions

PRD_SMK_StoreLocator - 05 - Check Boutique and Authorized filter
    [Tags]  DY
    Open Store Locator page
    Fill and Search a Store ZipCode from Store Locator page
    Check If Boutique filter is working
    Fill and Search a Store locality from Store Locator page
    Check If Authorized filter is working