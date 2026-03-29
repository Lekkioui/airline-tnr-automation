*** Settings ***
Resource    ../pages/flights_page.robot

*** Test Cases ***
Check Flights Page
    Open Flights Page
    Verify Flights Page Loaded
    Verify Flights Data
    Close Browser Session

Open Flight Details Test
    Open Flights Page
    Open First Flight Details
    Verify Flight Details Page
    Close Browser Session