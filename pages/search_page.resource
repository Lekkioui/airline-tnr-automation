*** Settings ***
Documentation    Page Object for the flight search page.
Library          SeleniumLibrary


*** Variables ***
${SEARCH_URL}    http://127.0.0.1:8000/flights/search/


*** Keywords ***
Go To Search Page
    [Documentation]    Navigates to the search page from the flights list.
    Wait Until Element Is Visible    css:[data-testid='btn-go-to-search']    timeout=10s
    Click Element                    css:[data-testid='btn-go-to-search']
    Wait Until Element Is Visible    css:[data-testid='page-title-search']   timeout=10s

Verify Search Page Loaded
    [Documentation]    Verifies that the search page is correctly displayed.
    Wait Until Element Is Visible    css:[data-testid='page-title-search']    timeout=10s
    Page Should Contain Element      css:[data-testid='search-form']
    Page Should Contain Element      css:[data-testid='search-origin']
    Page Should Contain Element      css:[data-testid='search-destination']
    Page Should Contain Element      css:[data-testid='search-status']

Select Search Origin
    [Documentation]    Selects an origin airport by its visible text.
    [Arguments]    ${airport}
    Select From List By Label    css:[data-testid='search-origin']    ${airport}

Select Search Destination
    [Documentation]    Selects a destination airport by its visible text.
    [Arguments]    ${airport}
    Select From List By Label    css:[data-testid='search-destination']    ${airport}

Select Search Status
    [Documentation]    Selects a flight status filter.
    [Arguments]    ${status}
    Select From List By Value    css:[data-testid='search-status']    ${status}

Submit Search
    [Documentation]    Submits the search form.
    Click Element    css:[data-testid='btn-search-submit']
    Wait Until Element Is Visible    css:[id='page-title-search']    timeout=10s

Reset Search
    [Documentation]    Resets all search filters.
    Click Element    css:[data-testid='btn-search-reset']
    Wait Until Element Is Visible    css:[data-testid='search-initial-state']    timeout=10s

Verify Search Results Count
    [Documentation]    Verifies the number of search results displayed.
    [Arguments]    ${expected_count}
    ${count}=    Get Element Count    css:[data-testid='search-result-item']
    Should Be Equal As Integers    ${count}    ${expected_count}
    ...    msg=Expected ${expected_count} results but got ${count}

Verify Search Has Results
    [Documentation]    Verifies that at least one result is displayed.
    Page Should Contain Element    css:[data-testid='search-results']
    ${count}=    Get Element Count    css:[data-testid='search-result-item']
    Should Be True    ${count} > 0    msg=No results displayed

Verify No Results Found
    [Documentation]    Verifies that the no results message is displayed.
    Page Should Contain Element    css:[data-testid='search-no-results']

Verify Initial State
    [Documentation]    Verifies that the initial state message is displayed before search.
    Page Should Contain Element    css:[data-testid='search-initial-state']

Verify Result Contains Status
    [Documentation]    Verifies that all results match the expected status.
    [Arguments]    ${expected_status}
    ${results}=    Get WebElements    css:[data-testid='search-result-status']
    FOR    ${result}    IN    @{results}
        ${text}=    Get Text    ${result}
        Should Contain    ${text}    ${expected_status}
        ...    msg=Result status '${text}' does not match '${expected_status}'
    END

Click First Search Result
    [Documentation]    Clicks on the first result in the search results list.
    Wait Until Element Is Visible    css:[data-testid='search-flight-link']    timeout=10s
    Click Element                    xpath=(//a[@data-testid='search-flight-link'])[1]
    Wait Until Element Is Visible    css:[id='flight-header']    timeout=10s