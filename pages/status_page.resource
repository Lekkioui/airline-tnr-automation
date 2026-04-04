*** Settings ***
Documentation    Page Object for flight status management.
Library          SeleniumLibrary
Resource         ../resources/common.resource


*** Keywords ***
Verify Status Form Visible
    [Documentation]    Verifies that the status update form is visible.
    Page Should Contain Element    ${SEL_STATUS_FORM}
    Page Should Contain Element    ${SEL_STATUS_SELECT}
    Page Should Contain Element    ${SEL_BTN_UPDATE_STATUS}

Verify No Status Transition Available
    [Documentation]    Verifies that no further status transitions are available.
    Page Should Contain Element    ${SEL_NO_STATUS_TRANSITION}

Get Current Status
    [Documentation]    Returns the current flight status.
    ${status}=    Get Element Attribute    ${SEL_DETAIL_STATUS}    data-status
    RETURN    ${status}

Select New Status
    [Documentation]    Selects a new status from the status dropdown.
    [Arguments]    ${status}
    Select From List By Value    ${SEL_STATUS_SELECT}    ${status}

Submit Status Update
    [Documentation]    Submits the status update form and waits for page reload.
    Click Element    ${SEL_BTN_UPDATE_STATUS}
    Wait Until Element Is Visible    ${SEL_FLIGHT_HEADER}    timeout=${DEFAULT_TIMEOUT}

Update Flight Status
    [Documentation]    Selects and submits a new flight status.
    [Arguments]    ${status}
    Verify Status Form Visible
    Select New Status    ${status}
    Submit Status Update

Verify Status Updated
    [Documentation]    Verifies that the flight status has been updated to the expected value.
    [Arguments]    ${expected_status}
    ${current}=    Get Current Status
    Should Be Equal    ${current}    ${expected_status}
    ...    msg=Expected status '${expected_status}' but got '${current}'

Verify Status Error
    [Documentation]    Verifies that a status error message is displayed.
    Page Should Contain Element    ${SEL_STATUS_ERROR}

Verify Booking Disabled After Status Change
    [Documentation]    Verifies that booking is disabled after a status change.
    Page Should Contain Element    ${SEL_BOOKING_DISABLED}
