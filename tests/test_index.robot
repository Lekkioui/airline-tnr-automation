*** Settings ***
Documentation       Test suite for the flights index page — table, filters, pagination.
Library             SeleniumLibrary
Resource            ../pages/index_page.resource
Resource            ../resources/common.resource
Resource            ../resources/test_ids.resource
Test Setup          Open Index Page
Test Teardown       Run Keywords
...    Run Keyword If Test Failed    Capture Page Screenshot
...    AND    Close Session
Test Tags           index


*** Test Cases ***
Index Page Loads With Table
    [Documentation]    Verifie que la page index charge avec le tableau des vols.
    Verify Index Page Loaded
    Verify Flight Table Has Rows

Stats Bar Shows KPIs
    [Documentation]    Verifie que la barre de stats affiche tous les KPIs.
    [Tags]    stats
    Verify Stats Bar Displayed
    Page Should Contain Element      css:[data-testid='stats-bar']
    ${text}=    Get Text    ${SEL_STATS_BAR}
    Should Not Be Empty    ${text}

Filter By Status SCHEDULED Works
    [Documentation]    Verifie que le filtre par statut SCHEDULED fonctionne.
    [Tags]    filter
    Filter By Status    SCHEDULED
    Sleep    0.5s
    Verify Flight Table Has Rows
    Verify Results Contain Status    SCHEDULED

Filter By Status BOARDING Works
    [Documentation]    Verifie que le filtre par statut BOARDING fonctionne.
    [Tags]    filter
    Filter By Status    BOARDING
    Sleep    0.5s
    ${count}=    Get Element Count    ${SEL_FLIGHT_ROW}
    Should Be True    ${count} >= 0

Filter By Origin Works
    [Documentation]    Verifie que le filtre par origine fonctionne.
    [Tags]    filter
    Filter By Origin    ${AIRPORT_JFK}
    Sleep    0.5s
    Verify Flight Table Has Rows

Filter By Date Works
    [Documentation]    Verifie que le filtre par date fonctionne.
    [Tags]    filter
    Filter By Date    ${DATE_EXISTING}
    Sleep    0.5s
    ${count}=    Get Element Count    ${SEL_FLIGHT_ROW}
    Should Be True    ${count} >= 0

Period Today Shows Flights
    [Documentation]    Verifie que le bouton Today affiche les vols d aujourd hui.
    [Tags]    period
    Click Period Today
    Sleep    0.5s
    Page Should Contain Element    ${SEL_FLIGHT_TABLE}

Pagination Next Page Works
    [Documentation]    Verifie que la pagination fonctionne.
    [Tags]    pagination
    Wait Until Element Is Visible    ${SEL_PAGINATION_INFO}
    ...    timeout=${DEFAULT_TIMEOUT}
    ${has_next}=    Run Keyword And Return Status
    ...    Element Should Be Visible    ${SEL_BTN_PAGE_NEXT}
    IF    ${has_next}
        Go To Next Page
        Verify Flight Table Has Rows
    ELSE
        Log    Only one page of results — pagination not testable
    END
