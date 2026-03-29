*** Settings ***
Library    Process

*** Keywords ***
Reset Test Data
    Run Process    ../airline-django/venv/Scripts/python.exe    manage.py    flush    --noinput    cwd=../airline-django
    Run Process    ../airline-django/venv/Scripts/python.exe    manage.py    migrate    cwd=../airline-django
    Run Process    ../airline-django/venv/Scripts/python.exe    manage.py    loaddata    test_data.json    cwd=../airline-django