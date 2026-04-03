*** Settings ***
Documentation    Test suite for the flight search functionality.
Library          SeleniumLibrary
Resource         ../pages/flights_page.resource
Resource         ../pages/search_page.resource
Resource         ../resources/common.resource
Test Setup       Reset Test Data
Test Teardown    Run Keywords
...    Run Keyword If Test Failed    Capture Page Screenshot
...    AND    Close Flights Session


*** Test Cases ***
Search Page Is Accessible
    [Documentation]    Vérifie que la page recherche est accessible depuis la liste des vols.
    Open Flights Page
    Go To Search Page
    Verify Search Page Loaded

Initial State Shows No Results
    [Documentation]    Vérifie que l'état initial affiche le message d'aide sans résultats.
    Open Flights Page
    Go To Search Page
    Verify Initial State

Search Without Filters Shows All Flights
    [Documentation]    Vérifie qu'une recherche sans filtres affiche tous les vols.
    Open Flights Page
    Go To Search Page
    Submit Search
    Verify Search Has Results
    Verify Search Results Count    8

Search By Origin
    [Documentation]    Vérifie qu'on peut filtrer les vols par aéroport d'origine.
    Open Flights Page
    Go To Search Page
    Select Search Origin    New York City (JFK)
    Submit Search
    Verify Search Has Results

Search By Destination
    [Documentation]    Vérifie qu'on peut filtrer les vols par aéroport de destination.
    Open Flights Page
    Go To Search Page
    Select Search Destination    London (LHR)
    Submit Search
    Verify Search Has Results

Search By Status Scheduled
    [Documentation]    Vérifie qu'on peut filtrer les vols par statut SCHEDULED.
    Open Flights Page
    Go To Search Page
    Select Search Status    SCHEDULED
    Submit Search
    Verify Search Has Results
    Verify Result Contains Status    SCHEDULED

Search By Status Cancelled
    [Documentation]    Vérifie qu'on peut filtrer les vols par statut CANCELLED.
    Open Flights Page
    Go To Search Page
    Select Search Status    CANCELLED
    Submit Search
    Verify Search Has Results
    Verify Result Contains Status    CANCELLED

Search With No Matching Results
    [Documentation]    Vérifie qu'une recherche sans résultats affiche le message approprié.
    Open Flights Page
    Go To Search Page
    Select Search Origin         New York City (JFK)
    Select Search Destination    New York City (JFK)
    Submit Search
    Verify No Results Found

Search By Origin And Destination
    [Documentation]    Vérifie qu'on peut combiner origine et destination.
    Open Flights Page
    Go To Search Page
    Select Search Origin         New York City (JFK)
    Select Search Destination    London (LHR)
    Submit Search
    Verify Search Has Results
    Verify Search Results Count    1

Search By Origin And Status
    [Documentation]    Vérifie qu'on peut combiner origine et statut.
    Open Flights Page
    Go To Search Page
    Select Search Origin    New York City (JFK)
    Select Search Status    SCHEDULED
    Submit Search
    Verify Search Has Results

Reset Clears Filters
    [Documentation]    Vérifie que le bouton Reset remet les filtres à zéro.
    Open Flights Page
    Go To Search Page
    Select Search Status    CANCELLED
    Submit Search
    Verify Search Has Results
    Reset Search
    Verify Initial State

Search Result Links To Flight Detail
    [Documentation]    Vérifie qu'on peut accéder au détail d'un vol depuis les résultats.
    Open Flights Page
    Go To Search Page
    Submit Search
    Click First Search Result
    Page Should Contain Element    css:[id='flight-header']
