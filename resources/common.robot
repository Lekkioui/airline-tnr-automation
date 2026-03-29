*** Settings ***
Library     Process
Library     OperatingSystem

*** Keywords ***
Reset Test Data
    ${win_python}=    Set Variable    ../airline-django/venv/Scripts/python.exe
    ${is_win}=        Run Keyword And Return Status    File Should Exist    ${win_python}
    ${cmd}=           Set Variable If    ${is_win}    ${win_python}    python

    # Exécution de la commande personnalisée
    Run Process    ${cmd}    manage.py    setup_test_data    cwd=../airline-django