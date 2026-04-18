*** Settings ***
Documentation       Test suite for the complete booking flow.
Library             String
Library             SeleniumLibrary
Resource            ../pages/booking_page.resource
Resource            ../resources/common.resource
Test Setup          Reset Test Data
Test Teardown       Run Keywords
...    Run Keyword If Test Failed    Capture Page Screenshot
...    AND    Close Session
Test Tags           booking


*** Test Cases ***
Seat Map Accessible From Scheduled Flight
    [Documentation]    Verifie que la seat map est accessible depuis un vol SCHEDULED.
    [Tags]    seat_map
    Open Seat Map
    Verify Seat Map Loaded

Seat Map Shows Three Classes With Prices
    [Documentation]    Verifie que la seat map affiche les 3 classes avec leurs prix.
    [Tags]    seat_map
    Open Seat Map
    Verify Seat Map Loaded
    Verify Prices Displayed

Select Seat Goes To Confirm Page
    [Documentation]    Verifie que selectionner un siege ouvre la page de confirmation.
    [Tags]    confirm
    Open Seat Map
    Select Economy Seat
    Verify Confirm Page Loaded

Confirm Page Shows Price
    [Documentation]    Verifies that the price is correctly displayed on the confirmation page.
    [Tags]    confirm
    Open Seat Map
    Select Economy Seat
    Verify Confirm Page Loaded
    ${price}=    Get Text    ${SEL_CONFIRM_PRICE}
    Should Contain    ${price}    $

Complete Booking Creates Reference
    [Documentation]    Verifies that a full booking flow results in a valid booking reference.
    [Tags]    success
    Open Seat Map
    Select Economy Seat
    Verify Confirm Page Loaded
    ${first}    ${last}    ${email}    ${passport}=    Generate Test Passenger Data
    Fill Booking Form    ${first}    ${last}    ${email}    ${passport}
    Submit Booking
    Verify Booking Success

Boarding Pass Link Visible After Booking
    [Documentation]    Verifies that the boarding pass download link is present after a successful booking.
    [Tags]    boarding_pass
    Open Seat Map
    Select Economy Seat
    ${first}    ${last}    ${email}    ${passport}=    Generate Test Passenger Data
    Fill Booking Form    ${first}    ${last}    ${email}    ${passport}
    Submit Booking
    Verify Boarding Pass Link

Cancel Booking From Success Page
    [Documentation]    Verifies that a user can cancel their booking immediately after completion.
    [Tags]    cancel
    Open Seat Map
    Select Economy Seat
    ${first}    ${last}    ${email}    ${passport}=    Generate Test Passenger Data
    Fill Booking Form    ${first}    ${last}    ${email}    ${passport}
    Submit Booking
    Verify Booking Success
    Cancel Booking

Seat Map Inaccessible On Cancelled Flight
    [Documentation]    Verifie que la seat map est inaccessible sur un vol annule.
    [Tags]    security
    Open Browser Headless
    Login As Admin
    Go To    ${SEARCH_URL}?status=CANCELLED
    Wait Until Element Is Visible    ${SEL_SEARCH_RESULTS}    timeout=${DEFAULT_TIMEOUT}
    Sleep    0.5s
    ${link}=    Get WebElement    xpath=(//a[@data-testid='search-flight-link'])[1]
    ${href}=    Get Element Attribute    ${link}    href
    Go To    ${href}
    Wait Until Element Is Visible    ${SEL_FLIGHT_HEADER}    timeout=${DEFAULT_TIMEOUT}
    Page Should Not Contain Element    ${SEL_BTN_BOOK_SEAT}
