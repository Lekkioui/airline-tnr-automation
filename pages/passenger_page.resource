*** Settings ***
Documentation    Page Object for the passenger profile page.
Library          SeleniumLibrary
Resource         ../resources/common.resource


*** Keywords ***
Click First Passenger
    [Documentation]    Clicks on the first passenger name link in the passenger list.
    Wait Until Element Is Visible    ${SEL_PASSENGER_NAME}      timeout=${DEFAULT_TIMEOUT}
    Click Element                    xpath=(//a[@data-testid='passenger-name'])[1]
    Wait Until Element Is Visible    ${SEL_PASSENGER_HEADER}    timeout=${DEFAULT_TIMEOUT}

Verify Passenger Profile Page
    [Documentation]    Verifies that all passenger profile fields are visible.
    Wait Until Element Is Visible    ${SEL_PASSENGER_HEADER}        timeout=${DEFAULT_TIMEOUT}
    Page Should Contain Element      ${SEL_PASSENGER_DETAIL_GRID}
    Page Should Contain Element      ${SEL_DETAIL_FIRST}
    Page Should Contain Element      ${SEL_DETAIL_LAST}
    Page Should Contain Element      ${SEL_DETAIL_EMAIL}
    Page Should Contain Element      ${SEL_DETAIL_PASSPORT}
    Page Should Contain Element      ${SEL_DETAIL_SEAT_CLASS}
    Page Should Contain Element      ${SEL_DETAIL_SEAT_NUMBER}

Verify Passenger Name
    [Documentation]    Verifies the passenger full name displayed in the header.
    [Arguments]    ${first}    ${last}
    Element Should Contain    ${SEL_PASSENGER_HEADER}    ${first}
    Element Should Contain    ${SEL_PASSENGER_HEADER}    ${last}

Verify Passenger Has Flights
    [Documentation]    Verifies that the passenger has at least one flight listed.
    Page Should Contain Element    ${SEL_PASSENGER_FLIGHTS_LIST}
    ${count}=    Get Element Count    ${SEL_PASSENGER_FLIGHT_ITEM}
    Should Be True    ${count} > 0    msg=Passenger has no flights listed

Verify Passenger Has No Flights
    [Documentation]    Verifies that the passenger has no flights booked.
    Page Should Contain Element    ${SEL_NO_FLIGHTS}

Get Passenger Flight Count
    [Documentation]    Returns the number of flights listed for the passenger.
    ${count}=    Get Element Count    ${SEL_PASSENGER_FLIGHT_ITEM}
    RETURN    ${count}

Remove First Flight From Passenger
    [Documentation]    Removes the first flight from the passenger profile.
    Wait Until Element Is Visible    ${SEL_BTN_REMOVE_FLIGHT}    timeout=${DEFAULT_TIMEOUT}
    Scroll Element Into View         ${SEL_BTN_REMOVE_FLIGHT}
    Click Element                    ${SEL_BTN_REMOVE_FLIGHT}
    Wait Until Element Is Visible    ${SEL_PASSENGER_HEADER}     timeout=${DEFAULT_TIMEOUT}

Verify Passenger Email
    [Documentation]    Verifies the passenger email displayed in the profile.
    [Arguments]    ${email}
    Element Should Contain    ${SEL_DETAIL_EMAIL}    ${email}

Verify Passenger Passport
    [Documentation]    Verifies the passenger passport number displayed in the profile.
    [Arguments]    ${passport}
    Element Should Contain    ${SEL_DETAIL_PASSPORT}    ${passport}

Verify Passenger Seat Class
    [Documentation]    Verifies the passenger seat class displayed in the profile.
    [Arguments]    ${seat_class}
    Element Should Contain    ${SEL_DETAIL_SEAT_CLASS}    ${seat_class}

Click First Flight In Profile
    [Documentation]    Clicks on the first flight link in the passenger profile.
    Wait Until Element Is Visible    ${SEL_PASSENGER_FLIGHT_LINK}    timeout=${DEFAULT_TIMEOUT}
    Click Element                    xpath=(//a[@data-testid='passenger-flight-link'])[1]
    Wait Until Element Is Visible    ${SEL_FLIGHT_HEADER}            timeout=${DEFAULT_TIMEOUT}
