*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${LOGIN_URL}      http://127.0.0.1:8000/users/login
${FLIGHTS_URL}    http://127.0.0.1:8000/flights/
${ADMIN_USER}     anasse
${ADMIN_PASS}     anasse

*** Keywords ***
Open Users Page
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
    Call Method    ${options}    add_argument    --headless
    Call Method    ${options}    add_argument    --no-sandbox
    Call Method    ${options}    add_argument    --disable-dev-shm-usage
    Call Method    ${options}    add_argument    --disable-gpu
    Call Method    ${options}    add_argument    --disable-background-networking
    Call Method    ${options}    add_argument    --disable-sync
    Call Method    ${options}    add_argument    --no-first-run
    Call Method    ${options}    add_argument    --disable-default-apps
    Call Method    ${options}    add_argument    --disable-extensions
    Create WebDriver    Chrome    options=${options}
    Maximize Browser Window
    Go To    ${LOGIN_URL}

Login As Admin
    Input Text     name:username    ${ADMIN_USER}
    Input Text     name:password    ${ADMIN_PASS}
    Click Button   xpath=//input[@type='submit' and @value='Sign In →']

Login With Credentials
    [Arguments]    ${username}    ${password}
    Input Text     name:username    ${username}
    Input Text     name:password    ${password}
    Click Button   xpath=//input[@type='submit' and @value='Sign In →']

Verify Login Success
    Wait Until Location Contains    /flights/    timeout=10s
    Wait Until Element Is Visible    css:[id='page-title-flights']    timeout=10s

Verify Login Failed
    Wait Until Page Contains Element    name:username             timeout=5s
    Page Should Contain Element         name:password
    Page Should Contain                 Invalid credentials

Close Users Session
    Close Browser