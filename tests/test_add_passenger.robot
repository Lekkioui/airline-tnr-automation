*** Settings ***
Documentation    Test suite for adding and managing passengers on a flight.
Library          SeleniumLibrary
Resource         ../pages/flights_page.resource
Resource         ../pages/flight_details_page.resource
Resource         ../resources/common.resource
Test Setup       Reset Test Data
Test Teardown    Run Keywords
...    Run Keyword If Test Failed    Capture Page Screenshot
...    AND    Close Flights Session


*** Test Cases ***
Add Economy Passenger
    [Documentation]    Vérifie qu'on peut ajouter un passager en classe Economy.
    Open Flights Page
    Click First Flight
    Add New Passenger
    ...    ${PASSENGER_FIRST_ECONOMY}    ${PASSENGER_LAST_ECONOMY}
    ...    ${PASSENGER_EMAIL_ECONOMY}    ${PASSENGER_PASSPORT_ECONOMY}    ECONOMY
    Verify Passenger Added
    Verify Passenger In List    ${PASSENGER_FIRST_ECONOMY}    ${PASSENGER_LAST_ECONOMY}

Add Business Passenger
    [Documentation]    Vérifie qu'on peut ajouter un passager en classe Business.
    Open Flights Page
    Click First Flight
    Add New Passenger
    ...    ${PASSENGER_FIRST_BUSINESS}    ${PASSENGER_LAST_BUSINESS}
    ...    ${PASSENGER_EMAIL_BUSINESS}    ${PASSENGER_PASSPORT_BUSINESS}    BUSINESS
    Verify Passenger Added
    Verify Passenger In List    ${PASSENGER_FIRST_BUSINESS}    ${PASSENGER_LAST_BUSINESS}

Add First Class Passenger
    [Documentation]    Vérifie qu'on peut ajouter un passager en première classe.
    Open Flights Page
    Click First Flight
    Add New Passenger
    ...    ${PASSENGER_FIRST_FIRST}    ${PASSENGER_LAST_FIRST}
    ...    ${PASSENGER_EMAIL_FIRST}    ${PASSENGER_PASSPORT_FIRST}    FIRST
    Verify Passenger Added
    Verify Passenger In List    ${PASSENGER_FIRST_FIRST}    ${PASSENGER_LAST_FIRST}

Verify Seat Auto Assigned Economy
    [Documentation]    Vérifie que le siège Economy est assigné automatiquement avec préfixe E.
    Open Flights Page
    Click First Flight
    Add New Passenger    Alice    Test    alice@test.com    AT123456    ECONOMY
    Verify Seat Assigned    ECONOMY

Verify Seat Auto Assigned Business
    [Documentation]    Vérifie que le siège Business est assigné automatiquement avec préfixe B.
    Open Flights Page
    Click First Flight
    Add New Passenger    Bob    Test    bob@test.com    BT123456    BUSINESS
    Verify Seat Assigned    BUSINESS

Verify Seat Auto Assigned First
    [Documentation]    Vérifie que le siège First Class est assigné automatiquement avec préfixe F.
    Open Flights Page
    Click First Flight
    Add New Passenger    Charlie    Test    charlie@test.com    CT123456    FIRST
    Verify Seat Assigned    FIRST

Duplicate Email Is Rejected
    [Documentation]    Vérifie qu'un email déjà utilisé est rejeté.
    Open Flights Page
    Click First Flight
    Add New Passenger    Test    User    unique@test.com    TU123456    ECONOMY
    Open Add Passenger Modal
    Fill Passenger Form    Other    Person    unique@test.com    OT999999    ECONOMY
    Click Element    ${SEL_BTN_CONFIRM}
    Verify Booking Error    already

Duplicate Passport Is Rejected
    [Documentation]    Vérifie qu'un numéro de passport déjà utilisé est rejeté.
    Open Flights Page
    Click First Flight
    Open Add Passenger Modal
    Fill Passenger Form    New    Person    new@test.com    HP123456    ECONOMY
    Click Element    ${SEL_BTN_CONFIRM}
    Verify Booking Error    already registered

Invalid Passport Format Is Rejected
    [Documentation]    Vérifie qu'un format de passport invalide est rejeté.
    Open Flights Page
    Click First Flight
    Open Add Passenger Modal
    Fill Passenger Form    Test    User    test@test.com    INVALID    ECONOMY
    Scroll Element Into View    ${SEL_BTN_CONFIRM}
    Click Element               ${SEL_BTN_CONFIRM}
    Verify Booking Error    Passport must be

Empty Fields Are Rejected
    [Documentation]    Vérifie que les champs vides sont bloqués par la validation HTML5.
    Open Flights Page
    Click First Flight
    Open Add Passenger Modal
    Scroll Element Into View    ${SEL_BTN_CONFIRM}
    Click Element               ${SEL_BTN_CONFIRM}
    ${valid}=    Execute Javascript
    ...    return document.getElementById('input-first').validity.valueMissing
    Should Be True    ${valid}    msg=Le champ First Name devrait être invalide quand vide

Cancel Modal Closes Form
    [Documentation]    Vérifie que le bouton Cancel ferme le modal.
    Open Flights Page
    Click First Flight
    Open Add Passenger Modal
    Verify Modal Open
    Scroll Element Into View    ${SEL_BTN_CANCEL_MODAL}
    Click Element               ${SEL_BTN_CANCEL_MODAL}
    Verify Modal Closed

Remove Passenger From Flight
    [Documentation]    Vérifie qu'on peut supprimer un passager d'un vol.
    Open Flights Page
    Click First Flight
    ${before}=    Get Passenger Count In List
    Remove First Passenger
    ${after}=     Get Passenger Count In List
    Should Be True    ${after} < ${before}
    ...    msg=Le nombre de passagers n'a pas diminué après suppression

Add Multiple Passengers Different Classes
    [Documentation]    Vérifie qu'on peut ajouter plusieurs passagers de classes différentes.
    Open Flights Page
    Click First Flight
    Add New Passenger    P1    Test    p1@test.com    P1123456    ECONOMY
    Add New Passenger    P2    Test    p2@test.com    P2123456    BUSINESS
    Add New Passenger    P3    Test    p3@test.com    P3123456    FIRST
    ${count}=    Get Passenger Count In List
    Should Be True    ${count} >= 3
