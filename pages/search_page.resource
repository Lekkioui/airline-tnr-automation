*** Settings ***
Documentation    Page Object for the flight search page.
Library          SeleniumLibrary
Resource         ../resources/common.resource


*** Keywords ***
Open Search Page
    [Documentation]    Opens browser, logs in and navigates to search page.
    Open Browser Headless
    Login As Admin
    Go To    ${SEARCH_URL}
    Wait Until Element Is Visible    ${SEL_PAGE_TITLE_SEARCH}    timeout=${DEFAULT_TIMEOUT}

Verify Search Page Loaded
    [Documentation]    Verifies the search page is fully loaded.
    Wait Until Element Is Visible    ${SEL_PAGE_TITLE_SEARCH}    timeout=${DEFAULT_TIMEOUT}
    Page Should Contain Element      ${SEL_SEARCH_FORM}
    Page Should Contain Element      ${SEL_SEARCH_ORIGIN}
    Page Should Contain Element      ${SEL_SEARCH_DESTINATION}
    Page Should Contain Element      ${SEL_SEARCH_STATUS}
    Page Should Contain Element      ${SEL_SEARCH_DATE}

Verify Initial State
    [Documentation]    Verifies initial state before any search.
    Page Should Contain Element    ${SEL_SEARCH_INITIAL_STATE}

Select Origin
    [Documentation]    Selects an origin airport from the search form.
    [Arguments]    ${airport}
    Wait Until Element Is Visible    ${SEL_SEARCH_ORIGIN}    timeout=${DEFAULT_TIMEOUT}
    Wait Until Element Is Enabled    ${SEL_SEARCH_ORIGIN}    timeout=${DEFAULT_TIMEOUT}
    Select From List By Label        ${SEL_SEARCH_ORIGIN}    ${airport}

Select Destination
    [Documentation]    Selects a destination airport from the search form.
    [Arguments]    ${airport}
    Wait Until Element Is Visible    ${SEL_SEARCH_DESTINATION}    timeout=${DEFAULT_TIMEOUT}
    Wait Until Element Is Enabled    ${SEL_SEARCH_DESTINATION}    timeout=${DEFAULT_TIMEOUT}
    Select From List By Label        ${SEL_SEARCH_DESTINATION}    ${airport}

Select Status
    [Documentation]    Selects a status from the search form.
    [Arguments]    ${status}
    Wait Until Element Is Visible    ${SEL_SEARCH_STATUS}    timeout=${DEFAULT_TIMEOUT}
    Wait Until Element Is Enabled    ${SEL_SEARCH_STATUS}    timeout=${DEFAULT_TIMEOUT}
    Select From List By Value        ${SEL_SEARCH_STATUS}    ${status}

Select Date
    [Documentation]    Selects a date in the search form by setting the date input value and triggering a change event.
    [Arguments]    ${date}
    Execute Javascript
    ...    var el = document.querySelector("[data-testid='search-date']");
    ...    var setter = Object.getOwnPropertyDescriptor(window.HTMLInputElement.prototype, 'value').set;
    ...    setter.call(el, '${date}');
    ...    el.dispatchEvent(new Event('change', { bubbles: true }));
    Sleep    0.5s

Submit Search
    [Documentation]    Submits the search form.
    Execute Javascript    document.querySelector('[data-testid="search-form"]').submit()
    Sleep    0.5s
    Wait Until Element Is Visible    ${SEL_PAGE_TITLE_SEARCH}    timeout=${DEFAULT_TIMEOUT}

Reset Search
    [Documentation]    Resets the search form to its initial state.
    Click Element    ${SEL_BTN_SEARCH_RESET}
    Wait Until Element Is Visible    ${SEL_PAGE_TITLE_SEARCH}    timeout=${DEFAULT_TIMEOUT}
    Sleep    0.3s

Verify Has Results
    [Documentation]    Verifies that search results are displayed and contain at least one item.
    Page Should Contain Element    ${SEL_SEARCH_RESULTS}
    ${count}=    Get Element Count    ${SEL_SEARCH_RESULT_ITEM}
    Should Be True    ${count} > 0    msg=No search results displayed

Verify No Results
    [Documentation]    Verifies that no search results are displayed.
    Page Should Contain Element    ${SEL_SEARCH_NO_RESULTS}

Click First Result
    [Documentation]    Clicks on the first search result flight link.
    Wait Until Element Is Visible    ${SEL_SEARCH_FLIGHT_LINK}    timeout=${DEFAULT_TIMEOUT}
    ${link}=    Get WebElement    xpath=(//a[@data-testid='search-flight-link'])[1]
    ${href}=    Get Element Attribute    ${link}    href
    Go To    ${href}
    Wait Until Element Is Visible    ${SEL_FLIGHT_HEADER}    timeout=${DEFAULT_TIMEOUT}
