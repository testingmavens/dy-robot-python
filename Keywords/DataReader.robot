*** Settings ***
Library           SeleniumLibrary    screenshot_root_directory=EMBED
Library           Collections
Library           OperatingSystem
Library           XML
Library           DateTime
Library           String
Library           random
Library           OperatingSystem
Library           JSONLibrary

Resource          ../Resources/Variables.robot
Resource          ../Keywords/Checkout.robot
Resource          ../Keywords/LamdaTestSetup.robot

*** Keywords ***
Read Data From JSON File
   IF  '${shopLocale}' in ['US']
     ${file}   Load Json From File       Resources/DataFiles/USData.json
   ELSE IF  '${shopLocale}' in ['CN']
     ${file}   Load Json From File       Resources/DataFiles/CNData.json
   ELSE IF  '${shopLocale}' in ['UK']
     ${file}   Load Json From File       Resources/DataFiles/UKData.json
   ELSE IF  '${shopLocale}' in ['FR']
     ${file}   Load Json From File       Resources/DataFiles/FRData.json
   ELSE IF  '${shopLocale}' in ['GR']
     ${file}   Load Json From File       Resources/DataFiles/GRData.json
   END

   ${FIRST_NAME}    Get Value From Json    ${file}    $.FIRST_NAME
   ${FIRST_NAME}    Convert To String      ${FIRST_NAME}
   ${FIRST_NAME}    Get Clear DATA         ${FIRST_NAME}
   ${FIRST_NAME}    Set Test Variable      ${FIRST_NAME}

   ${LAST_NAME}    Get Value From Json     ${file}    $.LAST_NAME
   ${LAST_NAME}    Convert To String       ${LAST_NAME}
   ${LAST_NAME}    Get Clear DATA          ${LAST_NAME}
   ${LAST_NAME}    Set Test Variable       ${LAST_NAME}

   ${ADDRESS}       Get Value From Json    ${file}    $.ADDRESS
   ${ADDRESS}       Convert To String      ${ADDRESS}
   ${ADDRESS}       Get Clear DATA         ${ADDRESS}
   ${ADDRESS}       Set Test Variable      ${ADDRESS}

   ${ADDRESS2}      Get Value From Json    ${file}    $.ADDRESS2
   ${ADDRESS2}      Convert To String      ${ADDRESS2}
   ${ADDRESS2}      Get Clear DATA         ${ADDRESS2}
   ${ADDRESS2}      Set Test Variable      ${ADDRESS2}

   ${ZIP}           Get Value From Json    ${file}    $.ZIP
   ${ZIP}           Convert To String      ${ZIP}
   ${ZIP}           Get Clear DATA         ${ZIP}
   ${ZIP}           Set Test Variable      ${ZIP}

   ${PHONE}         Get Value From Json    ${file}    $.PHONE
   ${PHONE}         Convert To String      ${PHONE}
   ${PHONE}         Get Clear DATA         ${PHONE}
   ${PHONE}         Set Test Variable      ${PHONE}

   ${CITY}          Get Value From Json     ${file}    $.CITY
   ${CITY}          Convert To String       ${CITY}
   ${CITY}          Get Clear DATA          ${CITY}
   ${CITY}          Set Test Variable       ${CITY}

   ${STATE}          Get Value From Json     ${file}    $.STATE
   ${STATE}          Convert To String       ${STATE}
   ${STATE}          Get Clear DATA          ${STATE}
   ${STATE}          Set Test Variable       ${STATE}

   ${EDITED_FIRST_NAME}    Get Value From Json    ${file}    $.EDITED_FIRST_NAME
   ${EDITED_FIRST_NAME}    Convert To String      ${EDITED_FIRST_NAME}
   ${EDITED_FIRST_NAME}    Get Clear DATA         ${EDITED_FIRST_NAME}
   ${EDITED_FIRST_NAME}    Set Test Variable      ${EDITED_FIRST_NAME}

   ${EDITED_LAST_NAME}    Get Value From Json    ${file}    $.EDITED_LAST_NAME
   ${EDITED_LAST_NAME}    Convert To String      ${EDITED_LAST_NAME}
   ${EDITED_LAST_NAME}    Get Clear DATA         ${EDITED_LAST_NAME}
   ${EDITED_LAST_NAME}    Set Test Variable      ${EDITED_LAST_NAME}

   ${EDITED_ADDRESS}       Get Value From Json    ${file}    $.EDITED_ADDRESS
   ${EDITED_ADDRESS}       Convert To String      ${EDITED_ADDRESS}
   ${EDITED_ADDRESS}       Get Clear DATA         ${EDITED_ADDRESS}
   ${EDITED_ADDRESS}       Set Test Variable      ${EDITED_ADDRESS}

   ${CITY_IN_ADDRESS_DROPDOWN}       Get Value From Json    ${file}    $.CITY_IN_ADDRESS_DROPDOWN
   ${CITY_IN_ADDRESS_DROPDOWN}       Convert To String      ${CITY_IN_ADDRESS_DROPDOWN}
   ${CITY_IN_ADDRESS_DROPDOWN}       Get Clear DATA         ${CITY_IN_ADDRESS_DROPDOWN}
   ${CITY_IN_ADDRESS_DROPDOWN}       Set Test Variable      ${CITY_IN_ADDRESS_DROPDOWN}

   ${REGISTERED_email}               Get Value From Json    ${file}    $.REGISTERED_email
   ${REGISTERED_email}               Convert To String      ${REGISTERED_email}
   ${REGISTERED_email}               Get Clear DATA         ${REGISTERED_email}
   ${REGISTERED_email}               Set Test Variable      ${REGISTERED_email}

   ${REGISTERED_pwd}               Get Value From Json    ${file}    $.REGISTERED_pwd
   ${REGISTERED_pwd}               Convert To String      ${REGISTERED_pwd}
   ${REGISTERED_pwd}               Get Clear DATA         ${REGISTERED_pwd}
   ${REGISTERED_pwd}               Set Test Variable      ${REGISTERED_pwd}

   ${PASSWORD}               Get Value From Json    ${file}    $.PASSWORD
   ${PASSWORD}               Convert To String      ${PASSWORD}
   ${PASSWORD}               Get Clear DATA         ${PASSWORD}
   ${PASSWORD}               Set Test Variable      ${PASSWORD}

   ${GUEST_email}               Get Value From Json    ${file}    $.GUEST_email
   ${GUEST_email}               Convert To String      ${GUEST_email}
   ${GUEST_email}               Get Clear DATA         ${GUEST_email}
   ${GUEST_email}               Set Test Variable      ${GUEST_email}

   ${reg_29_address}               Get Value From Json    ${file}    $.reg_29_address
   ${reg_29_address}               Convert To String      ${reg_29_address}
   ${reg_29_address}               Get Clear DATA         ${reg_29_address}
   ${reg_29_address}               Set Test Variable      ${reg_29_address}

   ${reg_29_city}               Get Value From Json    ${file}    $.reg_29_city
   ${reg_29_city}               Convert To String      ${reg_29_city}
   ${reg_29_city}               Get Clear DATA         ${reg_29_city}
   ${reg_29_city}               Set Test Variable      ${reg_29_city}

   ${reg_29_state}               Get Value From Json    ${file}    $.reg_29_state
   ${reg_29_state}               Convert To String      ${reg_29_state}
   ${reg_29_state}               Get Clear DATA         ${reg_29_state}
   ${reg_29_state}               Set Test Variable      ${reg_29_state}

   ${reg_29_zip}               Get Value From Json    ${file}    $.reg_29_state
   ${reg_29_zip}               Convert To String      ${reg_29_zip}
   ${reg_29_zip}               Get Clear DATA         ${reg_29_zip}
   ${reg_29_zip}               Set Test Variable      ${reg_29_zip}

   ${reg_29_tel}               Get Value From Json    ${file}    $.reg_29_tel
   ${reg_29_tel}               Convert To String      ${reg_29_tel}
   ${reg_29_tel}               Get Clear DATA         ${reg_29_tel}
   ${reg_29_tel}               Set Test Variable      ${reg_29_tel}

   ${Reg_FIRST_NAME}               Get Value From Json    ${file}    $.Reg_FIRST_NAME
   ${Reg_FIRST_NAME}               Convert To String      ${Reg_FIRST_NAME}
   ${Reg_FIRST_NAME}               Get Clear DATA         ${Reg_FIRST_NAME}
   ${Reg_FIRST_NAME}               Set Test Variable      ${Reg_FIRST_NAME}

   ${Reg_LAST_NAME}               Get Value From Json    ${file}    $.Reg_LAST_NAME
   ${Reg_LAST_NAME}               Convert To String      ${Reg_LAST_NAME}
   ${Reg_LAST_NAME}               Get Clear DATA         ${Reg_LAST_NAME}
   ${Reg_LAST_NAME}               Set Test Variable      ${Reg_LAST_NAME}

   ${reg_29_address_1}               Get Value From Json    ${file}    $.reg_29_address_1
   ${reg_29_address_1}               Convert To String      ${reg_29_address_1}
   ${reg_29_address_1}               Get Clear DATA         ${reg_29_address_1}
   ${reg_29_address_1}               Set Test Variable      ${reg_29_address_1}

   ${reg_29_city_1}               Get Value From Json    ${file}    $.reg_29_city_1
   ${reg_29_city_1}               Convert To String      ${reg_29_city_1}
   ${reg_29_city_1}               Get Clear DATA         ${reg_29_city_1}
   ${reg_29_city_1}               Set Test Variable      ${reg_29_city_1}

   ${reg_29_state_1}               Get Value From Json    ${file}    $.reg_29_state_1
   ${reg_29_state_1}               Convert To String      ${reg_29_state_1}
   ${reg_29_state_1}               Get Clear DATA         ${reg_29_state_1}
   ${reg_29_state_1}               Set Test Variable      ${reg_29_state_1}

   ${reg_29_zip_1}               Get Value From Json    ${file}    $.reg_29_zip_1
   ${reg_29_zip_1}               Convert To String      ${reg_29_zip_1}
   ${reg_29_zip_1}               Get Clear DATA         ${reg_29_zip_1}
   ${reg_29_zip_1}               Set Test Variable      ${reg_29_zip_1}

   ${reg_29_tel_1}               Get Value From Json    ${file}    $.reg_29_tel_1
   ${reg_29_tel_1}               Convert To String      ${reg_29_tel_1}
   ${reg_29_tel_1}               Get Clear DATA         ${reg_29_tel_1}
   ${reg_29_tel_1}               Set Test Variable      ${reg_29_tel_1}

   ${reg_29_name}               Get Value From Json    ${file}    $.reg_29_name
   ${reg_29_name}               Convert To String      ${reg_29_name}
   ${reg_29_name}               Get Clear DATA         ${reg_29_name}
   ${reg_29_name}               Set Test Variable      ${reg_29_name}

   ${reg_29_password}               Get Value From Json    ${file}    $.reg_29_password
   ${reg_29_password}               Convert To String      ${reg_29_password}
   ${reg_29_password}               Get Clear DATA         ${reg_29_password}
   ${reg_29_password}               Set Test Variable      ${reg_29_password}

   ${Reg_ADDRESS}               Get Value From Json    ${file}    $.Reg_ADDRESS
   ${Reg_ADDRESS}               Convert To String      ${Reg_ADDRESS}
   ${Reg_ADDRESS}               Get Clear DATA         ${Reg_ADDRESS}
   ${Reg_ADDRESS}               Set Test Variable      ${Reg_ADDRESS}

   ${ZIP_two}               Get Value From Json    ${file}    $.ZIP_two
   ${ZIP_two}               Convert To String      ${ZIP_two}
   ${ZIP_two}               Get Clear DATA         ${ZIP_two}
   ${ZIP_two}               Set Test Variable      ${ZIP_two}

   ${PHONE_two}               Get Value From Json    ${file}    $.PHONE_two
   ${PHONE_two}               Convert To String      ${PHONE_two}
   ${PHONE_two}               Get Clear DATA         ${PHONE_two}
   ${PHONE_two}               Set Test Variable      ${PHONE_two}

   ${GUEST_second_email}               Get Value From Json    ${file}    $.GUEST_second_email
   ${GUEST_second_email}               Convert To String      ${GUEST_second_email}
   ${GUEST_second_email}               Get Clear DATA         ${GUEST_second_email}
   ${GUEST_second_email}               Set Test Variable      ${GUEST_second_email}

   ${GUEST_email}               Get Value From Json    ${file}    $.GUEST_email
   ${GUEST_email}               Convert To String      ${GUEST_email}
   ${GUEST_email}               Get Clear DATA         ${GUEST_email}
   ${GUEST_email}               Set Test Variable      ${GUEST_email}

Get Clear DATA
    [Arguments]  ${data}
    ${clean_data}      Remove String     ${data}         [
    ${clean_data}      Remove String     ${clean_data}   ]
    ${clean_data}        Remove String   ${clean_data}   '
  RETURN  ${clean_data}

Read JSON and Set Variables
    ${json_content}=    Get File    Resources/DataFiles/USData.json
    ${json}=    Evaluate    json.loads('''${json_content}''')    json
    FOR    ${key}    IN    @{json.keys()}
        ${value}=    Get From Dictionary    ${json}    ${key}
        Set Test Variable    ${key}      ${value}
    END