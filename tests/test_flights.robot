*** Settings ***
Resource    ../pages/flights_page.robot

*** Test Cases ***
Check Flights Page
    Open Flights Page
    Verify Flights Page Loaded
    Verify Flights Data
    Close Browser Session