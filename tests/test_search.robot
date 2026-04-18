*** Settings ***
Documentation    Test suite for the flight search functionality.
Test Tags         search
Library          SeleniumLibrary
Resource         ../pages/search_page.resource
Resource         ../resources/common.resource
Test Setup       Reset Test Data
Test Teardown    Run Keywords
...    Run Keyword If Test Failed    Capture Page Screenshot
...    AND    Close Session


*** Test Cases ***
Search Page Loads
    [Documentation]    Verifie que la page recherche charge correctement.
    Open Search Page
    Verify Search Page Loaded
    Verify Initial State

Search Without Filters Returns Results
    [Documentation]    Verifie qu une recherche sans filtre retourne des resultats.
    Open Search Page
    Submit Search
    Verify Has Results

Search By Origin Returns Results
    [Documentation]    Verifie que le filtre par origine fonctionne.
    [Tags]    filter
    Open Search Page
    Select Origin    ${AIRPORT_JFK}
    Submit Search
    Verify Has Results

Search By Destination Returns Results
    [Documentation]    Verifie que le filtre par destination fonctionne.
    [Tags]    filter
    Open Search Page
    Select Destination    ${AIRPORT_LHR}
    Submit Search
    Verify Has Results

Search By Date Returns Results
    [Documentation]    Verifie que le filtre par date fonctionne.
    [Tags]    filter
    Open Search Page
    Select Date    ${DATE_EXISTING}
    Submit Search
    Verify Has Results

Search Result Links To Flight Detail
    [Documentation]    Verifie qu on peut acceder au detail d un vol depuis les resultats.
    [Tags]    navigation
    Open Search Page
    Select Status    SCHEDULED
    Submit Search
    Verify Has Results
    Click First Result
    Page Should Contain Element    ${SEL_FLIGHT_HEADER}
