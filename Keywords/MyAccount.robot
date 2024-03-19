*** Settings ***
Library           SeleniumLibrary    screenshot_root_directory=EMBED
Resource          ../Resources/Locators.robot
Resource          ../Keywords/CommonWeb.robot
Resource          ../Keywords/NewCustomerRegistration.robot


*** Keywords ***
Check if new address was saved after purchase
    [Arguments]    ${fn}   ${ln}    ${adr}   ${zip}    ${tel}
    Wait Until Element Is Not Visible    ${myA_new_addr_fn_l}    10s
    Wait Until Element Is Visible    ${myA_new_addr_first_row_l}    10s
    Run Keyword And Warn On Failure    Element Should Contain    ${myA_new_addr_first_row_l}    ${fn}
    Run Keyword And Warn On Failure    Element Should Contain    ${myA_new_addr_first_row_l}    ${ln}
    Run Keyword And Warn On Failure    Element Should Contain    ${myA_new_addr_second_row_l}    ${adr}
    Run Keyword And Warn On Failure    Element Should Contain    ${myA_new_addr_third_row_l}    ${zip}
    Run Keyword And Warn On Failure    Element Should Contain    ${myA_new_addr_fourth_row_l}    ${tel}

See if Order History page contains the order from last purchase
    Run Keyword And Warn On Failure    Page Should Contain    ${order}
    Run Keyword And Return Status    Wait Until Element Is Visible    ${myA_order_details_cont_as_l}    10s

Check new credit card was saved after the purchase
    Run Keyword And Warn On Failure    Element Should Be Visible    ${myA_new_card_first_row_l}
    Run Keyword And Warn On Failure    Element Should Be Visible    ${myA_new_card_row_info_l}
    Run Keyword And Warn On Failure    Element Should Be Visible    ${myA_new_card_next_row_l}

Fill in the Register form
    Clear all fields on registration form
     Check and Input text    ${first_name_textField_reg}    ${FIRST_NAME}
     Check and Input text    ${last_name_textField_reg}    ${LAST_NAME}
     Generate Timestamp Email
     Check and Input text    ${email_textField_reg}        ${guest_valid}
     Check and Input text    ${retype_email_textField_reg}  ${guest_valid}
     Check and Input text    ${password_textField_reg}  P@ssword00
     Check and Input text    ${retype_password_textField_reg}  P@ssword00
     Sleep  2s
     NewCustomerRegistration.User clicks register button
     Element Should Be Visible  ${my_account_title}

Check that the user is successfully logged in and redirected to Account Details page
    [Arguments]    ${email}
    Run Keyword And Warn On Failure    Wait Until Page Contains Element    ${my_account_page_l}    10s
    Run Keyword And Warn On Failure    Element Should Contain    ${my_acc_email_elm_l}    ${email}

Click on Add a New Address button
    CommonWeb.Check And Click    ${myA_add_address_cta_l}
    Wait Until Page Contains Element    ${myA_add_show_address_cta_l}    10s
    Wait Until Element Is Visible    ${myA_add_addr_fn_l}    10s

Click on Save button from Add a New Address form
    Click Element    ${myA_add_addr_save_cta_l}

