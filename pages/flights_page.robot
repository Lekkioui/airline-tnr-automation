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

Open First Flight Details
    Click Link    xpath=//a[contains(@href,'/flights/')]

Verify Flight Details From List
    Wait Until Page Contains    Origin    timeout=10s
    Page Should Contain    Destination

Get Passenger Count
    ${count}=    Get Element Count    xpath://select[@name='passenger']/option
    [Return]    ${count}

Select First Passenger
    Select From List By Index    name:passenger    0

Add Passenger
    Wait Until Element Is Visible    name:passenger
    ${count}=    Get Passenger Count
    Should Be True    ${count} > 0
    Select First Passenger
    Click Button    xpath://input[@type='submit']

Close Browser Session
    Close Browser