*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${FLIGHTS_URL}    http://127.0.0.1:8000/flights/

*** Keywords ***
Open Flights Page
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
    Call Method    ${options}    add_argument    --headless
    Call Method    ${options}    add_argument    --no-sandbox
    Call Method    ${options}    add_argument    --disable-dev-shm-usage
    Call Method    ${options}    add_argument    --disable-gpu
    Create WebDriver    Chrome    options=${options}
    Go To    ${FLIGHTS_URL}
    Maximize Browser Window

Verify Flights Page Loaded
    Page Should Contain    Flights

Verify Flights Data
    Page Should Contain    New York City
    Page Should Contain    London

Close Browser Session
    Close Browser