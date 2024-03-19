*** Variables ***
##registration page locators
${new_customer_heading}              xpath://h2[contains(text(),'New Customer')]
${register_button_regPage}           xpath://button[@id='btnRegistrationSubmit']
${first_name_textField_reg}              xpath://input[@id='registration-form-fname']
${last_name_textField_reg}               xpath://input[@id='registration-form-lname']
${email_textField_reg}                   xpath://input[@id='registration-form-email']
${retype_email_textField_reg}            xpath://input[@id='registration-form-email-confirm']
${password_textField_reg}                xpath://input[@id='registration-form-password']
${retype_password_textField_reg}         xpath://input[@id='registration-form-password-confirm']
${first_name_placeHolder_reg}            xpath://label[@for='registration-form-fname']
${last_name_placeHolder_reg}             xpath://label[@for='registration-form-lname']
${email_placeHolder_reg}                 xpath://label[@for='registration-form-email']
${retype_email_placeHolder_reg}          xpath://label[@for='registration-form-email-confirm']
${password_placeHolder_reg}              xpath://label[@for='registration-form-password']
${retype_password_placeHolder_reg}       xpath://label[@for='registration-form-password-confirm']
${registration_form_indicator_reg}       xpath://div[contains(@class,'form-indicator')]
${password_requirements_button_reg}      xpath://a[@role='button' and @data-toggle='collapse' and contains(text(),' Password Requirements')]
${password_requirements_subHeading_reg}  xpath://div[@class='content-asset']/p[contains(text(),'Please ensure your password:')]
${password_requirement_1_reg}            xpath://li[@class='six-characters']
${password_requirement_2_reg}            xpath://li[@class='capital-lowercase']
${password_requirement_3_reg}            xpath://li[@class='one-number']
${password_requirement_4_reg}            xpath://li[@class='no-spaces']
${password_requirement_5_reg}            xpath://li[@class='no-email']
${password_requirement_6_reg}            xpath://li[@class='special-character']
${add_to_email_reg}                      xpath://label[@for='add-to-email-list']
${first_name_validation_reg}             xpath://div[@id='form-fname-error']
${last_name_validation_reg}              xpath://div[@id='form-lname-error']
${email_validation_reg}                  xpath://div[@id='form-email-error']
${retype_email_validation_reg}           xpath://div[@id='form-email-confirm-error']
${password_validation_reg}               xpath://div[@id='form-password-error']
${retype_password_validation_reg}        xpath://div[@id='form-password-confirm-error']

##Password requirements checked and unchecked
${minimum_length_requirement_checked}         xpath://ul[@class='passwordList passwordSuccess']/li[@class='six-characters checked']
${minimum_length_requirement_unchecked}       xpath://ul[@class='passwordList passwordSuccess']/li[@class='six-characters']
${capital_lowercase_requirement_checked}     xpath://ul[@class='passwordList passwordSuccess']/li[@class='capital-lowercase checked']
${capital_lowercase_requirement_unchecked}   xpath://ul[@class='passwordList passwordSuccess']/li[@class='capital-lowercase']
${one_number_requirement_checked}            xpath://ul[@class='passwordList passwordSuccess']/li[@class='one-number checked']
${one_number_requirement_unchecked}          xpath://ul[@class='passwordList passwordSuccess']/li[@class='one-number']
${no_spaces_requirement_checked}             xpath://ul[@class='passwordList passwordSuccess']/li[@class='no-spaces checked']
${no_spaces_requirement_unchecked}           xpath://ul[@class='passwordList passwordSuccess']/li[@class='no-spaces']
${no_email_requirement_checked}              xpath://ul[@class='passwordList passwordSuccess']/li[@class='no-email checked']
${no_email_requirement_unchecked}            xpath://ul[@class='passwordList passwordSuccess']/li[@class='no-email']
${special_character_requirement_checked}     xpath://ul[@class='passwordList passwordSuccess']/li[@class='special-character checked']
${special_character_requirement_unchecked}   xpath://ul[@class='passwordList passwordSuccess']/li[@class='special-character']

##registration page text/messages
${first_name_placeHolderValue}           First Name
${last_name_placeHolderValue}            Last Name
${email_placeHolderValue}                Email
${retype_email_placeHolderValue}         Retype Email Address
${password_placeHolderValue}             Password
${retype_password_placeHolderValue}      Retype Password
${registration_form_indicatorValue}      * Indicates required fields
${password_requirement_1_value}          Is at least six characters in length
${password_requirement_2_value}          Contains at least one capital letter and one lowercase letter
${password_requirement_3_value}          Contains at least one number
${password_requirement_4_value}          Does not contain spaces
${password_requirement_5_value}          Does not contain your email address
${password_requirement_6_value}          Contains at least one special character (f.ex. !#$£€%)
${add_to_emailValue}                     Sign up to receive email updates from David Yurman about the latest collections and news. Unsubscribe at any time. See our Privacy Policy for details.
${first_name_validationValue}            Please enter your first name.
${last_name_validationValue}             Please enter your last name.
${email_validationValue}                 Please enter a valid email address
${retype_email_validationValue}          Please enter a valid email address
${password_validationValue}              Please enter a password
${retype_password_validationValue}       Please enter a password
${already_existing_user_validation}      User with that email address already exists.
${email_mismatch_validation}             Please enter the same value again.
${password_requirement_doesnt_match}     Sorry, the provided password does not match the required constraints.
${password_requirement_minimum_length}   This field needs 6 to 255 characters


