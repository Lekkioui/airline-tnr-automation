*** Settings ***
Documentation    Page Object for the users login page.
Library          SeleniumLibrary
Resource        ../resources/common.resource


*** Variables ***
${LOGIN_URL}      http://127.0.0.1:8000/users/login
${FLIGHTS_URL}    http://127.0.0.1:8000/flights/
${ADMIN_USER}     anasse
${ADMIN_PASS}     anasse


*** Keywords ***
Open Users Page
    [Documentation]    Opens the login page in a headless Chrome browser.
    ${options}=     Get Chrome Options
    Create WebDriver    Chrome    options=${options}
    Maximize Browser Window
    Go To    ${LOGIN_URL}

Login As Admin
    [Documentation]    Logs in using the admin credentials.
    Input Text     name:username    ${ADMIN_USER}
    Input Text     name:password    ${ADMIN_PASS}
    Click Button   xpath=//input[@type='submit' and @value='Sign In →']

Login With Credentials
    [Documentation]    Logs in using the provided username and password.
    [Arguments]    ${username}    ${password}
    Input Text     name:username    ${username}
    Input Text     name:password    ${password}
    Click Button   xpath=//input[@type='submit' and @value='Sign In →']

Verify Login Success
    [Documentation]    Verifies that login redirects to the flights page.
    Wait Until Location Contains     /flights/                      timeout=10s
    Wait Until Element Is Visible    css:[id='page-title-flights']  timeout=10s

Verify Login Failed
    [Documentation]    Verifies that an error message is shown on failed login.
    Wait Until Page Contains Element    name:username         timeout=5s
    Page Should Contain Element         name:password
    Page Should Contain                 Invalid credentials

Close Users Session
    [Documentation]    Closes the browser session.
    Close Browser
