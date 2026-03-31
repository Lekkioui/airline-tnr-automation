*** Settings ***
Library     Process
Library     OperatingSystem

*** Keywords ***
Reset Test Data
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
