*** Settings ***
Documentation       Page Object for the flights index page.
Library             SeleniumLibrary
Resource            ../resources/common.resource


*** Keywords ***
Open Index Page
    [Documentation]    Opens browser, logs in as admin and navigates to flights index.
    Open Browser Headless
    Login As Admin

Verify Index Page Loaded
    [Documentation]    Verifies the flights index page is fully loaded.
    Wait Until Element Is Visible    ${SEL_PAGE_TITLE_FLIGHTS}    timeout=${DEFAULT_TIMEOUT}
    Page Should Contain Element      ${SEL_STATS_BAR}
    Page Should Contain Element      ${SEL_FLIGHT_TABLE}

Verify Stats Bar Displayed
    [Documentation]    Verifies all KPI cells are visible in the stats bar.
    Wait Until Element Is Visible    ${SEL_STATS_BAR}    timeout=${DEFAULT_TIMEOUT}
    Page Should Contain Element      css:[data-testid='stats-bar']

Verify Flight Table Has Rows
    [Documentation]    Verifies that the flight table contains at least one row.
    Wait Until Element Is Visible    ${SEL_FLIGHT_TABLE}    timeout=${DEFAULT_TIMEOUT}
    ${count}=    Get Element Count    ${SEL_FLIGHT_ROW}
    Should Be True    ${count} > 0    msg=No flight rows in table

Filter By Status
    [Documentation]    Selects a status filter and waits for page reload.
    [Arguments]    ${status}
    Wait Until Element Is Visible    ${SEL_FILTER_STATUS}    timeout=${DEFAULT_TIMEOUT}
    Wait Until Element Is Enabled    ${SEL_FILTER_STATUS}    timeout=${DEFAULT_TIMEOUT}
    Select From List By Value        ${SEL_FILTER_STATUS}    ${status}
    Wait Until Element Is Visible    ${SEL_FLIGHT_TABLE}     timeout=${DEFAULT_TIMEOUT}

Filter By Origin
    [Documentation]    Selects an origin airport filter.
    [Arguments]    ${airport_label}
    Wait Until Element Is Visible    ${SEL_FILTER_ORIGIN}    timeout=${DEFAULT_TIMEOUT}
    Wait Until Element Is Enabled    ${SEL_FILTER_ORIGIN}    timeout=${DEFAULT_TIMEOUT}
    Select From List By Label        ${SEL_FILTER_ORIGIN}    ${airport_label}
    Wait Until Element Is Visible    ${SEL_FLIGHT_TABLE}     timeout=${DEFAULT_TIMEOUT}

Filter By Date
    [Documentation]    Sets the date filter using JavaScript.
    [Arguments]    ${date}
    Execute Javascript
    ...    var el = document.querySelector("[data-testid='filter-date']");
    ...    var setter = Object.getOwnPropertyDescriptor(window.HTMLInputElement.prototype, 'value').set;
    ...    setter.call(el, '${date}');
    ...    el.dispatchEvent(new Event('change', { bubbles: true }));
    Wait Until Element Is Visible    ${SEL_FLIGHT_TABLE}    timeout=${DEFAULT_TIMEOUT}

Reset Filters
    [Documentation]    Clicks the reset button to clear all filters.
    Click Element                    ${SEL_BTN_FILTER_RESET}
    Wait Until Element Is Visible    ${SEL_FLIGHT_TABLE}    timeout=${DEFAULT_TIMEOUT}

Click Period Today
    [Documentation]    Clicks the Today period filter button.
    Click Element                    ${SEL_BTN_PERIOD_TODAY}
    Wait Until Element Is Visible    ${SEL_FLIGHT_TABLE}    timeout=${DEFAULT_TIMEOUT}

Click Period Week
    [Documentation]    Clicks the This Week period filter button.
    Click Element                    ${SEL_BTN_PERIOD_WEEK}
    Wait Until Element Is Visible    ${SEL_FLIGHT_TABLE}    timeout=${DEFAULT_TIMEOUT}

Go To Next Page
    [Documentation]    Clicks the Next pagination button.
    Wait Until Element Is Visible    ${SEL_BTN_PAGE_NEXT}    timeout=${DEFAULT_TIMEOUT}
    Click Element                    ${SEL_BTN_PAGE_NEXT}
    Wait Until Element Is Visible    ${SEL_FLIGHT_TABLE}     timeout=${DEFAULT_TIMEOUT}

Verify Results Contain Status
    [Documentation]    Verifies all visible flight rows match expected status.
    [Arguments]    ${expected_status}
    ${rows}=    Get WebElements    css:[data-testid='flight-status']
    Should Be True    len($rows) > 0    msg=No status badges found
    FOR    ${row}    IN    @{rows}
        ${text}=    Get Text    ${row}
        Should Contain    ${text}    ${expected_status}
        ...    msg=Row status '${text}' does not match '${expected_status}'
    END

Open First Flight From Results
    [Documentation]    Clique sur la première ligne du tableau et ouvre le détail.
    Wait Until Element Is Visible    ${SEL_FLIGHT_ROW}    timeout=${DEFAULT_TIMEOUT}
    ${count}=    Get Element Count    ${SEL_FLIGHT_ROW}
    Should Be True    ${count} > 0    msg=Aucun vol trouvé après filtrage
    Click Element    ${SEL_FLIGHT_ROW}:nth-child(1) a
    Wait Until Element Is Visible    ${SEL_FLIGHT_HEADER}    timeout=${DEFAULT_TIMEOUT}

Open First Flight By Status
    [Documentation]    Filtre par statut puis ouvre le premier vol.
    [Arguments]    ${status}
    Filter By Status    ${status}
    Sleep    0.5s
    Verify Flight Table Has Rows
    Verify Results Contain Status    ${status}
    Open First Flight From Results