Verify the empty field validation messages for Add a New Address form
    Run Keyword And Warn On Failure    Wait Until Page Contains Element    ${myA_add_addr_fn_err_l}    10s
    Run Keyword And Warn On Failure    Element Text Should Be    ${myA_add_addr_fn_err_l}    ${myA_add_addr_fn_err}
    Run Keyword And Warn On Failure    Wait Until Page Contains Element    ${myA_add_addr_ln_err_l}    10s
    Run Keyword And Warn On Failure    Element Text Should Be    ${myA_add_addr_ln_err_l}    ${myA_add_addr_ln_err}
    Run Keyword And Warn On Failure    Wait Until Page Contains Element    ${myA_add_addr_addr_err_l}    10s
    Run Keyword And Warn On Failure    Element Text Should Be    ${myA_add_addr_addr_err_l}    ${myA_add_addr_addr_err}
    Run Keyword And Warn On Failure    Wait Until Page Contains Element    ${myA_add_addr_city_err_l}    10s
    Run Keyword And Warn On Failure    Element Text Should Be    ${myA_add_addr_city_err_l}    ${myA_add_addr_city_err}
    Run Keyword And Warn On Failure    Wait Until Page Contains Element    ${myA_add_addr_state_err_l}    10s
    Run Keyword And Warn On Failure    Element Text Should Be    ${myA_add_addr_state_err_l}    ${myA_add_addr_state_err}
    Run Keyword And Warn On Failure    Wait Until Page Contains Element    ${myA_add_addr_zip_err_l}    10s
    Run Keyword And Warn On Failure    Element Text Should Be    ${myA_add_addr_zip_err_l}    ${myA_add_addr_zip_err}
    Run Keyword And Warn On Failure    Wait Until Page Contains Element    ${myA_add_addr_tel_err_l}    10s
    Run Keyword And Warn On Failure    Element Text Should Be    ${myA_add_addr_tel_err_l}    ${myA_add_addr_tel_err}

Fill in the Add a New Address form
    [Arguments]    ${fn}   ${ln}    ${adr}    ${city}    ${state}    ${zip}    ${tel}
    ${myaccfname}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${myA_add_addr_fn_l}    3s
    Run Keyword If    ${myaccfname}     Scroll To Element   ${myA_add_addr_fn_l}
    Run Keyword If    ${myaccfname}     CommonWeb.Check and Input text          ${myA_add_addr_fn_l}    ${fn}
    ${myacclname}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${myA_add_addr_ln_l}    3s
    Run Keyword If    ${myacclname}     Scroll To Element   ${myA_add_addr_ln_l}
    Run Keyword If    ${myacclname}     CommonWeb.Check and Input text          ${myA_add_addr_ln_l}    ${ln}
    ${myaccaddr}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${myA_add_addr_addr_l}    3s
    Run Keyword If    ${myaccaddr}     Scroll To Element   ${myA_add_addr_addr_l}
    Run Keyword If    ${myaccaddr}     CommonWeb.Check and Input text          ${myA_add_addr_addr_l}    ${adr}
    ${myacccity}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${myA_add_addr_city_l}    3s
    Run Keyword If    ${myacccity}     Scroll To Element   ${myA_add_addr_city_l}
    Run Keyword If    ${myacccity}     CommonWeb.Check and Input text          ${myA_add_addr_city_l}    ${city}
    ${myaccstate}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${myA_add_addr_state_l}    5s
    Run Keyword If    ${myaccstate}    Click Element    ${myA_add_addr_state_l}
    Run Keyword If    ${myaccstate}    Click Element    xpath://div[@id='addAddress']//div[contains(@class, 'selectric-custom-select')]//li[contains(.,'${state}')]
    ${myacczip}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${myA_add_addr_zip_l}    3s
    Run Keyword If    ${myacczip}     Scroll To Element   ${myA_add_addr_zip_l}
    Run Keyword If    ${myacczip}     CommonWeb.Check and Input text          ${myA_add_addr_zip_l}    ${zip}
    ${myacctel}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${myA_add_addr_tel_l}    3s
    Run Keyword If    ${myacctel}     Scroll To Element   ${myA_add_addr_tel_l}
    Run Keyword If    ${myacctel}     CommonWeb.Check and Input text          ${myA_add_addr_tel_l}    ${tel}

Check if the new address is present in My Account
    [Arguments]    ${fn}   ${ln}    ${adr}    ${city}    ${zip}    ${tel}
    Wait Until Element Is Not Visible    ${myA_new_addr_fn_l}    10s
    Wait Until Element Is Visible    ${myA_new_addr_first_row_l}    10s
    Run Keyword And Warn On Failure    Element Should Contain    ${myA_new_addr_first_row_l}    ${fn}
    Run Keyword And Warn On Failure    Element Should Contain    ${myA_new_addr_first_row_l}    ${ln}
    Run Keyword And Warn On Failure    Element Should Contain    ${myA_new_addr_second_row_l}    ${adr}
    Run Keyword And Warn On Failure    Element Should Contain    ${myA_new_addr_third_row_l}    ${city}
    Run Keyword And Warn On Failure    Element Should Contain    ${myA_new_addr_third_row_l}    ${zip}
    Run Keyword And Warn On Failure    Element Should Contain    ${myA_new_addr_fourth_row_l}    ${tel}

