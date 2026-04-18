*** Settings ***
Documentation       Test suite for the passenger profile page.
Library             SeleniumLibrary
Resource            ../pages/passenger_page.resource
Resource            ../resources/common.resource
Test Setup          Reset Test Data
Test Teardown       Run Keywords
...    Run Keyword If Test Failed    Capture Page Screenshot
...    AND    Close Session
Test Tags           passenger


*** Test Cases ***
Access Passenger Profile From Flight
    [Documentation]    Verifie qu on peut acceder au profil d un passager depuis un vol.
    Open Flight With Passengers
    Click First Passenger
    Verify Passenger Profile Loaded

Passenger Profile Shows Correct Fields
    [Documentation]    Verifie que le profil affiche tous les champs necessaires.
    Open Flight With Passengers
    Click First Passenger
    Verify Passenger Profile Loaded
    Page Should Contain Element    ${SEL_DETAIL_EMAIL}
    Page Should Contain Element    ${SEL_DETAIL_PASSPORT}
    Page Should Contain Element    ${SEL_DETAIL_SEAT_CLASS}
    Page Should Contain Element    ${SEL_DETAIL_SEAT_NUMBER}

Passenger Profile Shows Flights
    [Documentation]    Verifie que le profil liste les vols du passager.
    Open Flight With Passengers
    Click First Passenger
    Verify Passenger Has Flights

Passenger Seat Class Is Valid
    [Documentation]    Verifie que la classe de siege est valide.
    Open Flight With Passengers
    Click First Passenger
    Verify Passenger Seat Class

Remove Flight From Passenger Profile
    [Documentation]    Verifie qu on peut retirer un vol depuis le profil passager.
    Open Flight With Passengers
    Click First Passenger
    ${before}=    Get Passenger Flight Count
    Remove First Flight From Passenger
    ${after}=     Get Passenger Flight Count
    Should Be True    ${after} < ${before}
    ...    msg=Le nombre de vols n a pas diminue apres suppression

Passenger With No Flights Shows Empty State
    [Documentation]    Verifie qu un passager sans vol affiche le message approprie.
    Open Flight With Passengers
    Click First Passenger
    Remove First Flight From Passenger
    Verify Passenger Has No Flights
