*** Settings ***
Library     Process
Library     OperatingSystem

*** Keywords ***
Reset Test Data
    ${path_venv}=    Set Variable    ../airline-django/venv/Scripts/python.exe
    ${is_windows}=    Run Keyword And Return Status    File Should Exist    ${path_venv}
    ${cmd}=    Set Variable If    ${is_windows}    ${path_venv}    python

    # 1. Nettoyage
    Run Process    ${cmd}    manage.py    flush    --noinput    cwd=../airline-django
    
    # 2. Injection directe
    ${script}=    Set Variable    from django.contrib.auth.models import User; from flights.models import Airport, Flight, Passenger; User.objects.create_superuser('anasse', 'anasse@gmail.com', 'anasse'); jfk=Airport.objects.get_or_create(code='JFK', city='New York City')[0]; lhr=Airport.objects.get_or_create(code='LHR', city='London')[0]; Flight.objects.get_or_create(origin=jfk, destination=lhr, duration=415); [Passenger.objects.get_or_create(first=f'Passenger{i}', last='Test') for i in range(10)]
    
    Run Process    ${cmd}    manage.py    shell    -c    ${script}    cwd=../airline-django