Click on Edit link near first address
    CommonWeb.Scroll And Click by JS    ${myA_first_addr_edit_l}
    Wait Until Page Contains Element    ${myA_add_addr_fn_l}    10s

Fill in the Edit Address form
    [Arguments]    ${fn}   ${ln}    ${adr}    ${city}    ${state}    ${zip}    ${tel}
    ${myaccfname}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${myA_add_addr_fn_l}    3s
    Run Keyword If    ${myaccfname}     Press Keys     ${myA_add_addr_fn_l}     CONTROL+A   DELETE
    Run Keyword If    ${myaccfname}     Scroll To Element   ${myA_add_addr_fn_l}
    Run Keyword If    ${myaccfname}     CommonWeb.Check and Input text          ${myA_add_addr_fn_l}    ${fn}
    ${myacclname}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${myA_add_addr_ln_l}    3s
    Run Keyword If    ${myacclname}     Press Keys     ${myA_add_addr_ln_l}     CONTROL+A   DELETE
    Run Keyword If    ${myacclname}     Scroll To Element   ${myA_add_addr_ln_l}
    Run Keyword If    ${myacclname}     CommonWeb.Check and Input text          ${myA_add_addr_ln_l}    ${ln}
    ${myaccaddr}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${myA_add_addr_addr_l}    3s
    Run Keyword If    ${myaccaddr}     Press Keys     ${myA_add_addr_addr_l}     CONTROL+A   DELETE
    Run Keyword If    ${myaccaddr}     Scroll To Element   ${myA_add_addr_addr_l}
    Run Keyword If    ${myaccaddr}     CommonWeb.Check and Input text          ${myA_add_addr_addr_l}    ${adr}
    ${myacccity}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${myA_add_addr_city_l}    3s
    Run Keyword If    ${myacccity}     Press Keys     ${myA_add_addr_city_l}     CONTROL+A   DELETE
    Run Keyword If    ${myacccity}     Scroll To Element   ${myA_add_addr_city_l}
    Run Keyword If    ${myacccity}     CommonWeb.Check and Input text          ${myA_add_addr_city_l}    ${city}
    ${myaccstate}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${myA_add_addr_state_l}    5s
    Run Keyword If    ${myaccstate}    Click Element    ${myA_add_addr_state_l}
    Run Keyword If    ${myaccstate}    Click Element    xpath://div[@id='addAddress']//div[contains(@class, 'selectric-custom-select')]//li[contains(.,'${state}')]
    ${myacczip}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${myA_add_addr_zip_l}    3s
    Run Keyword If    ${myacczip}     Press Keys     ${myA_add_addr_zip_l}     CONTROL+A   DELETE
    Run Keyword If    ${myacczip}     Scroll To Element   ${myA_add_addr_zip_l}
    Run Keyword If    ${myacczip}     CommonWeb.Check and Input text          ${myA_add_addr_zip_l}    ${zip}
    ${myacctel}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${myA_add_addr_tel_l}    3s
    Run Keyword If    ${myacctel}     Press Keys     ${myA_add_addr_tel_l}     CONTROL+A   DELETE
    Run Keyword If    ${myacctel}     Scroll To Element   ${myA_add_addr_tel_l}
    Run Keyword If    ${myacctel}     CommonWeb.Check and Input text          ${myA_add_addr_tel_l}    ${tel}

Click on Save button from Edit Address form
    Click Element    ${myA_edit_addr_save_l}

Click on Delete link near first address
    CommonWeb.Scroll And Click by JS    ${myA_first_addr_remove_l}
    Wait Until Page Contains Element    ${myA_first_addr_remove_conf_l}    10s
    Wait Until Element Is Visible    ${myA_first_addr_remove_conf_l}    10s

