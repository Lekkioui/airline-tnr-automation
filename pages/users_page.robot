*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${USERS_URL}    http://127.0.0.1:8000/users/
${ADMIN_USER}   anasse
${ADMIN_PASS}   anasse

*** Keywords ***
Open Users Page
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
    Call Method    ${options}    add_argument    --headless
    Call Method    ${options}    add_argument    --no-sandbox
    Call Method    ${options}    add_argument    --disable-dev-shm-usage
    Call Method    ${options}    add_argument    --disable-gpu
    Create WebDriver    Chrome    options=${options}
    Go To    ${USERS_URL}
    Maximize Browser Window

Login As Admin
    Input Text    name:username    ${ADMIN_USER}
    Input Text    name:password    ${ADMIN_PASS}
    Click Button  xpath:/html/body/form/input[4]

Verify Login Success
    Wait Until Page Contains    Welcome    timeout=10s

Close Users Session
    Close Browser