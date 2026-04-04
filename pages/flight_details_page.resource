*** Settings ***
Documentation    Page Object for the flight details and passenger management page.
Library          SeleniumLibrary
Resource         ../resources/common.resource


*** Keywords ***
Click First Flight
    [Documentation]    Clicks on the first flight link in the flights list.
    Wait Until Element Is Visible    ${SEL_FLIGHT_LINK}    timeout=${DEFAULT_TIMEOUT}
    Click Element                    xpath=(//a[@data-test='flight-details-link'])[1]

Verify Flight Details Page
    [Documentation]    Verifies that all flight detail fields are visible.
    Wait Until Element Is Visible    ${SEL_FLIGHT_HEADER}       timeout=${DEFAULT_TIMEOUT}
    Page Should Contain Element      ${SEL_DETAIL_ORIGIN}
    Page Should Contain Element      ${SEL_DETAIL_DESTINATION}
    Page Should Contain Element      ${SEL_DETAIL_DURATION}
    Page Should Contain Element      ${SEL_DETAIL_STATUS}
    Page Should Contain Element      ${SEL_DETAIL_CAPACITY}

Fill Passenger Form
    [Documentation]    Fills in the add passenger modal form fields.
    [Arguments]    ${first}    ${last}    ${email}    ${passport}    ${seat_class}=ECONOMY
    Input Text    ${SEL_INPUT_FIRST}       ${first}
    Input Text    ${SEL_INPUT_LAST}        ${last}
    Input Text    ${SEL_INPUT_EMAIL}       ${email}
    Input Text    ${SEL_INPUT_PASSPORT}    ${passport}
    Select From List By Value    ${SEL_INPUT_SEAT_CLASS}    ${seat_class}

Open Add Passenger Modal
    [Documentation]    Opens the add passenger modal and waits for it to be visible.
    Execute Javascript    document.getElementById('modal-add-passenger').classList.remove('open')
    Wait Until Element Is Visible    ${SEL_BTN_OPEN_MODAL}    timeout=${LONG_TIMEOUT}
    Scroll Element Into View         ${SEL_BTN_OPEN_MODAL}
    Click Element                    ${SEL_BTN_OPEN_MODAL}
    Wait Until Element Is Visible    ${SEL_MODAL}             timeout=${LONG_TIMEOUT}

Submit Passenger Form
    [Documentation]    Submits the passenger form and waits for the passenger list to update.
    Scroll Element Into View    ${SEL_BTN_CONFIRM}
    Click Element               ${SEL_BTN_CONFIRM}
    Wait Until Element Is Visible    ${SEL_PASSENGER_LIST}    timeout=${LONG_TIMEOUT}
    Execute Javascript    document.getElementById('modal-add-passenger').classList.remove('open')

Add New Passenger
    [Documentation]    Opens the modal, fills the form and submits it.
    [Arguments]    ${first}    ${last}    ${email}    ${passport}    ${seat_class}=ECONOMY
    Open Add Passenger Modal
    Fill Passenger Form    ${first}    ${last}    ${email}    ${passport}    ${seat_class}
    Submit Passenger Form

Verify Passenger Added
    [Documentation]    Verifies that at least one passenger appears in the passenger list.
    Page Should Contain Element    ${SEL_PASSENGER_LIST}
    ${count}=    Get Element Count    ${SEL_PASSENGER_ITEM}
    Should Be True    ${count} > 0    msg=La liste des passagers est vide après booking

Verify Passenger In List
    [Documentation]    Verifies that a specific passenger name appears in the list.
    [Arguments]    ${first}    ${last}
    Page Should Contain    ${first} ${last}

Verify Booking Error
    [Documentation]    Verifies that a booking error message is displayed.
    [Arguments]    ${expected_message}
    Wait Until Element Is Visible    ${SEL_BOOKING_ERROR}    timeout=${DEFAULT_TIMEOUT}
    Element Should Contain           ${SEL_BOOKING_ERROR}    ${expected_message}

Verify Modal Open
    [Documentation]    Verifies that the add passenger modal is visible.
    Element Should Be Visible    ${SEL_MODAL}

Verify Modal Closed
    [Documentation]    Verifies that the add passenger modal is not visible.
    Element Should Not Be Visible    ${SEL_MODAL}

Remove First Passenger
    [Documentation]    Removes the first passenger in the list and returns their ID.
    Wait Until Element Is Visible    ${SEL_BTN_REMOVE}    timeout=${DEFAULT_TIMEOUT}
    ${passenger_id}=    Get Element Attribute    ${SEL_BTN_REMOVE}    data-passenger-id
    Scroll Element Into View    ${SEL_BTN_REMOVE}
    Click Element               ${SEL_BTN_REMOVE}
    Wait Until Element Is Visible    ${SEL_FLIGHT_HEADER}    timeout=${LONG_TIMEOUT}
    RETURN    ${passenger_id}

Get Passenger Count In List
    [Documentation]    Returns the number of passengers currently displayed in the list.
    ${count}=    Get Element Count    ${SEL_PASSENGER_ITEM}
    RETURN    ${count}

Verify Flight Status
    [Documentation]    Verifies that the flight status matches the expected value.
    [Arguments]    ${expected_status}
    ${status}=    Get Element Attribute    ${SEL_DETAIL_STATUS}    data-status
    Should Be Equal    ${status}    ${expected_status}

Verify Booking Disabled
    [Documentation]    Verifies that booking is disabled and the add passenger button is hidden.
    Page Should Contain Element      ${SEL_BOOKING_DISABLED}
    Element Should Not Be Visible    ${SEL_BTN_OPEN_MODAL}

Verify Seat Assigned
    [Documentation]    Verifies that the last added passenger has a seat matching their class prefix.
    [Arguments]    ${seat_class}
    ${prefix}=    Set Variable If
    ...    '${seat_class}' == 'FIRST'      F
    ...    '${seat_class}' == 'BUSINESS'   B
    ...    E
    ${seats}=       Get WebElements    ${SEL_PASSENGER_SEAT}
    ${last_seat}=   Set Variable       ${seats}[-1]
    ${seat_text}=   Get Text           ${last_seat}
    Should Start With    ${seat_text}    ${prefix}
    ...    msg=Le siège '${seat_text}' ne commence pas par '${prefix}' pour la classe ${seat_class}