Click Confirm on the Delete Address modal
    Wait Until Element Is Visible    ${myA_first_addr_remove_conf_l}    10s
    Sleep  2s
    Click by JS    ${myA_first_addr_remove_conf_l}
    Wait Until Element Is Not Visible    ${myA_first_addr_remove_conf_l}    20s

Check that My Address section is empty
    Wait Until Page Does Not Contain Element    ${myA_new_addr_first_row_l}    10s
    Run Keyword And Warn On Failure    Element Should Not Be Visible    ${myA_new_addr_fourth_row_l}

Click on Add a New Credit Card button
    CommonWeb.Scroll And Click by JS    ${myA_add_payment_l}
    Wait Until Page Contains Element    ${myA_add_card_name_l}    10s

Click on Save button from Add a New Credit Card form
      Scroll Element Into View    ${myA_add_payment_save_l}
      Click Element  ${myA_add_payment_save_l}

Close the New Credit Card form
    Click Element    ${myA_add_payment_cancel_l}
    Wait Until Element Is Not Visible    ${myA_add_payment_cancel_l}    20s

Verify the empty field validation messages for Add a New Credit Card form
    Run Keyword And Warn On Failure    Wait Until Page Contains Element    ${myA_card_owner_err_l}    10s
    Run Keyword And Warn On Failure    Element Text Should Be    ${myA_card_owner_err_l}    ${myA_card_owner_err}
    Run Keyword And Warn On Failure    Wait Until Page Contains Element    ${myA_card_number_err_l}    10s
    Run Keyword And Warn On Failure    Element Text Should Be    ${myA_card_number_err_l}    ${myA_card_number_err}
    Run Keyword And Warn On Failure    Wait Until Page Contains Element    ${myA_card_csv_err_l}    10s
    Run Keyword And Warn On Failure    Element Text Should Be    ${myA_card_csv_err_l}    ${myA_card_csv_err}
    Run Keyword And Warn On Failure    Wait Until Page Contains Element    ${myA_card_fn_err_l}    10s
    Run Keyword And Warn On Failure    Element Text Should Be    ${myA_card_fn_err_l}    ${myA_card_fn_err}
    Run Keyword And Warn On Failure    Wait Until Page Contains Element    ${myA_card_ln_err_l}    10s
    Run Keyword And Warn On Failure    Element Text Should Be    ${myA_card_ln_err_l}    ${myA_card_ln_err}
    Run Keyword And Warn On Failure    Wait Until Page Contains Element    ${myA_card_addr_err_l}    10s
    Run Keyword And Warn On Failure    Element Text Should Be    ${myA_card_addr_err_l}    ${myA_card_addr_err}
    Run Keyword And Warn On Failure    Wait Until Page Contains Element    ${myA_card_city_err_l}    10s
    Run Keyword And Warn On Failure    Element Text Should Be    ${myA_card_city_err_l}    ${myA_card_city_err}
    Run Keyword And Warn On Failure    Wait Until Page Contains Element    ${myA_card_zip_err_l}    10s
    Run Keyword And Warn On Failure    Element Text Should Be    ${myA_card_zip_err_l}    ${myA_card_zip_err}
    Run Keyword And Warn On Failure    Wait Until Page Contains Element    ${myA_card_tel_err_l}    10s
    Run Keyword And Warn On Failure    Element Text Should Be    ${myA_card_tel_err_l}    ${myA_card_tel_err}
    Run Keyword And Warn On Failure    Wait Until Page Contains Element    ${myA_card_state_err_l}   10s
    Run Keyword And Warn On Failure    Element Text Should Be    ${myA_card_state_err_l}    ${myA_card_state_err}

