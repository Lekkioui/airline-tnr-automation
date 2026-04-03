*** Settings ***
Documentation    Test suite for the passenger profile page.
Library          SeleniumLibrary
Resource         ../pages/flights_page.resource
Resource         ../pages/flight_details_page.resource
Resource         ../pages/passenger_page.resource
Resource         ../resources/common.resource
Test Setup       Reset Test Data
Test Teardown    Run Keywords
...    Run Keyword If Test Failed    Capture Page Screenshot
...    AND    Close Flights Session


*** Test Cases ***
Access Passenger Profile From Flight
    [Documentation]    Vérifie qu'on peut accéder au profil d'un passager depuis un vol.
    Open Flights Page
    Click First Flight
    Click First Passenger
    Verify Passenger Profile Page

Passenger Profile Shows Correct Data
    [Documentation]    Vérifie que le profil affiche les bonnes informations du passager.
    Open Flights Page
    Click First Flight
    Click First Passenger
    Verify Passenger Profile Page
    Page Should Contain Element    css:[data-testid='detail-email']
    Page Should Contain Element    css:[data-testid='detail-passport']
    Page Should Contain Element    css:[data-testid='detail-seat-class']
    Page Should Contain Element    css:[data-testid='detail-seat-number']

Passenger Profile Shows Flights
    [Documentation]    Vérifie que le profil liste les vols du passager.
    Open Flights Page
    Click First Flight
    Click First Passenger
    Verify Passenger Has Flights

Passenger Email Is Correct
    [Documentation]    Vérifie que l'email du passager est correctement affiché.
    Open Flights Page
    Click First Flight
    Click First Passenger
    Verify Passenger Email    hogwarts.com

Passenger Passport Is Correct
    [Documentation]    Vérifie que le numéro de passport est correctement affiché.
    Open Flights Page
    Click First Flight
    Click First Passenger
    Verify Passenger Passport    123456

Passenger Seat Class Is Correct
    [Documentation]    Vérifie que la classe de siège est correctement affichée.
    Open Flights Page
    Click First Flight
    Click First Passenger
    Verify Passenger Seat Class    ECONOMY

Remove Flight From Passenger Profile
    [Documentation]    Vérifie qu'on peut retirer un vol depuis le profil passager.
    Open Flights Page
    Click First Flight
    Click First Passenger
    ${before}=    Get Passenger Flight Count
    Remove First Flight From Passenger
    ${after}=     Get Passenger Flight Count
    Should Be True    ${after} < ${before}
    ...    msg=Le nombre de vols n'a pas diminué après suppression

Passenger With No Flights Shows Empty State
    [Documentation]    Vérifie qu'un passager sans vol affiche le message approprié.
    Open Flights Page
    Click First Flight
    Click First Passenger
    Remove First Flight From Passenger
    Verify Passenger Has No Flights

Flight Link In Profile Goes To Flight Detail
    [Documentation]    Vérifie qu'on peut naviguer vers le détail d'un vol depuis le profil.
    Open Flights Page
    Click First Flight
    Click First Passenger
    Click First Flight In Profile
    Page Should Contain Element    css:[id='flight-header']

New Passenger Has Profile Accessible
    [Documentation]    Vérifie qu'un nouveau passager créé a un profil accessible.
    Open Flights Page
    Click First Flight
    Add New Passenger    Profile    Test    profile@test.com    PT123456    ECONOMY
    Verify Passenger In List    Profile    Test
    Click First Passenger
    Verify Passenger Profile Page
