*** Settings ***
Documentation    Page Object for the booking flow — seat map, confirm, success.
Library          SeleniumLibrary
Resource         ../resources/common.resource


*** Keywords ***
Navigate To Flight Seat Map
    [Documentation]    Navigates to seat map for a given flight link.
    [Arguments]    ${flight_href}
    Go To    ${flight_href}
    Wait Until Element Is Visible    ${SEL_FLIGHT_HEADER}    timeout=${DEFAULT_TIMEOUT}
    ${bookable}=    Run Keyword And Return Status
    ...    Page Should Contain Element    ${SEL_BTN_BOOK_SEAT}
    IF    ${bookable}
        ${seat_map_link}=    Get WebElement    ${SEL_BTN_BOOK_SEAT}
        ${seat_map_href}=    Get Element Attribute    ${seat_map_link}    href
        Go To    ${seat_map_href}
        Wait Until Element Is Visible    ${SEL_PAGE_TITLE_SEAT_MAP}    timeout=${DEFAULT_TIMEOUT}
        ${has_economy}=    Run Keyword And Return Status
        ...    Page Should Contain Element
        ...    xpath=//a[contains(@data-testid,'seat-') and contains(@href,'ECONOMY')]
        RETURN    ${has_economy}
    END
    RETURN    ${False}

Refresh Flight Search Results
    [Documentation]    Refreshes the flight search results list.
    Go To    ${SEARCH_URL}?status=SCHEDULED
    Wait Until Element Is Visible    ${SEL_SEARCH_RESULTS}    timeout=${DEFAULT_TIMEOUT}
    Sleep    0.3s
    ${links}=    Get WebElements    xpath=//a[@data-testid='search-flight-link']
    RETURN    ${links}

Find And Open Economy Flight
    [Documentation]    Finds a SCHEDULED flight with available economy seats.
    Go To    ${SEARCH_URL}?status=SCHEDULED
    Wait Until Element Is Visible    ${SEL_SEARCH_RESULTS}    timeout=${DEFAULT_TIMEOUT}
    Sleep    0.5s
    ${links}=    Get WebElements    xpath=//a[@data-testid='search-flight-link']
    FOR    ${link}    IN    @{links}
        ${flight_href}=    Get Element Attribute    ${link}    href
        ${has_economy}=    Navigate To Flight Seat Map    ${flight_href}
        IF    ${has_economy}    RETURN
        ${links}=    Refresh Flight Search Results
    END
    Fail    Aucun vol SCHEDULED avec sieges Economy disponibles

Open Seat Map
    [Documentation]    Navigates to seat map of a SCHEDULED flight with available seats.
    Open Browser Headless
    Login As Admin
    Find And Open Economy Flight

Verify Seat Map Loaded
    [Documentation]    Verifies seat map displays all three classes.
    Page Should Contain Element    ${SEL_CABIN_FIRST}
    Page Should Contain Element    ${SEL_CABIN_BUSINESS}
    Page Should Contain Element    ${SEL_CABIN_ECONOMY}
    Page Should Contain Element    ${SEL_OCCUPANCY_INDICATOR}

Verify Prices Displayed
    [Documentation]    Verifies prices are shown for each class.
    Page Should Contain Element    ${SEL_PRICE_FIRST}
    Page Should Contain Element    ${SEL_PRICE_BUSINESS}
    Page Should Contain Element    ${SEL_PRICE_ECONOMY}
    ${price_text}=    Get Text    ${SEL_PRICE_ECONOMY}
    Should Contain    ${price_text}    $

Select Economy Seat
    [Documentation]    Clicks the first available Economy seat.
    ${current_url}=    Get Location
    ${seats}=    Get WebElements
    ...    xpath=//a[contains(@data-testid,'seat-') and contains(@href,'ECONOMY')]
    FOR    ${seat}    IN    @{seats}
        ${href}=    Get Element Attribute    ${seat}    href
        Go To    ${href}
        ${landed}=    Run Keyword And Return Status
        ...    Wait Until Element Is Visible    ${SEL_PAGE_TITLE_CONFIRM}    timeout=5s
        IF    ${landed}     RETURN
        Go To    ${current_url}
        Wait Until Element Is Visible    ${SEL_PAGE_TITLE_SEAT_MAP}    timeout=${DEFAULT_TIMEOUT}
        ${seats}=    Get WebElements
        ...    xpath=//a[contains(@data-testid,'seat-') and contains(@href,'ECONOMY')]
    END
    Fail    Aucun siège Economy disponible

Verify Confirm Page Loaded
    [Documentation]    Verifies the booking confirmation page is displayed.
    Wait Until Element Is Visible    ${SEL_PAGE_TITLE_CONFIRM}    timeout=${DEFAULT_TIMEOUT}
    Page Should Contain Element      ${SEL_CONFIRM_FORM}
    Page Should Contain Element      ${SEL_CONFIRM_PRICE}

Set Field Value Via JS
    [Documentation]    Sets the value of a field using JavaScript execution.
    [Arguments]    ${testid}    ${value}
    Execute Javascript
    ...    var el = document.querySelector('[data-testid="${testid}"]');
    ...    if(el){el.value = '${value}';
    ...    el.dispatchEvent(new Event('input',{bubbles:true}));
    ...    el.dispatchEvent(new Event('change',{bubbles:true}));}

