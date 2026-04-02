*** Settings ***
Documentation    Page Object for the flights list page.
Library          SeleniumLibrary
Resource        ../resources/common.resource


*** Variables ***
${FLIGHTS_URL}    http://127.0.0.1:8000/flights/
${BROWSER}        Chrome


*** Keywords ***
Open Flights Page
    [Documentation]    Opens the flights list page in a headless Chrome browser.
    ${options}=    Get Chrome Options
    Create WebDriver    Chrome    options=${options}
    Maximize Browser Window
    Go To    ${FLIGHTS_URL}

Verify Flights Page Loaded
    [Documentation]    Verifies that the flights page title is visible.
    Wait Until Element Is Visible    css:[id='page-title-flights']    timeout=10s

Verify Flights Data
    [Documentation]    Verifies that at least one flight link is displayed.
    Page Should Contain Element    css:[data-test='flight-details-link']
    ${count}=    Get Element Count    css:[data-test='flight-details-link']
    Should Be True    ${count} > 0    msg=Aucun vol affiché dans la liste

Verify Multiple Flights Displayed
    [Documentation]    Verifies that at least 3 flights are displayed on the page.
    ${count}=    Get Element Count    css:[data-test='flight-details-link']
    Should Be True    ${count} >= 3    msg=Moins de 3 vols affichés — page trop vide

Click Flight By Index
    [Documentation]    Clicks on a flight link by its position in the list.
    [Arguments]    ${index}
    Wait Until Element Is Visible    css:[data-test='flight-details-link']    timeout=10s
    Click Element    xpath=(//a[@data-test='flight-details-link'])[${index}]

Close Flights Session
    [Documentation]    Closes the browser session.
    Close Browser
