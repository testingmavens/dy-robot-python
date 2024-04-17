*** Settings ***
Library           SeleniumLibrary    screenshot_root_directory=EMBED
Library           Collections
Library           OperatingSystem
Library           XML
Library           DateTime
Library           String
Library           OperatingSystem
Library           JSONLibrary

Resource          ../Resources/Variables.robot
Resource          ../Keywords/Checkout.robot
Resource          ../Keywords/LamdaTestSetup.robot

*** Keywords ***
Open website
    Set Test Variable    ${run_on_LT}    ${run_on_LT}
    Set Test Variable    ${product}      DY
    Set Test Variable    ${device}       ${device}
    Set Test Variable    ${product_added}    0
    Set Test Variable    ${available}    Not define
    Set Test Variable    ${shopLocale}   ${shopLocale}
    Set Library Search Order    SeleniumLibrary
    Set Test Variable    ${URL}    ${UAT_URL}
    Run Keyword If    '${run_on_LT}' == 'yes'   Open Lamda Test browser
    Run Keyword If    '${run_on_LT}' == 'no'    Open Browser    ${URL}    ${device}    options=add_argument("--ignore-certificate-errors")
   #Locale setting
    Accept Cookies
    Maximize Browser Window
    Set location from ui

Accept Cookies
    Run Keyword And Warn On Failure    Wait until page contains element    ${cookies_accept}    timeout=20s
    Run Keyword And Warn On Failure    Wait until element is visible    ${cookies_accept}    timeout=20s

    Run Keyword If    not ${cookies_closed}    Run Keyword    No Operation
        ${cookies_true}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${cookies_accept}    timeout=3s
        Run Keyword If    ${cookies_true}     CommonWeb.Check and Click          ${cookies_accept}
        #Run Keyword If    ${cookies_true}     execute javascript    document.getElementsByClassName('privacy_prompt')[0].style.display='none';utag.gdpr.consent_prompt
        Set Global Variable    ${cookies_closed}    ${True}

Scroll To Element
    [Arguments]    ${locator}
    ${x}=    Get Horizontal Position    ${locator}
    ${y}=    Get Vertical Position    ${locator}
    Execute Javascript    window.scrollTo(${x}, ${y})

Scroll And Click
    [Arguments]    ${locator}
    Scroll To Element    ${locator}
    Check and click    ${locator}

Generate Timestamp Email
    ${date}=    Get Current Date    result_format=timestamp
    ${time_stamp}=    Evaluate    '${date}'.replace(' ','').replace('-','').replace('.','').replace(':','')
    Set Test Variable    ${guest_valid}    testing_osf${time_stamp}_uat@mailsac.com

Scroll To Top
    Execute Javascript    window.scrollTo(0, 0)

Scroll To Bottom
    Execute Javascript    document.documentElement.scrollTop = document.documentElement.scrollHeight;

Scroll And Click by JS
    [Arguments]    ${locator}
    Scroll To Element    ${locator}
    ${element}    Get WebElement    ${locator}
    Execute Javascript    arguments[0].click();    ARGUMENTS    ${element}

Click by JS
    [Arguments]    ${locator}
    ${element}    Get WebElement    ${locator}
    Execute Javascript    arguments[0].click();    ARGUMENTS    ${element}

Check and Input text
    [Arguments]    ${locator}    ${text}    ${field}=Not define
    Wait Until Page Contains Element    ${locator}    timeout=10    error=*Text field '${field}' is not displayed or unknow in DOM | *Locator :* ${locator}
    Wait Until Element Is Visible    ${locator}    timeout=10    error=Text field '${field}' is not visible | *Locator :* ${locator}
    Input Text    ${locator}    ${text}
    Set Test Variable    ${text}    ${text}

Check and Get text
    [Arguments]    ${locator}    ${field}=Not defined
    Wait Until Page Contains Element    ${locator}    timeout=5s    error=Element '${field}' is not displayed or unknow in DOM | *Locator :* ${locator}
    Wait Until Element Is Visible    ${locator}    timeout=5s    error=Element '${field}' is not visible | *Locator :* ${locator}
    Set Test Variable    ${var}    Not defined
    ${var}=    Get Text    ${locator}
    [Teardown]
    RETURN    ${var}

Check and Click
    [Arguments]    ${locator}    ${field}=Not defined
    Wait Until Page Contains Element    ${locator}    timeout=5s    error=Element '${field}' is not displayed or unknow in DOM | *Locator :* ${locator}
    Wait Until Element Is Visible    ${locator}    timeout=20s    error=Element '${field}' is not visible | *Locator :* ${locator}
    Click Element    ${locator}

