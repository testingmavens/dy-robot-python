*** Variables ***
##Login OR Registration page
##Login Section
${account_registration_header}             xpath://h1[contains(text(),'Account Registration')]
${registered_customer_subHeading}          xpath://h2[contains(text(),'Registered Customers')]
${registered_customer_messageElement}      xpath://h2[contains(text(),'Registered Customers')]//following-sibling::p
${login_form_email_textField}              xpath://input[@id='login-form-email']
${login_form_email_placeHolderElement}     xpath://label[@for='login-form-email']
${login_form_password_textField}           xpath://input[@id='login-form-password']
${login_form_password_placeHolderElement}  xpath://label[@for='login-form-password']
${login_email_toolTip}                     xpath://i[@class='tooltip-icon']
${forgot_password_link}                    xpath:(//u[contains(text(),'Forgot Your Password?')])[2]
${login_button}                            xpath://button[@id='btnLoginSubmit']
${login_form_email_error}                  xpath://div[@id='form-email-error']
${login_form_password_error}               xpath://div[@id='form-password-error']

##Register section
${new_customer_heading}         xpath://h2[contains(text(),'New Customer')]
${new_customer_messageElement}  xpath://h2[contains(text(),'New Customer')]//following-sibling::p
${faster_check_out}             xpath:(//div[@class='content-asset'])[1]/ul/li[1]
${access_order}                 xpath:(//div[@class='content-asset'])[1]/ul/li[2]
${view_online}                  xpath:(//div[@class='content-asset'])[1]/ul/li[3]
${add_items}                    xpath:(//div[@class='content-asset'])[1]/ul/li[4]
#${register_button}             xpath://div/a[text()='Register']



##Text/Messages - Login section
${registered_customer_messageText}   Please sign In to access your account
${login_email_placeHolder_value}     Email
${login_password_placeHolder_value}  Password
${login_button_text}                 LOG IN
${blank_email_error}                 Please enter a valid email address
${blank_password_error}              Please enter a password

##Text/Messages - New Customer section
${new_customer_messageText}   Register with David Yurman for the following benefits:
${faster_check_out_message}   Faster checkout
${access_order_message}       Access your order status
${view_online_message}        View online order history
${add_items_message}          Add items to your wish list and share






