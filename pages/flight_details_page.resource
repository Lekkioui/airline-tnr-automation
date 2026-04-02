*** Settings ***
Documentation    Page Object for the flight details and passenger management page.
Library          SeleniumLibrary


*** Keywords ***
Click First Flight
    [Documentation]    Clicks on the first flight link in the flights list.
    Wait Until Element Is Visible    css:[data-test='flight-details-link']    timeout=10s
    Click Element                    xpath=(//a[@data-test='flight-details-link'])[1]

Verify Flight Details Page
    [Documentation]    Verifies that all flight detail fields are visible.
    Wait Until Element Is Visible    css:[id='flight-header']    timeout=10s
    Page Should Contain Element      css:[id='detail-origin']
    Page Should Contain Element      css:[id='detail-destination']
    Page Should Contain Element      css:[id='detail-duration']
    Page Should Contain Element      css:[data-testid='detail-status']
    Page Should Contain Element      css:[data-testid='detail-capacity']

Fill Passenger Form
    [Documentation]    Fills in the add passenger modal form fields.
    [Arguments]    ${first}    ${last}    ${email}    ${passport}    ${seat_class}=ECONOMY
    Input Text    css:[data-testid='input-first']      ${first}
    Input Text    css:[data-testid='input-last']       ${last}
    Input Text    css:[data-testid='input-email']      ${email}
    Input Text    css:[data-testid='input-passport']   ${passport}
    Select From List By Value    css:[data-testid='input-seat-class']    ${seat_class}

Open Add Passenger Modal
    [Documentation]    Opens the add passenger modal and waits for it to be visible.
    Execute Javascript    document.getElementById('modal-add-passenger').classList.remove('open')
    Wait Until Element Is Visible    css:[data-testid='btn-open-add-passenger']    timeout=15s
    Scroll Element Into View         css:[data-testid='btn-open-add-passenger']
    Click Element                    css:[data-testid='btn-open-add-passenger']
    Wait Until Element Is Visible    css:[data-testid='modal-add-passenger']       timeout=15s

Submit Passenger Form
    [Documentation]    Submits the passenger form and waits for the passenger list to update.
    Scroll Element Into View    css:[data-testid='btn-confirm-add-passenger']
    Click Element               css:[data-testid='btn-confirm-add-passenger']
    Wait Until Element Is Visible    css:[data-testid='passenger-list']    timeout=30s
    Execute Javascript    document.getElementById('modal-add-passenger').classList.remove('open')

Add New Passenger
    [Documentation]    Opens the modal, fills the form and submits it.
    [Arguments]    ${first}    ${last}    ${email}    ${passport}    ${seat_class}=ECONOMY
    Open Add Passenger Modal
    Fill Passenger Form    ${first}    ${last}    ${email}    ${passport}    ${seat_class}
    Submit Passenger Form

Verify Passenger Added
    [Documentation]    Verifies that at least one passenger appears in the passenger list.
    Page Should Contain Element    css:[data-testid='passenger-list']
    ${count}=    Get Element Count    css:[data-testid='passenger-item']
    Should Be True    ${count} > 0    msg=La liste des passagers est vide après booking

Verify Passenger In List
    [Documentation]    Verifies that a specific passenger name appears in the list.
    [Arguments]    ${first}    ${last}
    Page Should Contain    ${first} ${last}

Verify Booking Error
    [Documentation]    Verifies that a booking error message is displayed.
    [Arguments]    ${expected_message}
    Wait Until Element Is Visible    css:[data-testid='booking-error']    timeout=10s
    Element Should Contain           css:[data-testid='booking-error']    ${expected_message}

Verify Modal Open
    [Documentation]    Verifies that the add passenger modal is visible.
    Element Should Be Visible    css:[data-testid='modal-add-passenger']

Verify Modal Closed
    [Documentation]    Verifies that the add passenger modal is not visible.
    Element Should Not Be Visible    css:[data-testid='modal-add-passenger']

Remove First Passenger
    [Documentation]    Removes the first passenger in the list and returns their ID.
    Wait Until Element Is Visible    css:[data-testid='btn-remove']    timeout=10s
    ${passenger_id}=    Get Element Attribute    css:[data-testid='btn-remove']    data-passenger-id
    Scroll Element Into View    css:[data-testid='btn-remove']
    Click Element                css:[data-testid='btn-remove']
    Wait Until Element Is Visible    css:[id='flight-header']    timeout=30s
    RETURN    ${passenger_id}

Get Passenger Count In List
    [Documentation]    Returns the number of passengers currently displayed in the list.
    ${count}=    Get Element Count    css:[data-testid='passenger-item']
    RETURN    ${count}

Verify Flight Status
    [Documentation]    Verifies that the flight status matches the expected value.
    [Arguments]    ${expected_status}
    ${status}=    Get Element Attribute    css:[data-testid='detail-status']    data-status
    Should Be Equal    ${status}    ${expected_status}

Verify Booking Disabled
    [Documentation]    Verifies that booking is disabled and the add passenger button is hidden.
    Page Should Contain Element      css:[data-testid='booking-disabled']
    Element Should Not Be Visible    css:[data-testid='btn-open-add-passenger']

Verify Seat Assigned
    [Documentation]    Verifies that the last added passenger has a seat matching their class prefix.
    [Arguments]    ${seat_class}
    ${prefix}=    Set Variable If
    ...    '${seat_class}' == 'FIRST'      F
    ...    '${seat_class}' == 'BUSINESS'   B
    ...    E
    ${seats}=       Get WebElements    css:[data-testid='passenger-seat']
    ${last_seat}=   Set Variable       ${seats}[-1]
    ${seat_text}=   Get Text           ${last_seat}
    Should Start With    ${seat_text}    ${prefix}
    ...    msg=Le siège '${seat_text}' ne commence pas par '${prefix}' pour la classe ${seat_class}
