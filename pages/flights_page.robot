*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${FLIGHTS_URL}    http://127.0.0.1:8000/flights/

*** Keywords ***
Open Flights Page
    Open Browser    ${FLIGHTS_URL}    chrome
    Maximize Browser Window

Verify Flights Page Loaded
    Page Should Contain    Flights

Verify Flights Data
    Page Should Contain    New York City
    Page Should Contain    London

Close Browser Session
    Close Browser