Fill Booking Form
    [Documentation]    Fills the booking confirmation form with passenger details using JavaScript.
    [Arguments]    ${first}    ${last}    ${email}    ${passport}
    Wait Until Element Is Visible    ${SEL_INPUT_CONFIRM_FIRST}    timeout=${DEFAULT_TIMEOUT}
    Set Field Value Via JS    input-confirm-first      ${first}
    Set Field Value Via JS    input-confirm-last       ${last}
    Set Field Value Via JS    input-confirm-email      ${email}
    Set Field Value Via JS    input-confirm-passport   ${passport}
    # Vérification
    ${val}=    Get Value    ${SEL_INPUT_CONFIRM_FIRST}
    Should Be Equal    ${val}    ${first}

Get Booking Hidden Fields
    [Documentation]    Retrieves hidden form fields.
    ${seat_class}=    Get Element Attribute    css:[name='seat_class']    value
    ${selected_seat}=    Get Element Attribute    css:[name='selected_seat']    value
    ${price}=     Get Element Attribute    css:[name='price']    value
    RETURN    ${seat_class}    ${selected_seat}    ${price}

Collect Booking Form Data
    [Documentation]    Collects all booking form data needed for submission.
    ${csrf}=    Get Element Attribute    css:[name='csrfmiddlewaretoken']    value
    ${action}=    Get Element Attribute    css:[data-testid='booking-confirm-form']    action
    ${first}=     Get Value    ${SEL_INPUT_CONFIRM_FIRST}
    ${last}=      Get Value    ${SEL_INPUT_CONFIRM_LAST}
    ${email}=     Get Value    ${SEL_INPUT_CONFIRM_EMAIL}
    ${passport}=  Get Value    ${SEL_INPUT_CONFIRM_PASSPORT}
    ${seat_class}    ${selected_seat}    ${price}=    Get Booking Hidden Fields
    &{data}=    Create Dictionary    csrf=${csrf}    action=${action}    first=${first}
    ...    last=${last}    email=${email}    passport=${passport}    seat_class=${seat_class}
    ...    selected_seat=${selected_seat}    price=${price}
    RETURN    &{data}

Submit Booking
    [Documentation]    Submits the booking form via JS with CSRF token.
    &{data}=    Collect Booking Form Data
    Execute Javascript
    ...    var form = document.createElement('form');
    ...    form.method = 'POST';
    ...    form.action = '${data}[action]';
    ...    var fields = {csrfmiddlewaretoken:'${data}[csrf]', first:'${data}[first]', last:'${data}[last]',
    ...    email:'${data}[email]', passport_number:'${data}[passport]', seat_class:'${data}[seat_class]',
    ...    selected_seat:'${data}[selected_seat]', price:'${data}[price]'};
    ...    for(var k in fields){var i=document.createElement('input');i.name=k;i.value=fields[k];form.appendChild(i);}
    ...    document.body.appendChild(form);
    ...    form.submit();
    Wait Until Element Is Visible    ${SEL_PAGE_TITLE_SUCCESS}    timeout=${LONG_TIMEOUT}

Verify Booking Success
    [Documentation]    Verifies the booking success page.
    Wait Until Element Is Visible    ${SEL_PAGE_TITLE_SUCCESS}    timeout=${DEFAULT_TIMEOUT}
    Page Should Contain Element      ${SEL_BOOKING_REFERENCE}
    ${ref}=    Get Text    ${SEL_BOOKING_REFERENCE}
    Should Start With    ${ref}    BK-

Verify Boarding Pass Link
    [Documentation]    Verifies the boarding pass download link exists.
    Page Should Contain Element    ${SEL_BTN_DOWNLOAD_BP}

Cancel Booking
    [Documentation]    Cancels the booking from the success page.
    Execute Javascript    document.querySelector('[data-testid="booking-cancel-form"]').submit()
    Sleep    2s
    Wait Until Element Is Visible    ${SEL_FLIGHT_HEADER}    timeout=${LONG_TIMEOUT}

Generate Unique Username
    [Documentation]    Generates a unique username using the current epoch timestamp.
    ${timestamp}=    Get Time    epoch
    ${username}=     Set Variable    user_${timestamp}
    RETURN    ${username}

Generate Test Passenger Data
    [Documentation]    Generates unique passenger data for each test run.
    ${uuid}=         Evaluate    str(__import__('uuid').uuid4()).replace('-','')[:6].upper()
    ${letters}=      Evaluate    __import__('random').choice('ABCDEFGHJKLMNPQRSTUVWXYZ') +\
    ...              __import__('random').choice('ABCDEFGHJKLMNPQRSTUVWXYZ')
    ${digits}=       Evaluate    str(__import__('random').randint(100000, 999999))
    ${passport}=     Set Variable    ${letters}${digits}
    ${email}=        Set Variable    test_${uuid}@test.com
    ${first}=        Set Variable    Test${uuid}
    ${last}=         Set Variable    User${uuid}
    RETURN    ${first}    ${last}    ${email}    ${passport}
