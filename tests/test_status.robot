*** Settings ***
Documentation    Test suite for flight status management.
Library          SeleniumLibrary
Resource         ../pages/flights_page.resource
Resource         ../pages/flight_details_page.resource
Resource         ../pages/status_page.resource
Resource         ../resources/common.resource
Test Setup       Reset Test Data
Test Teardown    Run Keywords
...    Run Keyword If Test Failed    Capture Page Screenshot
...    AND    Close Flights Session


*** Test Cases ***
Status Form Is Visible On Scheduled Flight
    [Documentation]    Vérifie que le formulaire de statut est visible sur un vol SCHEDULED.
    Open Flights Page
    Click First Flight
    Verify Status Form Visible

Scheduled Flight Has Boarding And Cancelled Options
    [Documentation]    Vérifie que SCHEDULED propose BOARDING et CANCELLED.
    Open Flights Page
    Click First Flight
    Page Should Contain Element    css:[data-testid='status-option'][value='BOARDING']
    Page Should Contain Element    css:[data-testid='status-option'][value='CANCELLED']

Update Status From Scheduled To Boarding
    [Documentation]    Vérifie la transition SCHEDULED → BOARDING.
    Open Flights Page
    Click First Flight
    Verify Flight Status    SCHEDULED
    Update Flight Status    BOARDING
    Verify Status Updated   BOARDING

Update Status From Scheduled To Cancelled
    [Documentation]    Vérifie la transition SCHEDULED → CANCELLED.
    Open Flights Page
    Click First Flight
    Verify Flight Status    SCHEDULED
    Update Flight Status    CANCELLED
    Verify Status Updated   CANCELLED

Update Status From Boarding To Departed
    [Documentation]    Vérifie la transition BOARDING → DEPARTED.
    Open Flights Page
    Click First Flight
    Update Flight Status    BOARDING
    Verify Status Updated   BOARDING
    Update Flight Status    DEPARTED
    Verify Status Updated   DEPARTED

Update Status From Boarding To Cancelled
    [Documentation]    Vérifie la transition BOARDING → CANCELLED.
    Open Flights Page
    Click First Flight
    Update Flight Status    BOARDING
    Verify Status Updated   BOARDING
    Update Flight Status    CANCELLED
    Verify Status Updated   CANCELLED

Departed Flight Has No Transitions
    [Documentation]    Vérifie qu'un vol DEPARTED n'a plus de transitions disponibles.
    Open Flights Page
    Click First Flight
    Update Flight Status    BOARDING
    Update Flight Status    DEPARTED
    Verify No Status Transition Available

Cancelled Flight Has No Transitions
    [Documentation]    Vérifie qu'un vol CANCELLED n'a plus de transitions disponibles.
    Open Flights Page
    Click First Flight
    Update Flight Status    CANCELLED
    Verify No Status Transition Available

Boarding Flight Disables Booking
    [Documentation]    Vérifie que passer en BOARDING désactive le booking.
    Open Flights Page
    Click First Flight
    Update Flight Status    BOARDING
    Verify Booking Disabled After Status Change

Cancelled Flight Disables Booking
    [Documentation]    Vérifie que passer en CANCELLED désactive le booking.
    Open Flights Page
    Click First Flight
    Update Flight Status    CANCELLED
    Verify Booking Disabled After Status Change

Departed Flight Disables Booking
    [Documentation]    Vérifie qu'un vol DEPARTED désactive le booking.
    Open Flights Page
    Click First Flight
    Update Flight Status    BOARDING
    Update Flight Status    DEPARTED
    Verify Booking Disabled After Status Change