Click Using Javascript
    [Arguments]    ${locator}
    Execute Javascript    document.querySelector('${locator}').click()

Close the Get the First Look modal
   Sleep  10s
    IF    "${GTFL_already_closed}" == "false"
        ${GTFL_true}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${gtfl}    timeout=20s
        Run Keyword If    ${GTFL_true}     CommonWeb.Check and Click          ${gtfl_close}
        Set Test Variable    ${GTFL_already_closed}    true
    END
    Sleep  2s


Should Be Greater Than
    [Arguments]    ${value}    ${threshold}
    Run Keyword If    ${value} <= ${threshold}    Fail    Value ${value} is not greater than ${threshold}

Get List Items From UL
    [Arguments]    ${ul_locator}
    ${li_elements}    Get WebElements    xpath://*[@id="269010"]//ul//li
    RETURN    ${li_elements}

Compare Lists
    [Arguments]    ${expected_list}    ${actual_list}
    FOR    ${expected_item}    IN    @{expected_list}
        Run Keyword If    '${expected_item}' not in ${actual_list}    Log    "Element '${expected_item}' not found in actual list"    WARN
    END

Convert WebElements to Strings
    [Arguments]    ${web_elements}
    ${string_list}    Create List
    FOR    ${element}    IN    @{web_elements}
        ${text}    Get Text    ${element}
        Append To List    ${string_list}    ${text}
    END
    RETURN    ${string_list}

Get Table Lines
    [Arguments]    ${table_locator}
    ${tbody_locator}    Set Variable    ${table_locator}//tbody
    ${line_locator}     Set Variable    ${tbody_locator}//tr
    ${lines}    Get WebElements    ${line_locator}
    RETURN    ${lines}

Check Substrings in List of String
    [Arguments]    ${list_of_strings}    ${list_of_substrings}
    ${concatenated_string}      Catenate        ${list_of_strings}
    ${result}                   Set Variable                     ${True}
    FOR    ${substring}    IN    @{list_of_substrings}
        ${contains_substring}    Run Keyword And Return Status    Should Contain    ${concatenated_string}    ${substring}
        Run Keyword If    not ${contains_substring}     Set Variable        ${result}       ${False}
    END
    Run Keyword And Warn On Failure      Should Be True    ${result}


Should Contain Text
    [Arguments]     ${actual_text}    ${expected_text}
    Run Keyword And Warn On Failure    Should Contain    ${actual_text}    ${expected_text}

Set location from ui
   IF  '${shopLocale}' in ['US']
    Location Should Contain    uat.davidyurman.com
   ELSE IF  '${shopLocale}' in ['UK']
    Scroll Element Into View    xpath://a[text()='Choose Another Country ']
    Sleep  3s
    Scroll And Click by JS      xpath://a[text()='Choose Another Country ']
    Wait Until Page Contains Element    xpath://select[@id='gle_selectedCountry']
    Select From List By Label  xpath://select[@id='gle_selectedCountry']   United Kingdom
    Click by JS     xpath://input[@data-key='SavenClose']
    Wait Until Page Contains Element    xpath://input[@value='Continue to shop']    timeout=20s
    Click by JS     xpath://input[@value='Continue to shop']
    Wait Until Location Contains    uat.davidyurman.com/en-de/home
   ELSE IF  '${shopLocale}' in ['CN']
    Scroll Element Into View    xpath://a[text()='Choose Another Country ']
    Sleep  3s
    Scroll And Click by JS      xpath://a[text()='Choose Another Country ']
    Wait Until Page Contains Element    xpath://select[@id='gle_selectedCountry']
    Select From List By Label  xpath://select[@id='gle_selectedCountry']   Canada
    Click by JS     xpath://input[@data-key='SavenClose']
    Wait Until Page Contains Element    xpath://input[@value='Continue to shop']    timeout=20s
    Click by JS     xpath://input[@value='Continue to shop']
    Wait Until Location Contains    uat.davidyurman.com/en-de/home
   ELSE IF  '${shopLocale}' in ['FR']
    Scroll Element Into View    xpath://a[text()='Choose Another Country ']
    Sleep  3s
    Scroll And Click by JS      xpath://a[text()='Choose Another Country ']
    Wait Until Page Contains Element    xpath://select[@id='gle_selectedCountry']
    Select From List By Label  xpath://select[@id='gle_selectedCountry']   France
    Click by JS     xpath://input[@data-key='SavenClose']
    Wait Until Page Contains Element    xpath://input[@value='Continue to shop']    timeout=20s
    Click by JS     xpath://input[@value='Continue to shop']
    Wait Until Location Contains    uat.davidyurman.com/en-de/home
   ELSE IF  '${shopLocale}' in ['GR']
    Scroll Element Into View    xpath://a[text()='Choose Another Country ']
    Sleep  3s
    Scroll And Click by JS      xpath://a[text()='Choose Another Country ']
    Sleep  3s
    Select From List By Label  xpath://select[@id='gle_selectedCountry']   Germany
    Click by JS     xpath://input[@data-key='SavenClose']
    Wait Until Page Contains Element    xpath://input[@value='Continue to shop']    timeout=30s
    Click by JS     xpath://input[@value='Continue to shop']
