*** Settings ***
Resource    ../pages/flights_page.robot
Resource    ../pages/flight_details_page.robot

*** Test Cases ***
Add Passenger To Flight
    Open Flights Page
    Click First Flight
    Verify Flight Details Page
    Add Passenger
    Verify Passenger Added
    Close Browser Session