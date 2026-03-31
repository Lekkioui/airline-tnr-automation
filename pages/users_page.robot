*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${LOGIN_URL}    http://127.0.0.1:8000/users/login
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
    Go To    ${LOGIN_URL}
    Maximize Browser Window

Login As Admin
    Input Text    name:username    ${ADMIN_USER}
    Input Text    name:password    ${ADMIN_PASS}
    Click Button    xpath=//input[@type='submit' and @value='Sign In →']

Verify Login Success
    # user.html affiche "Hello, <prenom>" après login réussi
    Wait Until Page Contains    Hello    timeout=10s

Login With Credentials
    [Arguments]    ${username}    ${password}
    Input Text    name:username    ${username}
    Input Text    name:password    ${password}
    Click Button    xpath=//input[@type='submit' and @value='Sign In →']

Verify Login Failed
    # On reste sur la page login — on vérifie que le champ username est toujours là
    Wait Until Page Contains Element    name:username    timeout=5s
    Page Should Contain Element    xpath=//input[@type='submit' and @value='Sign In →']

Close Users Session
    Close Browser
