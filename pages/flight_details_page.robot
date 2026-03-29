*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${PASSENGER_NAME}    Hermione Granger

*** Keywords ***
Click First Flight
    Wait Until Element Is Visible    xpath:(//a[contains(@href, '/flights/')])[1]
    Click Element    xpath:(//a[contains(@href, '/flights/')])[1]

Verify Flight Details Page
    Wait Until Page Contains    Origin
    Page Should Contain    Destination

Add Passenger
    Wait Until Element Is Visible    name:passenger
    ${count}=    Get Passenger Count
    Run Keyword If    ${count} == 0    Fail    No passengers available for booking
    Select From List By Index    name:passenger    0
    Click Button    xpath://input[@type='submit']
    Wait Until Page Contains    Passengers    timeout=5s

Verify Passenger Added
    Page Should Contain    Passengers

Get Passenger Count
    ${count}=    Get Element Count    xpath://select[@name='passenger']/option
    [Return]    ${count}
    