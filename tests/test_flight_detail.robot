*** Settings ***
Documentation       Test suite for flight detail page and status management.
Library             SeleniumLibrary
Resource            ../pages/flight_detail_page.resource
Resource            ../resources/common.resource
Test Setup          Reset Test Data
Test Teardown       Run Keywords
...    Run Keyword If Test Failed    Capture Page Screenshot
...    AND    Close Session
Test Tags           flight_detail


*** Test Cases ***
Flight Detail Shows All Info
    [Documentation]    Verifie que la page detail affiche toutes les infos du vol.
    Open Flight Detail By Status    SCHEDULED
    Verify Flight Detail Loaded
    Verify Passenger Count

Scheduled Flight Shows Status Form
    [Documentation]    Verifie qu un vol SCHEDULED affiche le formulaire de statut.
    [Tags]    status
    Open Flight Detail By Status    SCHEDULED
    Verify Flight Status Is         SCHEDULED
    Verify Status Form Visible
    Verify Booking Enabled

Cancelled Flight Disables Booking
    [Documentation]    Verifie qu un vol CANCELLED desactive le booking.
    [Tags]    status
    Open Flight Detail By Status    CANCELLED
    Verify Flight Status Is         CANCELLED
    Verify Booking Disabled
    Verify No Status Transitions

Departed Flight Has No Transitions
    [Documentation]    Verifie qu un vol DEPARTED n a plus de transitions.
    [Tags]    status
    Open Flight Detail By Status    DEPARTED
    Verify Flight Status Is         DEPARTED
    Verify No Status Transitions
    Verify Booking Disabled

Update Status Scheduled To Boarding
    [Documentation]    Verifie la transition SCHEDULED vers BOARDING.
    [Tags]    status
    Open Flight Detail By Status    SCHEDULED
    Verify Flight Status Is         SCHEDULED
    Update Status To                BOARDING
    Verify Flight Status Is         BOARDING
    Verify Booking Disabled

Update Status Boarding To Departed
    [Documentation]    Verifie la transition BOARDING vers DEPARTED.
    [Tags]    status
    Open Flight Detail By Status    BOARDING
    Verify Flight Status Is         BOARDING
    Update Status To                DEPARTED
    Verify Flight Status Is         DEPARTED
    Verify No Status Transitions
