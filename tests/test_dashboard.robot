*** Settings ***
Documentation    Test suite for the dashboard page.
Test Tags         dashboard
Library          SeleniumLibrary
Resource         ../pages/dashboard_page.resource
Resource         ../resources/common.resource
Test Setup       Reset Test Data
Test Teardown    Run Keywords
...    Run Keyword If Test Failed    Capture Page Screenshot
...    AND    Close Session


*** Test Cases ***
Dashboard Accessible To Admin
    [Documentation]    Verifie que le dashboard est accessible a l admin.
    Open Dashboard As Admin
    Verify Dashboard Loaded

Dashboard Shows All KPIs
    [Documentation]    Verifie que tous les KPIs sont affiches.
    [Tags]    kpi
    Open Dashboard As Admin
    Verify Dashboard Loaded
    Verify KPIs Displayed

Dashboard Shows Today Stats
    [Documentation]    Verifie que les stats du jour sont affichees.
    [Tags]    stats
    Open Dashboard As Admin
    Verify Dashboard Loaded
    Verify Today Stats Displayed

Dashboard Shows Top Routes
    [Documentation]    Verifie que le tableau top routes est affiche.
    [Tags]    stats
    Open Dashboard As Admin
    Verify Dashboard Loaded
    Verify Top Routes Displayed