Fill in the Add a New Credit Card form
    [Arguments]    ${name}    ${cc_nr}    ${csv}    ${fn}    ${ln}    ${adr}    ${city}    ${state}    ${zip}    ${tel}
    ${myaccname}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${myA_add_card_name_l}    3s
    Run Keyword If    ${myaccname}     Scroll To Element   ${myA_add_card_name_l}
    Run Keyword If    ${myaccname}     CommonWeb.Check and Input text          ${myA_add_card_name_l}    ${name}
    ${myacccardnr}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${myA_add_card_nr_l}    3s
    Run Keyword If    ${myacccardnr}     Scroll To Element   ${myA_add_card_nr_l}
    Run Keyword If    ${myacccardnr}     CommonWeb.Check and Input text          ${myA_add_card_nr_l}    ${cc_nr}
    ${myacccsv}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${myA_add_card_csv_l}    3s
    Run Keyword If    ${myacccsv}     Scroll To Element   ${myA_add_card_csv_l}
    Run Keyword If    ${myacccsv}     CommonWeb.Check and Input text          ${myA_add_card_csv_l}    ${csv}
    ${myaccfname}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${myA_add_card_fn_l}    3s
    Run Keyword If    ${myaccfname}     Scroll To Element   ${myA_add_card_fn_l}
    Run Keyword If    ${myaccfname}     CommonWeb.Check and Input text          ${myA_add_card_fn_l}    ${fn}
    ${myacclname}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${myA_add_card_ln_l}    3s
    Run Keyword If    ${myacclname}     Scroll To Element   ${myA_add_card_ln_l}
    Run Keyword If    ${myacclname}     CommonWeb.Check and Input text          ${myA_add_card_ln_l}    ${ln}
    ${myaccaddr}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${myA_add_card_adr_l}    3s
    Run Keyword If    ${myaccaddr}     Scroll To Element   ${myA_add_card_adr_l}
    Run Keyword If    ${myaccaddr}     CommonWeb.Check and Input text          ${myA_add_card_adr_l}    ${adr}
    ${myacccity}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${myA_add_card_city_l}    3s
    Run Keyword If    ${myacccity}     Scroll To Element   ${myA_add_card_city_l}
    Run Keyword If    ${myacccity}     CommonWeb.Check and Input text          ${myA_add_card_city_l}    ${city}
    ${myaccstate}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${myA_add_card_state_l}    5s
    Run Keyword If    ${myaccstate}    Click Element    ${myA_add_card_state_l}
    #Run Keyword If    ${myaccstate}    Click Element    xpath://div[@id='addPayment']//div[contains(@class, 'selectric-invalid')]//li[contains(.,'${state}')]    #to be uncommented after USSDY-333 is fixed
    Run Keyword If    ${myaccstate}    Click Element    xpath://div[@id='addPayment']//div[contains(@class, 'selectric-text-entered')]//li[contains(.,'${state}')]
    ${myacczip}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${myA_add_card_zip_l}    3s
    Run Keyword If    ${myacczip}     Scroll To Element   ${myA_add_card_zip_l}
    Run Keyword If    ${myacczip}     CommonWeb.Check and Input text          ${myA_add_card_zip_l}    ${zip}
    ${myacctel}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${myA_add_card_tel_l}    3s
    Run Keyword If    ${myacctel}     Scroll To Element   ${myA_add_card_tel_l}
    Run Keyword If    ${myacctel}     CommonWeb.Check and Input text          ${myA_add_card_tel_l}    ${tel}
    Sleep    5s    #to be removed after USSDY-333 is fixed

Check if the new card is present in My Account
    [Arguments]    ${fn}    ${ln}    ${addr}    ${city}    ${zip}    ${phone}
    Wait Until Page Does Not Contain Element    ${myA_add_card_name_l}    30s
    Wait Until Element Is Visible    ${myA_new_card_row_info_l}    30s
    Run Keyword And Warn On Failure    Element Should Contain    ${myA_new_card_row_info_l}    ${fn}
    Run Keyword And Warn On Failure    Element Should Contain    ${myA_new_card_row_info_l}    ${ln}
    Run Keyword And Warn On Failure    Element Should Contain    ${myA_new_card_next_row_l}    ${addr}
    Run Keyword And Warn On Failure    Element Should Contain    ${myA_new_card_city_zip_l}    ${city}
    Run Keyword And Warn On Failure    Element Should Contain    ${myA_new_card_city_zip_l}    ${zip}
    Run Keyword And Warn On Failure    Element Should Contain    ${myA_new_card_first_row_l}    ${phone}

