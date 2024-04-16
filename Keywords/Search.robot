*** Settings ***
Library           SeleniumLibrary    screenshot_root_directory=EMBED
Library    BuiltIn
Resource          ../Resources/Locators.robot
Resource          ../Keywords/CommonWeb.robot
Resource          ../Keywords/Checkout.robot
Resource    PDP.robot
*** Variables ***
@{price_array}
*** Keywords ***
Search for a product from header search
   [Arguments]  ${search_query}
   Click Element  xpath://div[@class='d-none d-lg-inline-block']
   #Wait Until Element Is Visible    xpath://span[text()='Popular Products']  100s  error=Popular products not displayed
   Check and Input text    xpath://input[@id='header-search-field']    ${search_query}
   Sleep  3s

Check did you mean suggestion for
    [Arguments]  ${search_query}
    Wait Until Element Is Visible    xpath://span[@class='suggestions-phrases bold underline']   20s  error=did you mean suggestion not shown
    ${did_you_mean_phrase} =  Check and Get text    xpath://span[@class='suggestions-phrases bold underline']
    Should Contain  ${did_you_mean_phrase.lower()}    ${search_query.lower()}

Check did you mean suggestion is not displayed
    Wait Until Element Is Not Visible    xpath://span[@class='suggestions-phrases bold underline']  10s  error=did you mean suggestion is displayed

Click did you mean suggestion
   Click Element    xpath://span[@class='suggestions-phrases bold underline']

Capture did you mean suggestion
   ${phrase}=   Check and Get text    xpath://span[@class='suggestions-phrases bold underline']
   ${did_you_mean_phrase}=  Set Variable  ${phrase}
   ${actual_did_you_mean_phrase_2}=  Replace String Using Regexp    ${did_you_mean_phrase}    “      ${SPACE}
   ${actual_did_you_mean_phrase_1}=  Replace String Using Regexp    ${actual_did_you_mean_phrase_2}    ”      ${SPACE}
   ${actual_did_you_mean_phrase_0}=    Evaluate    "${actual_did_you_mean_phrase_1}".strip()
   Set Test Variable  ${actual_did_you_mean_phrase}   ${actual_did_you_mean_phrase_0}

Check search instead option for
    [Arguments]  ${search_query}
    ${search instead option}    Get Web Elements    xpath://span[@class='suggestions-phrases suggestions-phrases-item']//a/span
    FOR    ${element}    IN    @{search instead option}
        Should Contain  ${element.text.lower()}    ${search_query.lower()}
    END

Check search instead option is not displayed
   Wait Until Element Is Not Visible    xpath://span[@class='suggestions-phrases suggestions-phrases-item']//a/span  10s  error=search instead suggestion is displayed


Check top results displayed for search
   [Arguments]  ${search_query}
   @{words}=    Split String    ${search_query}    ${SPACE}
   ${words_length} =  Get Length    ${words}
   ${top_results}    Get Web Elements    xpath://span[text()='Top results']//ancestor::div[contains(@class,'product-view-all-wrapper')]//following-sibling::div/span//div[@class='product-info']//span[contains(@class,'srp-product-name--title')]
   ${top_results_description}    Get Web Elements    xpath://span[@class='srp-product-name--subtitle']
   FOR    ${index}    IN RANGE    0    ${words_length}
    FOR    ${element}    IN    @{top_results}
     FOR    ${element_tp}    IN    @{top_results_description}
        Should Contain Text  ${element.text.lower()} ${element_tp.text.lower()}   ${words[${index}].lower()}
    END
   END
  END


Click View all products
  Wait Until Page Contains Element    xpath://span[text()='View all products']
  Click Element    xpath://span[text()='View all products']
  Sleep  10s
  Close the Get the First Look modal

Check all products in PLP search results contain
   [Arguments]  ${search_query}
   @{words}=    Split String    ${search_query}    ${SPACE}
   ${words_length} =  Get Length    ${words}
   ${pdp_product_name}=   Get Web Elements    xpath://div[@class='pdp-link']/a
   FOR    ${index}    IN RANGE    0    ${words_length}
    FOR    ${element}    IN    @{pdp_product_name}
        Should Contain Text  ${element.text.lower()}    ${words[${index}].lower()}
    END
   END

Click on did you mean option
  Click Element    xpath://span[@class='suggestions-phrases bold underline']

