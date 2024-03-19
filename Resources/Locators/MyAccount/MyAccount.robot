*** Variables ***
##My Account Page page
${my_account_title}             xpath://h1[contains(text(),'Account Registration')]
${register_button}              xpath://a[text()='Register']
${address_book_header}          xpath://h2[text()='Address Book']
${add_address_button}           xpath://a[@aria-label='Add a New Address']

#Add address modal
${add_address_modal_header}    xpath://a[@aria-label='Add a New Address']
${first_name_textField}        xpath://input[@id='firstNameModal']
${last_name_textField}         xpath://input[@id='lastNameModal']
${street_address_textField}    xpath://input[@id='address1']
${apartment_textField}         xpath://input[@id='address2']
${city_textField}              xpath://input[@id='cityPopup']
${state_dropdown_button}       xpath:(//span[contains(text(),'State')]//following-sibling::b)[3]
${state_dropdown_list}         xpath:(//div[@class='selectric-scroll']/ul)[6]/li[contains(text(),'Alabama')]
${zipcode_textField}           xpath://input[@id='zipCode']
${phone_number_textField}      xpath:(//input[@id='phone'])[2]
${save_address_button}         xpath:(//button[text()='Save'])[3]
${address_book_selected_address}  xpath://div[@class='address-item-detail selected']



