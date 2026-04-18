*** Settings ***
Documentation    Page Object for the passenger profile page.
Library          SeleniumLibrary
Resource         ../resources/common.resource


*** Keywords ***
Open Flight With Passengers
    [Documentation]    Opens a SCHEDULED flight that has passengers.
    Open Browser Headless
    Login As Admin
    Go To    ${SEARCH_URL}?status=SCHEDULED
    Wait Until Element Is Visible    ${SEL_SEARCH_RESULTS}    timeout=${DEFAULT_TIMEOUT}
    Find Flight With Passengers

Find Flight With Passengers
    [Documentation]    Searches for a SCHEDULED flight with passengers.
    Sleep    0.5s
    ${links}=    Get WebElements    xpath=//a[@data-testid='search-flight-link']
    FOR    ${link}    IN    @{links}
        ${has_passengers}=    Check Flight For Passengers    ${link}
        IF    ${has_passengers}    RETURN
        Go To    ${SEARCH_URL}?status=SCHEDULED
        Wait Until Element Is Visible    ${SEL_SEARCH_RESULTS}    timeout=${DEFAULT_TIMEOUT}
        Sleep    0.3s
        ${links}=    Get WebElements    xpath=//a[@data-testid='search-flight-link']
    END
    Fail    Aucun vol SCHEDULED avec passagers trouve

Check Flight For Passengers
    [Documentation]    Checks if a flight has passengers and navigates to it.
    [Arguments]    ${link}
    ${href}=    Get Element Attribute    ${link}    href
    Go To    ${href}
    Wait Until Element Is Visible    ${SEL_FLIGHT_HEADER}    timeout=${DEFAULT_TIMEOUT}
    ${has_passengers}=    Run Keyword And Return Status
    ...    Page Should Contain Element    ${SEL_PASSENGER_LIST}
    RETURN    ${has_passengers}

Click First Passenger
    [Documentation]    Clicks the first passenger name link in the list.
    Wait Until Element Is Visible    ${SEL_PASSENGER_NAME}    timeout=${DEFAULT_TIMEOUT}
    # S'assurer que l'élément est bien cliquable
    Wait Until Keyword Succeeds    3x    1s    Element Should Be Visible
    ...    xpath=(//a[@data-testid='passenger-name'])[1]
    ${link}=    Get WebElement    xpath=(//a[@data-testid='passenger-name'])[1]
    ${href}=    Get Element Attribute    ${link}    href
    Go To    ${href}
    Wait Until Element Is Visible    ${SEL_PASSENGER_HEADER}    timeout=${DEFAULT_TIMEOUT}

Verify Passenger Profile Loaded
    [Documentation]    Verifies the passenger profile page is displayed.
    Wait Until Element Is Visible    ${SEL_PASSENGER_HEADER}    timeout=${DEFAULT_TIMEOUT}
    Page Should Contain Element      ${SEL_DETAIL_EMAIL}
    Page Should Contain Element      ${SEL_DETAIL_PASSPORT}
    Page Should Contain Element      ${SEL_DETAIL_SEAT_CLASS}
    Page Should Contain Element      ${SEL_DETAIL_SEAT_NUMBER}

Verify Passenger Has Flights
    [Documentation]    Verifies that the passenger has at least one flight listed.
    # Attendre que le conteneur soit visible
    Wait Until Element Is Visible    ${SEL_PASSENGER_FLIGHTS}    timeout=${DEFAULT_TIMEOUT}
    # Forcer une petite attente pour laisser le JavaScript finir le rendu de la liste
    Sleep    0.5s
    Page Should Contain Element    ${SEL_PASSENGER_FLIGHTS}
    ${count}=    Get Element Count    css:[data-testid='passenger-flight-item']
    Should Be True    ${count} > 0    msg=No flights listed for passenger

Verify Passenger Has No Flights
    [Documentation]    Verifies that the passenger has no flights listed.
    Page Should Contain Element    ${SEL_NO_FLIGHTS}

Verify Passenger Email Contains
    [Documentation]    Verifies passenger email contains expected text.
    [Arguments]    ${expected_text}
    ${email}=    Get Text    ${SEL_DETAIL_EMAIL}
    Should Contain    ${email}    ${expected_text}
    ...    msg=Email '${email}' does not contain '${expected_text}'

Verify Passenger Passport Contains
    [Documentation]    Verifies passenger passport contains expected text.
    [Arguments]    ${expected_text}
    ${passport}=    Get Text    ${SEL_DETAIL_PASSPORT}
    Should Contain    ${passport}    ${expected_text}
    ...    msg=Passport '${passport}' does not contain '${expected_text}'

Verify Passenger Seat Class
    [Documentation]    Vérifie la classe de siège avec une logique de réessai en cas de DOM instable.
    # On attend d'abord que l'élément soit là
    Wait Until Element Is Visible    ${SEL_DETAIL_SEAT_CLASS}    timeout=${DEFAULT_TIMEOUT}
    # On utilise Wait Until Keyword Succeeds pour contrer le StaleElementReferenceException
    # Si l'élément devient "stale", Robot Framework réessaiera 3 fois.
    ${seat_class}=    Wait Until Keyword Succeeds    3x    1s    Get Passenger Seat Text
    Should Match Regexp    ${seat_class}    ^(ECONOMY|BUSINESS|FIRST)$
    ...    msg=La classe de siège '${seat_class}' n'est pas valide

Get Passenger Seat Text
    [Documentation]    Mot-clé interne pour isoler l'extraction du texte.
    ${text}=    Get Text    ${SEL_DETAIL_SEAT_CLASS}
    RETURN    ${text}

Get Passenger Flight Count
    [Documentation]    Returns the number of flights listed for the passenger.
    ${count}=    Get Element Count    css:[data-testid='passenger-flight-item']
    RETURN    ${count}

Remove First Flight From Passenger
    [Documentation]    Removes the first flight from the passenger profile.
    Wait Until Element Is Visible    ${SEL_BTN_REMOVE_FLIGHT}    timeout=${DEFAULT_TIMEOUT}
    Sleep    0.5s
    Execute Javascript
    ...    var form = document.querySelector('[data-testid="btn-remove-flight"]').closest('form');
    ...    form.submit();
    Sleep    1s
    Wait Until Element Is Visible    ${SEL_PASSENGER_HEADER}    timeout=${DEFAULT_TIMEOUT}

Add Passenger To Flight
    [Documentation]    Adds a new passenger via the modal on flight detail page.
    [Arguments]    ${first}    ${last}    ${email}    ${passport}
    Wait Until Element Is Visible    ${SEL_BTN_OPEN_MODAL}    timeout=${DEFAULT_TIMEOUT}
    Execute Javascript    document.getElementById('modal-add-passenger').classList.remove('open')
    Click Element    ${SEL_BTN_OPEN_MODAL}
    Wait Until Element Is Visible    ${SEL_MODAL}    timeout=${DEFAULT_TIMEOUT}
    Input Text    ${SEL_INPUT_FIRST}      ${first}
    Input Text    ${SEL_INPUT_LAST}       ${last}
    Input Text    ${SEL_INPUT_EMAIL}      ${email}
    Input Text    ${SEL_INPUT_PASSPORT}   ${passport}
    Execute Javascript    document.getElementById('add-passenger-form').submit()
    Wait Until Element Is Visible    ${SEL_PASSENGER_LIST}    timeout=${LONG_TIMEOUT}