Click on search instead option
      [Arguments]  ${search_instead_option}
      Click Element    xpath:(//span[@class='suggestions-phrases suggestions-phrases-item']//a/span)[${search_instead_option}]

Check no results message
   [Arguments]  ${search_query}
   Wait Until Element Is Visible    xpath:(//div[@class='no-search-results'])[1]   5s  error=No results message not displayed
   ${actual_message} =  Get Text    xpath:(//div[@class='no-search-results'])[1]
   Should Be Equal As Strings    ${actual_message}    Sorry, we couldn’t find any results for "${search_query}".
   ${actual_secondary_message} =  Get Text    xpath:(//div[@class='no-search-results'])[2]
   Should Be Equal As Strings    ${actual_secondary_message}    Try a new search using a different spelling or keywords.

Click search icon from header search
  Click Element    xpath:(//button[@name='search-button'])[1]

Click search box
  Click Element  xpath://div[@class='d-none d-lg-inline-block']

Verify no results found page
    Element Should Contain     xpath://div[@class='no-results-header']    No results found
    Element Should Be Visible    xpath://input[@placeholder='Try a new search']

Search item from no results page
    [Arguments]   ${search_query}
    Scroll Element Into View    xpath://input[@placeholder='Try a new search']
    Click Element    xpath://input[@placeholder='Try a new search']
    CommonWeb.Check and Input text    xpath://input[@placeholder='Try a new search']    ${search_query}
    Click Element    xpath:(//button[@name='search-button'])[2]

Sort item by
   [Arguments]  ${sort}
    Mouse Over   xpath://div[@class='nice-select custom-select text-entered']
    Scroll Element Into View    xpath://ul/li[contains(text(),'${sort}')]
    Click Element    xpath://ul/li[contains(text(),'${sort}')]

Check Products are sorted by Price low to high
   ${elements}   Get Web Elements  xpath://div[@class='pdp-link']//following-sibling::div/span/span/span[1]
   ${num_elements}    Get Length    ${elements}
   FOR    ${index}    IN RANGE    ${num_elements}
     ${element_text}    Get Text    ${elements}[${index}]
     ${clean_price}     Remove currency and comma from price    ${element_text}
     Append To List    ${price_array}    ${clean_price}
   END
   ${is_ascending}  Check If List Is Ascending Order  ${price_array}
   Should be True   ${is_ascending}

Check If List Is Ascending Order
    [Arguments]    ${list}
    ${previous_value}=    Set Variable    ${EMPTY}
    FOR    ${item}    IN    @{list}
       Run Keyword If    '${previous_value}' == ''    Set Variable    ${item}
       ...    ELSE IF    ${item} < ${previous_value}
       ...    Return From Keyword    False
    Set Variable    ${item}
    Return From Keyword    True
    END

Check Products are sorted by Price high to low
   ${elements}   Get Web Elements  xpath://div[@class='pdp-link']//following-sibling::div/span/span/span[1]
   ${num_elements}    Get Length    ${elements}
   FOR    ${index}    IN RANGE    ${num_elements}
     Sleep  1s
     ${element_text}    Get Text    ${elements}[${index}]
     ${clean_price}     Remove currency and comma from price    ${element_text}
     Append To List    ${price_array}    ${clean_price}
   END
   Check If List Is Descending Order  ${price_array}

Check If List Is Descending Order
  [Arguments]  ${array}
   FOR    ${i}    IN RANGE    1    ${array.__len__()}
      ${prev_value}=    Evaluate    ${array[${i}-1]}
      ${current_value}=    Evaluate    ${array[${i}]}
      Should Be True    ${prev_value} > ${current_value}
    END

Check customer care link
    Click Element    xpath://a[text()='Customer Care']
    ${current_location}=    Get Location
    Should Contain    ${current_location}    customer-care.html
    Close Window

#Search for a product
#   [Arguments]  ${search_value}
#   Set Test Variable    ${search}  ${search_value}
#   Click Element  xpath://div[@class='d-none d-lg-inline-block']
#   Wait Until Element Is Visible    xpath://span[text()='Popular Products']
#   Check and Input text    xpath://input[@id='header-search-field']    ${search_query}

Check did you mean suggestion
    ${did_you_mean_phrase} =  Check and Get text    xpath://span[@class='suggestions-phrases bold underline']
    Should Contain Text  ${did_you_mean_phrase}    ${search}

Filter item by price range
    [Arguments]  ${price_range}= 0-749.99
    ${price_filters}=    Create Dictionary    0-749.99=1    750-1499.99=2    1500-2999.99=3   3000-4999.99=4   Above 5000=5
    Mouse Over    xpath://h2[@aria-label='Price']
    ${value}=    Get From Dictionary    ${price_filters}    ${price_range}
    Sleep  2s
    Click Element    xpath:(//h2[@aria-label='Price']//parent::div//following-sibling::div//span[@class='selected-assistive-text refinement-text'])[${value}]
    Scroll Page    0    40
    Sleep  2s
    Click by JS   xpath:(//button[text()='Apply'])[2]

Check if products are filtered with price range
    [Arguments]  ${price_range}= 0-749.99
    ${price_filters}=    Create Dictionary    0-749.99=749.99    750-1499.99=1499.99    1500-2999.99=2999.99   3000-4999.99=4999.99  Above 5000=5000
    ${elements}   Get Web Elements  xpath://div[@class='pdp-link']//following-sibling::div/span/span/span[1]
    ${num_elements}    Get Length    ${elements}
    ${value}=    Get From Dictionary    ${price_filters}    ${price_range}
   IF  '${value}' in ['749.99', '1499.99', '2999.99', '4999.99']
    FOR    ${index}    IN RANGE     1   ${num_elements}
     Scroll Element Into View    ${elements}[${index}]
     ${element_text}    Get Text    ${elements}[${index}]
     ${clean_price} =   Remove currency and comma from price    ${element_text}
     Should Be True    ${clean_price} < ${value}
    END
  ELSE
   FOR    ${index}    IN RANGE    ${num_elements}
     ${element_text}    Get Text    ${elements}[${index}]
     ${clean_price} =   Remove currency and comma from price    ${element_text}
     Should Be True    ${clean_price} > 5000
   END
  END


Check Products all products contains best seller tags
    ${elements}   Get Web Elements  xpath://div[@class='tile-body']//p[contains(@class,'product-badge-text')]
    ${num_elements}    Get Length    ${elements}
    FOR    ${index}    IN RANGE     1   ${num_elements}
     Scroll Element Into View    ${elements}[${index}]
     Run Keyword And Warn On Failure   Element Should Contain    ${elements}[${index}]    Best Seller
    END

Check all products in PLP has striked through rates
   ${price_of_products}=   Get Web Elements    xpath://div[@class='pdp-link']/a
   FOR    ${index}    IN RANGE    1    ${price_of_products}
    FOR    ${element}    IN    @{price_of_products}
        ${attribute}    Get Element Attribute   ${element}    aria-label
        Should Contain Text    strike    ${attribute}
    END
   END

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