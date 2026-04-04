*** Settings ***
Documentation    Page Object for the users login page.
Library          SeleniumLibrary
Resource         ../resources/common.resource


*** Keywords ***
Open Users Page
    [Documentation]    Opens the login page in a headless Chrome browser.
    ${options}=    Get Chrome Options
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
    Wait Until Location Contains     /flights/                         timeout=${DEFAULT_TIMEOUT}
    Wait Until Element Is Visible    ${SEL_PAGE_TITLE_FLIGHTS}        timeout=${DEFAULT_TIMEOUT}

Verify Login Failed
    [Documentation]    Verifies that an error message is shown on failed login.
    Wait Until Page Contains Element    name:username    timeout=${SHORT_TIMEOUT}
    Page Should Contain Element         name:password
    Page Should Contain                 Invalid credentials

Close Users Session
    [Documentation]    Closes the browser session.
    Close Browser
