*** Settings ***
Library           SeleniumLibrary    screenshot_root_directory=EMBED
Resource          ../Resources/Locators.robot
Resource          ../Keywords/CommonWeb.robot

*** Keywords ***
Login to EPS
    Go To    https://uat-employeepurchase.davidyurman.com/
    Sleep  10s
    CommonWeb.Check and Input text          xpath://input[@id='login-form-email']      shariq.mohammed@davidyurman.com
    CommonWeb.Check and Input text          xpath://input[@id='login-form-password']   Yurman24!
    CommonWeb.Check and Click               xpath://button[@id='btnLoginSubmit']
    Wait Until Page Contains                xpath://h1[@class='page-title']    timeout=20s
    
Click forgot password link
   Scroll Element Into View    xpath://a[@id='password-reset']
   Click Element    xpath://a[@id='password-reset']
   Wait Until Page Contains    xpath://h4[contains(text(),'Forgot your Password')]     timeout=10s

Check forgot password modal
   Element Should Be Visible    xpath:xpath://h4[contains(text(),'Forgot your Password')]     timeout=10s

Enter mail address in forgot password modal
    Scroll Element Into View    xpath://input[@id='reset-password-email']
    CommonWeb.Check and Input text    xpath://input[@id='reset-password-email']    shariq.mohammed@davidyurman.com 

Click submit button from forgot password modal
    Scroll Element Into View    xpath://button[@id='submitEmailButton']
    Click Element    xpath://button[@id='submitEmailButton']

Check forgot password success message
    Element Should Contain    xpath://div[@class='request-password-body']/p    Thanks for submitting your email address. We've sent you an email with the information needed to reset your password. The email might take a couple of minutes to reach your account. Please check your junk mail to ensure you receive it.
    
Click close button from forgot password modal
     Scroll Element Into View    xpath://button[contains(text(),'Close')]

