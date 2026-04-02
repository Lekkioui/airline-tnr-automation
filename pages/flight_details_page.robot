*** Settings ***
Library    SeleniumLibrary

*** Keywords ***
Click First Flight
    Wait Until Element Is Visible    css:[data-test='flight-details-link']    timeout=10s
    Click Element                    xpath=(//a[@data-test='flight-details-link'])[1]

Verify Flight Details Page
    Wait Until Element Is Visible    css:[id='flight-header']        timeout=10s
    Page Should Contain Element      css:[id='detail-origin']
    Page Should Contain Element      css:[id='detail-destination']
    Page Should Contain Element      css:[id='detail-duration']
    Page Should Contain Element      css:[data-testid='detail-status']
    Page Should Contain Element      css:[data-testid='detail-capacity']

Fill Passenger Form
    [Arguments]    ${first}    ${last}    ${email}    ${passport}    ${seat_class}=ECONOMY
    Input Text     css:[data-testid='input-first']      ${first}
    Input Text     css:[data-testid='input-last']       ${last}
    Input Text     css:[data-testid='input-email']      ${email}
    Input Text     css:[data-testid='input-passport']   ${passport}
    Select From List By Value    css:[data-testid='input-seat-class']    ${seat_class}

Open Add Passenger Modal
    Execute Javascript    document.getElementById('modal-add-passenger').classList.remove('open')
    Wait Until Element Is Visible      css:[data-testid='btn-open-add-passenger']    timeout=15s
    Scroll Element Into View           css:[data-testid='btn-open-add-passenger']
    Click Element                      css:[data-testid='btn-open-add-passenger']
    Wait Until Element Is Visible      css:[data-testid='modal-add-passenger']       timeout=15s

Submit Passenger Form
    Scroll Element Into View    css:[data-testid='btn-confirm-add-passenger']
    Click Element               css:[data-testid='btn-confirm-add-passenger']
    Wait Until Element Is Visible    css:[data-testid='passenger-list']    timeout=30s
    Execute Javascript    document.getElementById('modal-add-passenger').classList.remove('open')

Add New Passenger
    [Arguments]    ${first}    ${last}    ${email}    ${passport}    ${seat_class}=ECONOMY
    Open Add Passenger Modal
    Fill Passenger Form    ${first}    ${last}    ${email}    ${passport}    ${seat_class}
    Submit Passenger Form

Verify Passenger Added
    Page Should Contain Element    css:[data-testid='passenger-list']
    ${count}=    Get Element Count    css:[data-testid='passenger-item']
    Should Be True    ${count} > 0    msg=La liste des passagers est vide après booking

Verify Passenger In List
    [Arguments]    ${first}    ${last}
    Page Should Contain    ${first} ${last}

Verify Booking Error
    [Arguments]    ${expected_message}
    Wait Until Element Is Visible    css:[data-testid='booking-error']    timeout=10s
    Element Should Contain           css:[data-testid='booking-error']    ${expected_message}

Verify Modal Open
    Element Should Be Visible    css:[data-testid='modal-add-passenger']

Verify Modal Closed
    Element Should Not Be Visible    css:[data-testid='modal-add-passenger']

Remove First Passenger
    Wait Until Element Is Visible    css:[data-testid='btn-remove']    timeout=10s
    ${passenger_id}=    Get Element Attribute    css:[data-testid='btn-remove']    data-passenger-id
    Scroll Element Into View    css:[data-testid='btn-remove']
    Click Element               css:[data-testid='btn-remove']
    Wait Until Element Is Visible    css:[id='flight-header']    timeout=30s
    [Return]    ${passenger_id}

Get Passenger Count In List
    ${count}=    Get Element Count    css:[data-testid='passenger-item']
    [Return]    ${count}

Verify Flight Status
    [Arguments]    ${expected_status}
    ${status}=    Get Element Attribute    css:[data-testid='detail-status']    data-status
    Should Be Equal    ${status}    ${expected_status}

Verify Booking Disabled
    Page Should Contain Element      css:[data-testid='booking-disabled']
    Element Should Not Be Visible    css:[data-testid='btn-open-add-passenger']

Verify Seat Assigned
    [Arguments]    ${seat_class}
    ${prefix}=    Set Variable If
    ...    '${seat_class}' == 'FIRST'      F
    ...    '${seat_class}' == 'BUSINESS'   B
    ...    E
    ${seats}=     Get WebElements    css:[data-testid='passenger-seat']
    ${last_seat}=    Set Variable    ${seats}[-1]
    ${seat_text}=    Get Text        ${last_seat}
    Should Start With    ${seat_text}    ${prefix}
    ...    msg=Le siège '${seat_text}' ne commence pas par '${prefix}' pour la classe ${seat_class}