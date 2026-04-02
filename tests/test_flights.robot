*** Settings ***
Library     SeleniumLibrary
Resource    ../pages/flights_page.robot
Resource    ../pages/flight_details_page.robot
Resource    ../resources/common.robot
Test Setup       Reset Test Data
Test Teardown    Run Keyword If Test Failed    Capture Page Screenshot

*** Test Cases ***
Check Flights Page
    [Documentation]    Vérifie que la page flights charge et affiche les données
    Open Flights Page
    Verify Flights Page Loaded
    Verify Flights Data

Verify Multiple Flights Are Displayed
    [Documentation]    Vérifie que plusieurs vols sont affichés sur la page
    Open Flights Page
    Verify Multiple Flights Displayed

Open Flight Details Test
    [Documentation]    Vérifie qu'on peut ouvrir le détail d'un vol depuis la liste
    Open Flights Page
    Click First Flight
    Verify Flight Details Page

Verify Flight Status Displayed
    [Documentation]    Vérifie que le statut du vol est affiché sur la page détail
    Open Flights Page
    Click First Flight
    Verify Flight Status    SCHEDULED

Verify Flight Capacity Displayed
    [Documentation]    Vérifie que la capacité du vol est affichée
    Open Flights Page
    Click First Flight
    Page Should Contain Element    css:[data-testid='detail-capacity']
    Page Should Contain Element    css:[data-testid='passenger-count']

Verify Cancelled Flight Booking Disabled
    [Documentation]    Vérifie qu'on ne peut pas booker sur un vol annulé
    Open Flights Page
    Click Flight By Index    7
    Verify Booking Disabled

Invalid Flight Page
    [Documentation]    Vérifie qu'une URL de vol inexistant renvoie une erreur 404
    Open Flights Page
    Go To    http://127.0.0.1:8000/flights/999/
    ${status}    ${_}=    Run Keyword And Ignore Error
    ...    Wait Until Page Contains    Page not found    timeout=5s
    Run Keyword If    '${status}' == 'FAIL'
    ...    Wait Until Page Contains    Not Found    timeout=5s