Click on Make Default button near first CC and see if setting is applied
    Click Element    ${myA_paym_make_def_l}
    Wait Until Page Contains Element    ${myA_paym_make_def_select_l}    10s
    Wait Until Element Is Visible    ${myA_paym_make_def_select_l}    10s

Click on Remove button near first CC
    Click Element    ${myA_remove_payment_l}
    Wait Until Page Contains Element    ${myA_delete_paym_conf_l}    10s
    Wait Until Element Is Visible    ${myA_delete_paym_conf_l}    10s

Click Confirm on the Delete CC modal
    Click Element    ${myA_delete_paym_conf_l}
    Wait Until Element Is Not Visible    ${myA_delete_paym_conf_l}    10s

Check that Credit Card section is empty
    Wait Until Page Does Not Contain Element    ${myA_new_card_row_info_l}    5s
    Run Keyword And Warn On Failure    Element Should Not Be Visible    ${myA_new_card_first_row_l}

Access My Account page directly
    Go To    ${PROD_URL}account
    Run Keyword And Warn On Failure    Wait Until Page Contains Element    ${my_account_page_l}    10s

Click on Order History tab
    Click Element    ${myA_orders_tab_l}
    Wait Until Page Contains Element    ${myA_orders_page_l}    10s

Change Password
    [Arguments]     ${actual_password}    ${new_password}
    Click Element   ${change_pass_link}
    Wait Until Element Is Visible    ${current_password_locator}    30    Change Password Container is not displayed
    Input Text      ${current_password_locator}    ${actual_password}
    Input Text      ${new_password_locator}        ${new_password}
    Input Text      ${confirm_password_locator}    ${new_password}
    Click Element   ${submit_button}
    Wait Until Element Is Not Visible    ${current_password_locator}    30    Change Password Container is not displayed

Change Email
    [Arguments]     ${new_email}    ${password}
    Click Element   ${change_email_link}
    Wait Until Element Is Visible    ${new_email_locator}    30    Change Email Container is not displayed
    Input Text      ${new_email_locator}    ${new_email}
    Input Text      ${password_locator}    ${password}
    Click Element   ${save_email_button}
    Wait Until Element Is Not Visible    ${new_email_locator}    30    Change Email Container is not displayed


Change Name in Personal Information
    [Arguments]    ${first_name}=     ${last_name}=
    Input Text    ${first_name_personal_info_locator}    ${first_name}
    Input Text    ${last_name_personal_info_locator}    ${last_name}

Change Birthday in Personal Information
    [Arguments]    ${birthday}
    Input Text    ${birthday_personal_info_locator}    ${birthday}

Change Anniversary in Personal Information
    [Arguments]    ${anniversary}
    Input Text    ${anniversary_personal_info_locator}    ${anniversary}

Save Personal Information
    [Arguments]     ${first_name}
    Click Element    ${save_personal_info_button}
    Wait Until Element Contains    ${page_title_personal_info}    ${first_name}    timeout=30s

Check Personal Information
    [Arguments]    ${first_name}    ${last_name}    ${birthday}    ${anniversary}
    ${actual_first_name}=                   Get text from form              ${first_name_personal_info_locator}
    ${actual_last_name}=                    Get text from form              ${last_name_personal_info_locator}
    ${actual_birthday}=                     Get text from form              ${birthday_personal_info_locator}
    ${actual_anniversary}=                  Get text from form              ${anniversary_personal_info_locator}
    Run Keyword And Warn On Failure         Should Be Equal As Strings      ${actual_first_name}      ${first_name}
    Run Keyword And Warn On Failure         Should Be Equal As Strings      ${actual_last_name}       ${last_name}
    Run Keyword And Warn On Failure         Should Be Equal As Strings      ${actual_birthday}        ${birthday}
    Run Keyword And Warn On Failure         Should Be Equal As Strings      ${actual_anniversary}     ${anniversary}