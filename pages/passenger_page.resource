*** Settings ***
Documentation    Page Object for the passenger profile page.
Library          SeleniumLibrary


*** Keywords ***
Click First Passenger
    [Documentation]    Clicks on the first passenger name link in the passenger list.
    Wait Until Element Is Visible    css:[data-testid='passenger-name']    timeout=10s
    Click Element                    xpath=(//a[@data-testid='passenger-name'])[1]
    Wait Until Element Is Visible    css:[data-testid='passenger-header']  timeout=10s

Verify Passenger Profile Page
    [Documentation]    Verifies that all passenger profile fields are visible.
    Wait Until Element Is Visible    css:[data-testid='passenger-header']       timeout=10s
    Page Should Contain Element      css:[data-testid='passenger-detail-grid']
    Page Should Contain Element      css:[data-testid='detail-first']
    Page Should Contain Element      css:[data-testid='detail-last']
    Page Should Contain Element      css:[data-testid='detail-email']
    Page Should Contain Element      css:[data-testid='detail-passport']
    Page Should Contain Element      css:[data-testid='detail-seat-class']
    Page Should Contain Element      css:[data-testid='detail-seat-number']

Verify Passenger Name
    [Documentation]    Verifies the passenger full name displayed in the header.
    [Arguments]    ${first}    ${last}
    Element Should Contain    css:[data-testid='passenger-header']    ${first}
    Element Should Contain    css:[data-testid='passenger-header']    ${last}

Verify Passenger Has Flights
    [Documentation]    Verifies that the passenger has at least one flight listed.
    Page Should Contain Element    css:[data-testid='passenger-flights-list']
    ${count}=    Get Element Count    css:[data-testid='passenger-flight-item']
    Should Be True    ${count} > 0    msg=Passenger has no flights listed

Verify Passenger Has No Flights
    [Documentation]    Verifies that the passenger has no flights booked.
    Page Should Contain Element    css:[data-testid='no-flights']

Get Passenger Flight Count
    [Documentation]    Returns the number of flights listed for the passenger.
    ${count}=    Get Element Count    css:[data-testid='passenger-flight-item']
    RETURN    ${count}

Remove First Flight From Passenger
    [Documentation]    Removes the first flight from the passenger profile.
    Wait Until Element Is Visible    css:[data-testid='btn-remove-flight']    timeout=10s
    Scroll Element Into View         css:[data-testid='btn-remove-flight']
    Click Element                    css:[data-testid='btn-remove-flight']
    Wait Until Element Is Visible    css:[data-testid='passenger-header']    timeout=10s

Verify Passenger Email
    [Documentation]    Verifies the passenger email displayed in the profile.
    [Arguments]    ${email}
    Element Should Contain    css:[data-testid='detail-email']    ${email}

Verify Passenger Passport
    [Documentation]    Verifies the passenger passport number displayed in the profile.
    [Arguments]    ${passport}
    Element Should Contain    css:[data-testid='detail-passport']    ${passport}

Verify Passenger Seat Class
    [Documentation]    Verifies the passenger seat class displayed in the profile.
    [Arguments]    ${seat_class}
    Element Should Contain    css:[data-testid='detail-seat-class']    ${seat_class}

Click First Flight In Profile
    [Documentation]    Clicks on the first flight link in the passenger profile.
    Wait Until Element Is Visible    css:[data-testid='passenger-flight-link']    timeout=10s
    Click Element                    xpath=(//a[@data-testid='passenger-flight-link'])[1]
    Wait Until Element Is Visible    css:[id='flight-header']    timeout=10s
