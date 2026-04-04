*** Settings ***
Documentation    Common keywords for test data management and browser configuration.
Library          OperatingSystem
Library          Process
Library          SeleniumLibrary
Resource         variables.resource


*** Keywords ***
Get Chrome Options
    [Documentation]    Returns a headless Chrome options object with all required flags.
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
    Call Method    ${options}    add_argument    --headless
    Call Method    ${options}    add_argument    --no-sandbox
    Call Method    ${options}    add_argument    --disable-dev-shm-usage
    Call Method    ${options}    add_argument    --disable-gpu
    Call Method    ${options}    add_argument    --disable-background-networking
    Call Method    ${options}    add_argument    --disable-sync
    Call Method    ${options}    add_argument    --no-first-run
    Call Method    ${options}    add_argument    --disable-client-side-phishing-detection
    RETURN    ${options}

Reset Test Data
    [Documentation]    Resets the database to a clean state using setup_test_data command.
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
    ...    msg=setup_test_data a échoué:\n${result.stderr}

Create Results Directories
    [Documentation]    Creates the results and screenshots directories if they don't exist.
    Create Directory    results/screenshots
