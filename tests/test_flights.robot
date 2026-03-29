*** Settings ***
Resource    ../pages/flights_page.robot
Resource    ../resources/common.robot
Test Setup    Reset Test Data

*** Test Cases ***
Check Flights Page
    Open Flights Page
    Verify Flights Page Loaded
    Verify Flights Data
    Close Browser Session

Open Flight Details Test
    Open Flights Page
    Open First Flight Details
    Verify Flight Details From List
    Close Browser Session