#    Wait Until Location Contains    uat.davidyurman.com/en-de/home
   ELSE IF  '${shopLocale}' in ['IT']
    Scroll Element Into View    xpath://a[text()='Choose Another Country ']
    Sleep  3s
    Scroll And Click by JS      xpath://a[text()='Choose Another Country ']
    Sleep  3s
    Select From List By Label  xpath://select[@id='gle_selectedCountry']   Italy
    Click by JS     xpath://input[@data-key='SavenClose']
    Wait Until Page Contains Element    xpath://input[@value='Continue to shop']    timeout=30s
    Click by JS     xpath://input[@value='Continue to shop']
#    Wait Until Location Contains    uat.davidyurman.com/en-de/home
   END


Enter text in Billing address
    [Arguments]     ${add}
    Scroll To Element   ${billing_address_one}
    CommonWeb.Check and Input text          ${billing_address_one}       ${add}

Fill in the remaining Billing details
    [Arguments]     ${mail}    ${fn}    ${ln}    ${phone}
    ${shippingMail}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${billing_email}    timeout=3s
    Execute Javascript    window.scrollTo(0,document.body.scrollHeight/2)
    Run Keyword If    ${shippingMail}       Scroll To Element   ${billing_email}
    Run Keyword If    ${shippingMail}       CommonWeb.Check and Input text          ${billing_email}    ${mail}
    Scroll To Element   ${billing_fn}
    CommonWeb.Check and Input text          ${billing_fn}    ${fn}
    Scroll To Element   ${billing_ln}
    CommonWeb.Check and Input text          ${billing_ln}    ${ln}
    Scroll To Element   ${billing_phone}
    CommonWeb.Check and Input text          ${billing_phone}    ${phone}


Press Enter Key
     Press Keys    \\13

Get text from form
    [Arguments]     ${locator}
    ${text}=  Get Element Attribute    ${locator}   value
    RETURN    ${text}

Scroll Page
    [Arguments]    ${x_offset}    ${y_offset}
    Execute JavaScript    window.scrollBy(${x_offset}, ${y_offset})

Check Subtitles Text and Visibility
    [Arguments]    ${accordion_locator}    ${expected_titles}
    ${li_elements}              Get WebElements                     ${accordion_locator}
    ${actual_subtitles}         Convert WebElements to Strings      ${li_elements}
    CommonWeb.Check Substrings in List of String       ${actual_subtitles}        ${expected_titles}

Check Text Visibility in Accordion
    [Arguments]    ${locator}    ${text_locator}
    ${title_buttons}          Get WebElements                     ${locator}
    FOR    ${button}    IN    @{title_buttons}
        Click Element  ${button}
        Wait Until Element Is Visible    ${text_locator}
        Element Should Be Visible    ${text_locator}
        Click Element  ${button}
    END

Click on Footer Link
    [Arguments]    ${title}
    Scroll Element Into View    xpath://a[contains(text(), '${title}')]
    Click Element       xpath://a[contains(text(), '${title}')]

Get text and Compare
    [Arguments]   ${locator}   ${expected_text}
    ${text}=    Check and Get text     ${locator}
    Should Be Equal     ${text}    ${expected_text}

Remove currency and comma from price
    [Arguments]  ${price}
    ${clean_price}     Remove String    ${price}           C$
    ${clean_price}     Remove String    ${clean_price}     $
    ${clean_price}     Remove String    ${clean_price}     €
    ${clean_price}     Remove String    ${clean_price}     £
    ${clean_price}     Remove String    ${clean_price}     ,
  RETURN  ${clean_price}
  
  
Close dev tools icon
   Select Frame    xpath://iframe[@title='Customer Service Chat']
   Select Frame    xpath://iframe[@id='DW-SFToolkit']
   Click by JS    xpath://div[@class='x-panel-body x-panel-body-noheader' and @id='ext-gen16']
   Unselect Frame
   Unselect Frame


