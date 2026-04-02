*** Settings ***
Library     SeleniumLibrary

*** Variables ***
${FLIGHTS_URL}    http://127.0.0.1:8000/flights/
${BROWSER}        Chrome

*** Keywords ***
Open Flights Page
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
    Call Method    ${options}    add_argument    --headless
    Call Method    ${options}    add_argument    --no-sandbox
    Call Method    ${options}    add_argument    --disable-dev-shm-usage
    Call Method    ${options}    add_argument    --disable-gpu
    Create WebDriver    Chrome    options=${options}
    Maximize Browser Window
    Go To    ${FLIGHTS_URL}

Verify Flights Page Loaded
    Wait Until Element Is Visible    css:[id='page-title-flights']    timeout=10s

Verify Flights Data
    Page Should Contain Element    css:[data-test='flight-details-link']
    ${count}=    Get Element Count    css:[data-test='flight-details-link']
    Should Be True    ${count} > 0    msg=Aucun vol affiché dans la liste

Verify Multiple Flights Displayed
    ${count}=    Get Element Count    css:[data-test='flight-details-link']
    Should Be True    ${count} >= 3    msg=Moins de 3 vols affichés — page trop vide

Click Flight By Index
    [Arguments]    ${index}
    Wait Until Element Is Visible    css:[data-test='flight-details-link']    timeout=10s
    Click Element    xpath=(//a[@data-test='flight-details-link'])[${index}]

Close Flights Session
    Close Browser