*** Settings ***
Documentation       Page Object for the flight detail page.
Library             SeleniumLibrary
Resource            ../resources/common.resource


*** Keywords ***
Open Flight Detail By Status
    [Documentation]    Opens browser, logs in, filters by status and clicks first result.
    [Arguments]    ${status}
    Open Browser Headless
    Login As Admin
    Go To    ${SEARCH_URL}?status=${status}
    Wait Until Element Is Visible    ${SEL_SEARCH_RESULTS}    timeout=${DEFAULT_TIMEOUT}
    Sleep    0.5s
    ${link}=    Get WebElement    xpath=(//a[@data-testid='search-flight-link'])[1]
    ${href}=    Get Element Attribute    ${link}    href
    Go To    ${href}
    Wait Until Element Is Visible    ${SEL_FLIGHT_HEADER}    timeout=${DEFAULT_TIMEOUT}

Verify Flight Detail Loaded
    [Documentation]    Verifies all flight detail fields are visible.
    Wait Until Element Is Visible    ${SEL_FLIGHT_HEADER}    timeout=${DEFAULT_TIMEOUT}
    Page Should Contain Element      ${SEL_DETAIL_ORIGIN}
    Page Should Contain Element      ${SEL_DETAIL_DESTINATION}
    Page Should Contain Element      ${SEL_DETAIL_DURATION}
    Page Should Contain Element      ${SEL_DETAIL_STATUS}
    Page Should Contain Element      ${SEL_DETAIL_CAPACITY}

Verify Flight Status Is
    [Documentation]    Verifies the flight status matches expected value.
    [Arguments]    ${expected_status}
    Wait Until Element Is Visible    ${SEL_DETAIL_STATUS}    timeout=${DEFAULT_TIMEOUT}
    ${status}=    Get Element Attribute    ${SEL_DETAIL_STATUS}    data-status
    Should Be Equal    ${status}    ${expected_status}
    ...    msg=Expected status '${expected_status}' but got '${status}'

Verify Status Form Visible
    [Documentation]    Verifies the status update form is visible.
    Page Should Contain Element    ${SEL_STATUS_FORM}
    Page Should Contain Element    ${SEL_STATUS_SELECT}
    Page Should Contain Element    ${SEL_BTN_UPDATE_STATUS}

Verify No Status Transitions
    [Documentation]    Verifies no further transitions are available.
    Page Should Contain Element        ${SEL_NO_STATUS_TRANSITION}
    Page Should Not Contain Element    ${SEL_STATUS_FORM}

Verify Booking Disabled
    [Documentation]    Verifies that booking is disabled on this flight.
    Page Should Contain Element        ${SEL_BOOKING_DISABLED}
    Page Should Not Contain Element    ${SEL_BTN_BOOK_SEAT}

Verify Booking Enabled
    [Documentation]    Verifies that the Book a Seat button is visible.
    Page Should Contain Element    ${SEL_BTN_BOOK_SEAT}

Update Status To
    [Documentation]    Selects and submits a new flight status.
    [Arguments]    ${new_status}
    Wait Until Element Is Visible    ${SEL_STATUS_SELECT}    timeout=${DEFAULT_TIMEOUT}
    Wait Until Element Is Enabled    ${SEL_STATUS_SELECT}    timeout=${DEFAULT_TIMEOUT}
    Select From List By Value        ${SEL_STATUS_SELECT}    ${new_status}
    Execute Javascript    document.getElementById('status-form').submit()
    Wait Until Element Is Visible    ${SEL_FLIGHT_HEADER}    timeout=${LONG_TIMEOUT}
    Sleep    1s

Verify Passenger Count
    [Documentation]    Verifies that passenger count element is displayed.
    Page Should Contain Element    ${SEL_PASSENGER_COUNT}
