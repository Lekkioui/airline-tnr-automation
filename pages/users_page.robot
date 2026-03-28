*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${USERS_URL}    http://127.0.0.1:8000/users/
${ADMIN_USER}   anasse
${ADMIN_PASS}   anasse

*** Keywords ***
Open Users Page
    Open Browser    ${USERS_URL}    chrome
    Maximize Browser Window

Login As Admin
    Input Text    name:username    ${ADMIN_USER}
    Input Text    name:password    ${ADMIN_PASS}
    Click Button  xpath:/html/body/form/input[4]

Verify Login Success
    Wait Until Page Contains    Welcome    timeout=10s

Close Users Session
    Close Browser