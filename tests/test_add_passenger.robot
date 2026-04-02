*** Settings ***
Library      SeleniumLibrary
Resource     ../pages/flights_page.robot
Resource     ../pages/flight_details_page.robot
Resource     ../resources/common.robot
Test Setup       Reset Test Data
Test Teardown    Run Keyword If Test Failed    Capture Page Screenshot

*** Test Cases ***
Add Economy Passenger
    [Documentation]    Vérifie qu'on peut ajouter un passager en classe Economy
    Open Flights Page
    Click First Flight
    Add New Passenger    John    Doe    john@test.com    JD123456    ECONOMY
    Verify Passenger Added
    Verify Passenger In List    John    Doe

Add Business Passenger
    [Documentation]    Vérifie qu'on peut ajouter un passager en classe Business
    Open Flights Page
    Click First Flight
    Add New Passenger    Jane    Smith    jane@test.com    JS123456    BUSINESS
    Verify Passenger Added
    Verify Passenger In List    Jane    Smith

Add First Class Passenger
    [Documentation]    Vérifie qu'on peut ajouter un passager en première classe
    Open Flights Page
    Click First Flight
    Add New Passenger    James    Bond    james@test.com    JB123456    FIRST
    Verify Passenger Added
    Verify Passenger In List    James    Bond

Verify Seat Auto Assigned Economy
    [Documentation]    Vérifie que le siège Economy est assigné automatiquement avec préfixe E
    Open Flights Page
    Click First Flight
    Add New Passenger    Alice    Test    alice@test.com    AT123456    ECONOMY
    Verify Seat Assigned    ECONOMY

Verify Seat Auto Assigned Business
    [Documentation]    Vérifie que le siège Business est assigné automatiquement avec préfixe B
    Open Flights Page
    Click First Flight
    Add New Passenger    Bob    Test    bob@test.com    BT123456    BUSINESS
    Verify Seat Assigned    BUSINESS

Verify Seat Auto Assigned First
    [Documentation]    Vérifie que le siège First Class est assigné automatiquement avec préfixe F
    Open Flights Page
    Click First Flight
    Add New Passenger    Charlie    Test    charlie@test.com    CT123456    FIRST
    Verify Seat Assigned    FIRST

Duplicate Email Is Rejected
    [Documentation]    Vérifie qu'un email déjà utilisé est rejeté
    Open Flights Page
    Click First Flight
    Open Add Passenger Modal
    Fill Passenger Form    Harry    Potter    harry@hogwarts.com    XX999999    ECONOMY
    Click Element    css:[data-testid='btn-confirm-add-passenger']
    Verify Booking Error    already booked

Duplicate Passport Is Rejected
    [Documentation]    Vérifie qu'un numéro de passport déjà utilisé est rejeté
    Open Flights Page
    Click First Flight
    Open Add Passenger Modal
    Fill Passenger Form    New    Person    new@test.com    HP123456    ECONOMY
    Click Element    css:[data-testid='btn-confirm-add-passenger']
    Verify Booking Error    already registered

Invalid Passport Format Is Rejected
    [Documentation]    Vérifie qu'un format de passport invalide est rejeté
    Open Flights Page
    Click First Flight
    Open Add Passenger Modal
    Fill Passenger Form    Test    User    test@test.com    INVALID    ECONOMY
    Scroll Element Into View    css:[data-testid='btn-confirm-add-passenger']
    Click Element               css:[data-testid='btn-confirm-add-passenger']
    Verify Booking Error    Passport must be

Empty Fields Are Rejected
    [Documentation]    Vérifie que les champs vides sont bloqués par la validation HTML5
    Open Flights Page
    Click First Flight
    Open Add Passenger Modal
    Scroll Element Into View    css:[data-testid='btn-confirm-add-passenger']
    Click Element               css:[data-testid='btn-confirm-add-passenger']
    ${valid}=    Execute Javascript
    ...    return document.getElementById('input-first').validity.valueMissing
    Should Be True    ${valid}    msg=Le champ First Name devrait être invalide quand vide

Cancel Modal Closes Form
    [Documentation]    Vérifie que le bouton Cancel ferme le modal
    Open Flights Page
    Click First Flight
    Open Add Passenger Modal
    Verify Modal Open
    Scroll Element Into View    css:[data-testid='btn-cancel-modal']
    Click Element               css:[data-testid='btn-cancel-modal']
    Verify Modal Closed

Remove Passenger From Flight
    [Documentation]    Vérifie qu'on peut supprimer un passager d'un vol
    Open Flights Page
    Click First Flight
    ${before}=    Get Passenger Count In List
    Remove First Passenger
    ${after}=     Get Passenger Count In List
    Should Be True    ${after} < ${before}
    ...    msg=Le nombre de passagers n'a pas diminué après suppression

Add Multiple Passengers Different Classes
    [Documentation]    Vérifie qu'on peut ajouter plusieurs passagers de classes différentes
    Open Flights Page
    Click First Flight
    Add New Passenger    P1    Test    p1@test.com    P1123456    ECONOMY
    Add New Passenger    P2    Test    p2@test.com    P2123456    BUSINESS
    Add New Passenger    P3    Test    p3@test.com    P3123456    FIRST
    ${count}=    Get Passenger Count In List
    Should Be True    ${count} >= 3