*** Settings ***
Documentation       Common keywords shared across all test suites.
Library             OperatingSystem
Library             Process
Library             SeleniumLibrary
Resource            variables.resource
Resource            test_ids.resource


*** Keywords ***
Get Chrome Options
    [Documentation]    Returns headless Chrome options with optimized arguments.
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
    ${args}=    Create List    --headless    --no-sandbox    --disable-dev-shm-usage    --disable-gpu
    ...    --disable-background-networking    --disable-sync    --no-first-run
    ...    --disable-client-side-phishing-detection
    FOR    ${arg}    IN    @{args}
        Call Method    ${options}    add_argument    ${arg}
    END
    RETURN    ${options}

Open Browser Headless
    [Documentation]    Opens a headless Chrome browser.
    ${options}=    Get Chrome Options
    Create WebDriver    Chrome    options=${options}
    Maximize Browser Window

Reset Test Data
    [Documentation]    Resets the database to a clean state via Django manage command.
    ${is_windows}=    Evaluate    os.name == 'nt'    modules=os
    IF    ${is_windows}
        ${python}=    Set Variable    ../airline-django/venv/Scripts/python.exe
    ELSE
        ${python}=    Set Variable    python
    END
    ${result}=    Run Process
    ...    ${python}    manage.py    setup_test_data
    ...    cwd=../airline-django
    ...    stdout=PIPE
    ...    stderr=PIPE
    Log    STDOUT: ${result.stdout}
    Log    STDERR: ${result.stderr}
    Should Be Equal As Integers    ${result.rc}    0
    ...    msg=setup_test_data failed:\n${result.stderr}

Login As Admin
    [Documentation]    Logs in as admin from the login page.
    Go To    ${LOGIN_URL}
    Wait Until Element Is Visible    ${SEL_INPUT_USERNAME}    timeout=${DEFAULT_TIMEOUT}
    Input Text      ${SEL_INPUT_USERNAME}    ${ADMIN_USER}
    Input Text      ${SEL_INPUT_PASSWORD}    ${ADMIN_PASS}
    Click Element   ${SEL_BTN_SIGNIN}
    Wait Until Location Contains    /flights/    timeout=${DEFAULT_TIMEOUT}

Login As Test User
    [Documentation]    Logs in as regular test user.
    Go To    ${LOGIN_URL}
    Wait Until Element Is Visible    ${SEL_INPUT_USERNAME}    timeout=${DEFAULT_TIMEOUT}
    Input Text      ${SEL_INPUT_USERNAME}    ${TEST_USER}
    Input Text      ${SEL_INPUT_PASSWORD}    ${TEST_PASS}
    Click Element   ${SEL_BTN_SIGNIN}
    Wait Until Location Contains    /flights/    timeout=${DEFAULT_TIMEOUT}

Open App As Admin
    [Documentation]    Opens browser and logs in as admin.
    Open Browser Headless
    Login As Admin

Open App As Test User
    [Documentation]    Opens browser and logs in as test user.
    Open Browser Headless
    Login As Test User

Close Session
    [Documentation]    Closes the browser session.
    Close Browser

Create Results Directories
    [Documentation]    Creates results and screenshots directories.
    Create Directory    results/screenshots
