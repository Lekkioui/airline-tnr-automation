*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${PASSENGER_NAME}    Hermione Granger

*** Keywords ***
Click First Flight
    Click Link    xpath://a[contains(@href, '/flights/')]

Verify Flight Details Page
    Page Should Contain    Origin
    Page Should Contain    Destination

Add Passenger
    Wait Until Element Is Visible    name:passenger
    ${count}=    Get Element Count    xpath://select[@name='passenger']/option
    Should Be True    ${count} > 0
    Select From List By Index    name:passenger    0
    Click Button    xpath://input[@type='submit']

Verify Passenger Added
    Page Should Contain    ${PASSENGER_NAME}