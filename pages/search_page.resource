*** Settings ***
Documentation    Page Object for the flight search page.
Library          SeleniumLibrary
Resource         ../resources/common.resource


*** Keywords ***
Go To Search Page
    [Documentation]    Navigates to the search page from the flights list.
    Wait Until Element Is Visible    ${SEL_BTN_GO_TO_SEARCH}     timeout=${DEFAULT_TIMEOUT}
    Click Element                    ${SEL_BTN_GO_TO_SEARCH}
    Wait Until Element Is Visible    ${SEL_PAGE_TITLE_SEARCH}    timeout=${DEFAULT_TIMEOUT}

Verify Search Page Loaded
    [Documentation]    Verifies that the search page is correctly displayed.
    Wait Until Element Is Visible    ${SEL_PAGE_TITLE_SEARCH}    timeout=${DEFAULT_TIMEOUT}
    Page Should Contain Element      ${SEL_SEARCH_FORM}
    Page Should Contain Element      ${SEL_SEARCH_ORIGIN}
    Page Should Contain Element      ${SEL_SEARCH_DESTINATION}
    Page Should Contain Element      ${SEL_SEARCH_STATUS}

Select Search Origin
    [Documentation]    Selects an origin airport by its visible text.
    [Arguments]    ${airport}
    Select From List By Label    ${SEL_SEARCH_ORIGIN}    ${airport}

Select Search Destination
    [Documentation]    Selects a destination airport by its visible text.
    [Arguments]    ${airport}
    Select From List By Label    ${SEL_SEARCH_DESTINATION}    ${airport}

Select Search Status
    [Documentation]    Selects a flight status filter.
    [Arguments]    ${status}
    Select From List By Value    ${SEL_SEARCH_STATUS}    ${status}

Submit Search
    [Documentation]    Submits the search form.
    Click Element    ${SEL_BTN_SEARCH_SUBMIT}
    Wait Until Element Is Visible    ${SEL_PAGE_TITLE_SEARCH}    timeout=${DEFAULT_TIMEOUT}

Reset Search
    [Documentation]    Resets all search filters.
    Click Element    ${SEL_BTN_SEARCH_RESET}
    Wait Until Element Is Visible    ${SEL_SEARCH_INITIAL_STATE}    timeout=${DEFAULT_TIMEOUT}

Verify Search Results Count
    [Documentation]    Verifies the number of search results displayed.
    [Arguments]    ${expected_count}
    ${count}=    Get Element Count    ${SEL_SEARCH_RESULT_ITEM}
    Should Be Equal As Integers    ${count}    ${expected_count}
    ...    msg=Expected ${expected_count} results but got ${count}

Verify Search Has Results
    [Documentation]    Verifies that at least one result is displayed.
    Page Should Contain Element    ${SEL_SEARCH_RESULTS}
    ${count}=    Get Element Count    ${SEL_SEARCH_RESULT_ITEM}
    Should Be True    ${count} > 0    msg=No results displayed

Verify No Results Found
    [Documentation]    Verifies that the no results message is displayed.
    Page Should Contain Element    ${SEL_SEARCH_NO_RESULTS}

Verify Initial State
    [Documentation]    Verifies that the initial state message is displayed before search.
    Page Should Contain Element    ${SEL_SEARCH_INITIAL_STATE}

Verify Result Contains Status
    [Documentation]    Verifies that all results match the expected status.
    [Arguments]    ${expected_status}
    ${results}=    Get WebElements    ${SEL_SEARCH_RESULT_STATUS}
    FOR    ${result}    IN    @{results}
        ${text}=    Get Text    ${result}
        Should Contain    ${text}    ${expected_status}
        ...    msg=Result status '${text}' does not match '${expected_status}'
    END

Click First Search Result
    [Documentation]    Clicks on the first result in the search results list.
    Wait Until Element Is Visible    ${SEL_SEARCH_FLIGHT_LINK}    timeout=${DEFAULT_TIMEOUT}
    Click Element                    xpath=(//a[@data-testid='search-flight-link'])[1]
    Wait Until Element Is Visible    ${SEL_FLIGHT_HEADER}         timeout=${DEFAULT_TIMEOUT}
