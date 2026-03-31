*** Settings ***
Library    SeleniumLibrary

*** Keywords ***
Click First Flight
    Wait Until Element Is Visible    css:[data-test='flight-details-link']    timeout=10s
    Click Element                    xpath=(//a[@data-test='flight-details-link'])[1]

Verify Flight Details Page
    Wait Until Element Is Visible    css:[id='flight-header']             timeout=10s
    Page Should Contain Element      css:[id='detail-origin']
    Page Should Contain Element      css:[id='detail-destination']
    Page Should Contain Element      css:[id='detail-duration']

Add Passenger
    Wait Until Element Is Visible    css:[id='passenger-select']          timeout=10s
    ${count}=    Get Passenger Count
    Run Keyword If    ${count} == 0    Fail    No passengers available for booking
    Select From List By Index         css:[id='passenger-select']    0
    Click Element                     css:[id='btn-book-submit']
    Wait Until Element Is Visible     css:[data-testid='passenger-list']  timeout=10s

Verify Passenger Added
    Page Should Contain Element    css:[data-testid='passenger-list']
    ${count}=    Get Element Count    css:[data-testid='passenger-item']
    Should Be True    ${count} > 0    msg=La liste des passagers est vide après booking

Get Passenger Count
    ${count}=    Get Element Count    css:[data-testid='passenger-option']
    [Return]    ${count}

Verify No Passengers Available
    ${count}=    Get Passenger Count
    Should Be Equal As Integers    ${count}    0
