*** Settings ***
Library      SeleniumLibrary
Resource     ../pages/flights_page.robot
Resource     ../pages/flight_details_page.robot
Resource     ../resources/common.robot
Test Setup       Reset Test Data
Test Teardown    Run Keywords    Capture Page Screenshot    AND    Close Flights Session

*** Test Cases ***
Add Passenger To Flight
    [Documentation]    Vérifie qu'on peut booker un passager sur un vol et qu'il apparaît dans la liste
    Open Flights Page
    Click First Flight
    Verify Flight Details Page
    Add Passenger
    Verify Passenger Added

Add Passenger Decreases Available List
    [Documentation]    Vérifie que la liste des non-passagers diminue après un booking
    Open Flights Page
    Click First Flight
    ${before}=    Get Passenger Count
    Add Passenger
    ${after}=     Get Passenger Count
    Should Be True    ${after} < ${before}    msg=Le nombre de passagers disponibles n'a pas diminué après booking

Add Multiple Passengers
    [Documentation]    Vérifie qu'on peut booker plusieurs passagers successivement
    Open Flights Page
    Click First Flight
    Add Passenger
    Add Passenger
    Verify Passenger Added

No Passenger Available After Filling Flight
    [Documentation]    Vérifie que la liste devient vide après avoir booké tous les passagers disponibles
    Open Flights Page
    Click First Flight
    FOR    ${i}    IN RANGE    20
        ${count}=    Get Passenger Count
        Exit For Loop If    ${count} == 0
        Run Keyword And Ignore Error    Add Passenger
    END
    Reload Page
    Wait Until Element Is Visible    css:[id='flight-header']    timeout=10s
    Verify No Passengers Available

Invalid Flight Page
    [Documentation]    Vérifie qu'une URL de vol inexistant renvoie une erreur 404
    Open Flights Page
    Go To    http://127.0.0.1:8000/flights/999/
    ${status}    ${_}=    Run Keyword And Ignore Error
    ...    Wait Until Page Contains    Page not found    timeout=5s
    Run Keyword If    '${status}' == 'FAIL'
    ...    Wait Until Page Contains    Not Found    timeout=5s