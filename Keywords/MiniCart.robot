*** Settings ***
Library           SeleniumLibrary    screenshot_root_directory=EMBED
Resource          ../Resources/Locators.robot
Resource          ../Resources/Variables.robot
Resource          ../Keywords/CommonWeb.robot
Resource          ../Keywords/DataReader.robot
*** Variables ***
${condition}    True
*** Keywords ***
Verify whether title is displayed in empty guest minicart
   Page Should Contain Element    xpath://h1[@class='empty-minicart-title text-center']
   Element Should Contain    xpath://h1[@class='empty-minicart-title text-center']     Your Bag\

Verify whether title is displayed in guest minicart
   Run Keyword And Warn On Failure    Page Should Contain Element    xpath://h1[@class='minicart-title']
   Run Keyword And Warn On Failure    Element Should Contain    xpath://h1[@class='minicart-title']     Your Bag\

Verify whether remove button is displayed for the product
   Run Keyword And Warn On Failure    Page Should Contain Element    xpath://button[contains(text(),'Remove')]

Verify whether quantity selector is displayed for the product
   Run Keyword And Warn On Failure    Page Should Contain Element    xpath:(//div[@class='dy-custom-qty js-form-qty '])[1]

Verify whether discover more rails are displayed
   Run Keyword And Warn On Failure    Page Should Contain Element    xpath://h3[text()='Discover More']
   Run Keyword And Warn On Failure    Page Should Contain Element    xpath:(//div[@class='ymal-tile-image'])[1]

Verify whether shopping bag empty message is displayed
   Page Should Contain Element    xpath://h2[@class='empty-card-title-text']
   Element Should Contain    xpath://h2[@class='empty-card-title-text']     Your Shopping Bag is Empty.
   Element Should Contain    xpath://h2[@class='empty-card-title-text']//following-sibling::p     Explore and add something you love.

Verify whether women and men toggle is displayed
  Page Should Contain Element    xpath://span[@class='carousel-toggler-button']

Verify whether shop by rails are displayed
   Page Should Contain Element    xpath:(//div[@class='slick-track'])[2]

Verify whether trending now rails are displayed
   Run Keyword And Warn On Failure   Page Should Contain Element    xpath://h3[text()="Trending Now"]
   Run Keyword And Warn On Failure   Page Should Contain Element    xpath:(//div[@class='slick-track'])[4]

Verify by default women is selected
   Page Should Contain Element    xpath://span[@class='carousel-toggler-selection js-tealium-promo carousel-toggler-button-selection-on js-tealium-column is-tracked' and text()='Women']

Verify whether user can toggle to men
   Click Element    xpath://span[@class='carousel-toggler-selection js-tealium-promo js-tealium-column is-tracked' and text()='Men']
   Run Keyword And Warn On Failure   Page Should Contain Element    xpath://span[@class='carousel-toggler-selection js-tealium-promo js-tealium-column is-tracked carousel-toggler-button-selection-on' and text()='Men']

Verify whether the shop by rails changes to men
   Run Keyword And Warn On Failure    Page Should Contain Element   xpath:(//p[@class='category-name'])[4]
   Run Keyword And Warn On Failure    Element Should Contain    xpath:(//p[@class='category-name'])[4]    Shop Rings

Verify whether user can toggle to women
   Click Element    xpath://span[@class='carousel-toggler-selection js-tealium-promo js-tealium-column is-tracked' and text()='Women']
   Run Keyword And Warn On Failure   Page Should Contain Element    xpath://span[@class='carousel-toggler-selection js-tealium-promo js-tealium-column is-tracked carousel-toggler-button-selection-on' and text()='Women']

Verify whether the shop by rails changes to women
   Run Keyword And Warn On Failure    Page Should Contain Element   xpath:(//p[@class='category-name'])[2]
   Run Keyword And Warn On Failure    Element Should Contain    xpath:(//p[@class='category-name'])[2]    Shop Necklace
   
Verify navigation from shop braclets for women
   Click Element    xpath:(//p[@class='category-name'])[1]
   Close the Get the First Look modal
   Run Keyword And Warn On Failure  Page Should Contain Element    xpath://div[@class='pd-text d-none d-lg-block ']
   Run Keyword And Warn On Failure  Element Should Contain    xpath://h1[@class='pd-text d-lg-none ']    Women’s Bracelets

Verify navigation from shop braclets for men
   Click Element    xpath:(//p[@class='category-name'])[2]
   Sleep  10s
   Run Keyword And Warn On Failure    Page Should Contain Element    xpath://div[@class='pd-text d-none d-lg-block ']
   Run Keyword And Warn On Failure    Element Should Contain    xpath://h1[@class='pd-text d-lg-none ']    Men’s Bracelets
   
Verify whether user navigates to correct PLP page from trending now
    Wait Until Page Contains Element    xpath:(//p[@class='ymal-product_name'])[1]
    ${product_name} =  Get Text    xpath:(//p[@class='ymal-product_name'])[1]
    Click Element    xpath:(//p[@class='ymal-product_name'])[1]
    Scroll Element Into View    xpath://span[@class='product-name--title js-primary-title']
    ${PDP_product_primary_name}    Get Text    xpath://span[@class='product-name--title js-primary-title']
    Run Keyword And Warn On Failure     Should Be Equal As Strings    ${PDP_product_primary_name}    ${product_name}

Verify whether item count is displayed in minicart
    [Arguments]  ${count}
    Wait Until Page Contains Element    xpath://span[@class='js-minicart-title-qty minicart-title-qty']
    Run Keyword And Warn On Failure    Element Should Contain   xpath://span[@class='js-minicart-title-qty minicart-title-qty']   ${count}

Verify whether delivery type for item is displayed in minicart
    [Arguments]  ${deliveryType}
    IF  '${deliveryType}' in ['Pick up']
    Run Keyword And Warn On Failure    Element Should Contain   xpath://h2[@class='cart-items-group-title']   ${deliveryType} ${pickup_store}
    ELSE
    Wait Until Page Contains Element    xpath://h2[@class='cart-items-group-title' and text()='${deliveryType}']
    Run Keyword And Warn On Failure    Element Should Contain   xpath://h2[@class='cart-items-group-title']   ${deliveryType}
    END

Get store location shown with product
   Wait Until Page Contains Element    xpath://span[@class='pickup-in-store-btn-modal text-underline']
   ${pickup_store}   Get Text    xpath://span[@class='pickup-in-store-btn-modal text-underline']
   ${pickup_store}   Set Test Variable    ${pickup_store}

Verify minicart buttons
    Run Keyword And Warn On Failure   Page Should Contain Element     xpath://a[@title='View Bag']
    Run Keyword And Warn On Failure   Page Should Contain Element     xpath://a[@data-event-value='continue_checkout']
    IF  '${shopLocale}' in ['US','CN']
      Run Keyword And Warn On Failure   Wait Until Page Contains Element     xpath://div[@class='paypal-button-label-container']   timeout=20s
    END

Verify minicart buttons for preorder
    Run Keyword And Warn On Failure   Page Should Contain Element     xpath://a[@title='View Bag']
    Run Keyword And Warn On Failure   Page Should Contain Element     xpath://a[@data-event-value='continue_checkout']
    Run Keyword And Warn On Failure   Page Should Not Contain Element   xpath://div[@class='paypal-button-label-container']   timeout=20s

Verify navigation to PDP from mini cart 
     Click Element   xpath://div[@class='line-item-header line-item-primary-title']/a
     Run Keyword And Warn On Failure    Page Should Contain Element    xpath://span[@class='product-name--title js-primary-title']

Verify navigation from view bag button
     Click Element   xpath://a[@title='View Bag']
     Run Keyword And Warn On Failure    Page Should Contain Element    xpath://h1[@class='page-title']
     Run Keyword And Warn On Failure    Element Should Contain    xpath://h1[@class='page-title']    Your Bag

Verify navigation from continue checkout button
     Click Element   xpath://a[@data-event-value='continue_checkout']
     Run Keyword And Warn On Failure    Page Should Contain Element    xpath://h1[@class='checkout-page-title global-page-title freight-big-pro-font mb-0']

Verify navigation from paypal
     Select Frame  xpath:(//iframe[@title='PayPal'])[1]
     Click Element   xpath://div[@class='paypal-button-label-container']
     @{winHandles}=    Get Window Handles
     @{winTitles}=    Get Window Titles
     Switch Window    ${winHandles}[1]
     Wait Until Page Contains Element    ${paypal_email_l}     100s    Email field is not loaded
     Close Window

Verify quantity selector functionality
   FOR    ${index}    IN RANGE    10
   Run Keyword If  '${condition}' != True  Click Element    xpath:(//button[@aria-label='Add quantity minicart'])[1]
    ${condition}  Run Keyword And Return Status    Page Should Not Contain Element    xpath://span[contains(text(),'The maximum available quantity for this item is')]
   Run Keyword If    '${condition}' != True   Exit For Loop
   END

Verify validation messages for item not available in minicart
   Run Keyword And Warn On Failure    Page Should Contain Element    xpath://span[@class='error-bold-red']
   Run Keyword And Warn On Failure    Element Should Contain    xpath://span[@class='error-bold-red']     We’re sorry! This item is no longer available in the quantity selected.
   Run Keyword And Warn On Failure    Page Should Contain Element    xpath://div[@class='js-unavailable-items-error-message mt-2 unavailable-items-error']
   Run Keyword And Warn On Failure    Element Should Contain    xpath://div[@class='js-unavailable-items-error-message mt-2 unavailable-items-error']      Please remove unavailable items to continue with checkout

