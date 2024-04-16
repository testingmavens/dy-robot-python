*** Settings ***
Library           SeleniumLibrary    screenshot_root_directory=EMBED
Resource          ../Resources/Locators.robot
Resource          ../Keywords/CommonWeb.robot
Resource          ../Keywords/Checkout.robot

*** Keywords ***
Open Store Locator page
    Go to   ${URL}stores?showMap=true&horizontalView=true&isForm=true&boutiques=true&retailers=true
    Close the Get the First Look modal
    Wait Until Element Is Visible    ${logo_home}    5s    Home Logo is not visible
 
Fill and Search a Store from Store Locator page
    [Arguments]    ${zip_code}=90022    ${click_search_button}=True
    Scroll To Element                   ${store_form}
    Mouse Over                          ${logo_home}
    CommonWeb.Check and Input text      ${store_location}       ${zip_code}
    Scroll Element Into View    ${store_search_button}
    Run Keyword If    ${click_search_button}    Click Element           ${store_search_button}
    
Check If Boutique filter is working
    CommonWeb.Scroll And Click by JS             ${checkbox_retailer}
    Check Store Locator fields
    Run Keyword And Expect Error    *   Check Authorized fields

Check If Authorized filter is working
    CommonWeb.Scroll And Click by JS             ${checkbox_boutique}
    CommonWeb.Scroll And Click by JS             ${checkbox_retailer}
    Check Authorized Fields
    Run Keyword And Expect Error    *   Check Store Locator fields

Check Distance filter
    Check Quantity of stores  0  2
    Check Quantity of stores  1  3
    Check Quantity of stores  3  4
    Check Quantity of stores  4  7

Check Services
    Wait Until Page Contains Element    ${service_ul}    timeout=5s
    CommonWeb.Scroll To Element     ${service_ul}
    ${li_elements}      Get List Items From UL  ${service_ul}
    ${actual_services}      Convert WebElements to Strings    ${li_elements}
    CommonWeb.Compare Lists  ${expected_services}    ${actual_services}

Check Quantity of stores
    [Arguments]    ${index}    ${threshold}
    CommonWeb.Scroll And Click by JS     ${distance_dropdown_button}   
    CommonWeb.Scroll And Click by JS     css:.selectric-items [data-index="${index}"]
    Sleep    2
    Wait Until Element Is Visible     ${store_img}    timeout=5s        error=Preview Image did not appeared
    ${count}                        Get Element Count               css:.store-name
    ${count}                        Convert To String               ${count}
    Should Be True                  ${count} >= ${threshold}


Check Authorized Fields
    Wait Until Page Contains Element    ${authorized_address}    timeout=5s        error=Preview Image did not appeared
    ${actual_address}                   Get Text    ${authorized_address}
    Check Authorized Details                 ${actual_address}

Check Authorized Details
    [Arguments]    ${actual_address}
    CommonWeb.Should Contain Text                  ${actual_address}           ${authorized_expected_phone_number}
    CommonWeb.Should Contain Text                  ${actual_address}           ${authorized_expected_address}
    CommonWeb.Should Contain Text                  ${actual_address}           ${authorized_expected_city_state}

Check Store Locator fields
    Wait Until Page Contains Element    ${store_img}    timeout=5s        error=Preview Image did not appeared
    ${actual_address}                   Get Text    ${store_address}
    Check Store Details                 ${actual_address}
    CommonWeb.Scroll To Element         ${view_store_button}
    Wait Until Element Is Visible       ${store_img_src}    timeout=5s
    Element Should Be Visible           ${store_img_src}


Check Store Details
    [Arguments]                                    ${actual_address} 
    CommonWeb.Should Contain Text                  ${actual_address}           ${store_expected_phone_number}
    CommonWeb.Should Contain Text                  ${actual_address}           ${store_expected_address}
#   CommonWeb.Should Contain Text                  ${actual_address}           ${store_expected_city_state}

Click View Store
    CommonWeb.Scroll And Click by JS        ${view_store_button}
    Wait Until Page Contains Element        ${view_store_name}    timeout=5s
    CommonWeb.Scroll To Element             ${view_store_name}

Check View Store Name
    ${store_name}    Get Text       ${view_store_name}
    Should Be Equal As Strings      ${store_name}    ${expected_store_name}

Check View Store Details
    ${actual_address}                   Get Text    ${view_store_address}
    Check Store Details                 ${actual_address}
    Check Store hours                   ${view_store_hours}

Check Store hours
    [Arguments]    ${locator}
    ${table_elements}       Get Table Lines         ${locator}
    ${actual_hours}         Convert WebElements to Strings    ${table_elements}
    Check If the hours are displayed as expected    ${actual_hours}    ${expected_hours}


Check If the hours are displayed as expected
    [Arguments]    ${actual_hours}    ${expected_hours}
    Check Substrings in List of String      ${actual_hours}    ${expected_hours}



Check Map pin details
    Wait Until Page Contains Element    ${map_pin_position}    timeout=5s
    CommonWeb.Click by JS               ${map_pin_position}
    Wait Until Page Contains Element    ${map_pin_dialog}    timeout=5s
    CommonWeb.Scroll To Element         ${map_pin_dialog}
    ${actual_address}                   Get Text    ${store_address}
    Check Store Details                 ${actual_address}

Check Get Directions
    Wait Until Page Contains Element    ${get_direction_button}    5s    Get Directions button is not loaded
    CommonWeb.Click by JS               ${get_direction_button}
    Switch Window	NEW
    ${actual_url}                       Get Location
    CommonWeb.Should Contain Text       ${actual_url}           ${store_directions}

