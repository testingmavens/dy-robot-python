*** Settings ***
Library           SeleniumLibrary    screenshot_root_directory=EMBED
Resource          ../../Resources/Locators/MyAccount/LoginOrRegistration.robot
Resource          ../../Resources/Locators/MyAccount/MyAccount.robot
Resource          ../../Resources/Locators/MyAccount/ForgotPassword.robot
Resource          ../CommonWeb.robot

*** Keywords ***
Check whether user can add new address
     Scroll Element Into View    ${address_book_header}
     Click Element    ${add_address_button}
     Run Keyword And Warn On Failure  Element Should Be Visible    ${add_address_modal_header}
     Sleep  3s
     Click Element    ${first_name_textField}
     Check and Input text    ${first_name_textField}    Johan
     Click Element    ${last_name_textField}
     Check and Input text    ${last_name_textField}    Johan
     Click Element    ${street_address_textField}
     Check and Input text    ${street_address_textField}    A1
     Click Element    ${apartment_textField}
     Check and Input text    ${apartment_textField}    A1
     Click Element    ${city_textField}
     Check and Input text    ${city_textField}    Newark
     Click Element    ${state_dropdown_button}
     Sleep  2s
     Click Element    ${state_dropdown_list}
     Click Element    ${zipcode_textField}
     Check and Input text    ${zipcode_textField}    90028
     Click Element    ${phone_number_textField}
     Check and Input text    ${phone_number_textField}    0788991100
     Click Element    ${save_address_button}
     Sleep  3s
     Run Keyword And Warn On Failure    Element Should Contain    ${address_book_selected_address}    Johan Johan \nA1 \nA1 \nNewark, AL 90028 \n078-991-0018

Check whether newly added address in shown on checkout
     Run Keyword And Warn On Failure    Element Should Contain    ${checkout_customer_name}    Johan Johan
     Run Keyword And Warn On Failure    Element Should Contain    ${checkout_customer_address}    A1 \nA1 \n Newark, Alabama, 90028 \n United States
