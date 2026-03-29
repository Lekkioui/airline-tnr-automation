*** Settings ***
Resource    ../pages/flights_page.robot
Resource    ../pages/flight_details_page.robot
Resource    ../resources/common.robot
Test Setup    Reset Test Data

*** Test Cases ***
Add Passenger To Flight
    Open Flights Page
    Click First Flight
    flight_details_page.Verify Flight Details Page
    flight_details_page.Add Passenger
    flight_details_page.Verify Passenger Added
    Close Browser Session

Add Passenger Decreases List
    Open Flights Page
    Click First Flight
    ${before}=    flight_details_page.Get Passenger Count
    flight_details_page.Add Passenger
    ${after}=     flight_details_page.Get Passenger Count
    Should Be True    ${after} < ${before}
    Close Browser Session

Add Multiple Passengers
    Open Flights Page
    Click First Flight
    flight_details_page.Add Passenger
    flight_details_page.Add Passenger
    Page Should Contain    Passengers
    Close Browser Session

No Passenger Available
    Open Flights Page
    Click First Flight
    FOR    ${i}    IN RANGE    10
        Run Keyword And Ignore Error    flight_details_page.Add Passenger
    END
    Wait Until Keyword Succeeds    5s    500ms    Verify List Is Empty
    Close Browser Session

Invalid Flight Page
    Open Browser    http://127.0.0.1:8000/flights/999    chrome
    Wait Until Page Contains    DoesNotExist    timeout=5s
    Close Browser

*** Keywords ***
Verify List Is Empty
    ${count}=    flight_details_page.Get Passenger Count
    Should Be Equal As Integers    ${count}    0