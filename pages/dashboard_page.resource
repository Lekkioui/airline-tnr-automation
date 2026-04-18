*** Settings ***
Documentation    Page Object for the dashboard page.
Library          SeleniumLibrary
Resource         ../resources/common.resource


*** Keywords ***
Open Dashboard As Admin
    [Documentation]    Opens browser, logs in as admin and navigates to dashboard.
    Open Browser Headless
    Login As Admin
    Go To    ${DASHBOARD_URL}
    Wait Until Element Is Visible    ${SEL_PAGE_TITLE_DASHBOARD}    timeout=${DEFAULT_TIMEOUT}

Verify Dashboard Loaded
    [Documentation]    Verifies all dashboard sections are visible.
    Wait Until Element Is Visible    ${SEL_PAGE_TITLE_DASHBOARD}    timeout=${DEFAULT_TIMEOUT}
    Page Should Contain Element      ${SEL_KPI_GRID}
    Page Should Contain Element      ${SEL_TODAY_BAR}

Verify KPIs Displayed
    [Documentation]    Verifies all KPI values are displayed.
    Page Should Contain Element    ${SEL_KPI_TOTAL_FLIGHTS}
    Page Should Contain Element    ${SEL_KPI_TOTAL_PAX}
    Page Should Contain Element    ${SEL_KPI_AVG_OCC}
    Page Should Contain Element    ${SEL_KPI_REVENUE}
    ${flights_text}=    Get Text    ${SEL_KPI_TOTAL_FLIGHTS}
    Should Not Be Empty    ${flights_text}
    ${revenue_text}=    Get Text    ${SEL_KPI_REVENUE}
    Should Contain    ${revenue_text}    $

Verify Today Stats Displayed
    [Documentation]    Verifies today's stats section is visible.
    Wait Until Element Is Visible    ${SEL_TODAY_BAR}    timeout=${DEFAULT_TIMEOUT}
    Page Should Contain Element      ${SEL_TODAY_TOTAL}

Verify Top Routes Displayed
    [Documentation]    Verifies the top routes table is displayed.
    Page Should Contain Element    ${SEL_TABLE_TOP_ROUTES}
    ${rows}=    Get Element Count    css:[data-testid='table-top-routes'] tbody tr
    Should Be True    ${rows} > 0    msg=No rows in top routes table
