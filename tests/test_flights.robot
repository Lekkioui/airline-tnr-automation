*** Settings ***
Library     SeleniumLibrary
Resource    ../pages/flights_page.robot
Resource    ../pages/flight_details_page.robot
Resource    ../resources/common.robot
Test Teardown    Run Keywords    Capture Page Screenshot    AND    Close Flights Session

*** Test Cases ***
Check Flights Page
    [Documentation]    Vérifie que la page flights charge et affiche les données
    Open Flights Page
    Verify Flights Page Loaded
    Verify Flights Data

Open Flight Details Test
    [Documentation]    Vérifie qu'on peut ouvrir le détail d'un vol depuis la liste
    Open Flights Page
    Click First Flight
    Verify Flight Details Page

Add Passenger Test
    [Documentation]    Vérifie qu'on peut booker un passager sur un vol
    Open Flights Page
    Click First Flight
    Add Passenger
    Verify Passenger Added