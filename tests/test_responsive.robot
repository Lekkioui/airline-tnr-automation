*** Settings ***
Documentation    Test suite for responsive design across mobile, tablet and desktop viewports.
Library          SeleniumLibrary
Resource         ../pages/flights_page.resource
Resource         ../pages/flight_details_page.resource
Resource         ../pages/search_page.resource
Resource         ../pages/responsive_page.resource
Resource         ../resources/common.resource
Suite Setup      Create Results Directories
Test Setup       Reset Test Data
Test Teardown    Run Keywords
...    Run Keyword If Test Failed    Capture Page Screenshot
...    AND    Close Flights Session


*** Test Cases ***
Flights Page Renders On Mobile
    [Documentation]    Vérifie que la page flights s'affiche correctement sur mobile (375px).
    Open Flights Page
    Set Mobile Viewport
    Verify Navigation Visible
    Verify Page Title Visible    ${SEL_PAGE_TITLE_FLIGHTS}
    Verify Flight List Visible
    Take Viewport Screenshot    flights    mobile

Flights Page Renders On Tablet
    [Documentation]    Vérifie que la page flights s'affiche correctement sur tablette (768px).
    Open Flights Page
    Set Tablet Viewport
    Verify Navigation Visible
    Verify Page Title Visible    ${SEL_PAGE_TITLE_FLIGHTS}
    Verify Flight List Visible
    Take Viewport Screenshot    flights    tablet

Flights Page Renders On Desktop
    [Documentation]    Vérifie que la page flights s'affiche correctement sur desktop (1920px).
    Open Flights Page
    Set Desktop Viewport
    Verify Navigation Visible
    Verify Page Title Visible    ${SEL_PAGE_TITLE_FLIGHTS}
    Verify Flight List Visible
    Take Viewport Screenshot    flights    desktop

Flight Detail Renders On Mobile
    [Documentation]    Vérifie que la page détail vol s'affiche correctement sur mobile.
    Open Flights Page
    Click First Flight
    Set Mobile Viewport
    Verify Navigation Visible
    Verify Flight Detail Elements Visible
    Take Viewport Screenshot    flight_detail    mobile

Flight Detail Renders On Tablet
    [Documentation]    Vérifie que la page détail vol s'affiche correctement sur tablette.
    Open Flights Page
    Click First Flight
    Set Tablet Viewport
    Verify Navigation Visible
    Verify Flight Detail Elements Visible
    Take Viewport Screenshot    flight_detail    tablet

Flight Detail Renders On Desktop
    [Documentation]    Vérifie que la page détail vol s'affiche correctement sur desktop.
    Open Flights Page
    Click First Flight
    Set Desktop Viewport
    Verify Navigation Visible
    Verify Flight Detail Elements Visible
    Take Viewport Screenshot    flight_detail    desktop

Search Page Renders On Mobile
    [Documentation]    Vérifie que la page recherche s'affiche correctement sur mobile.
    Open Flights Page
    Go To Search Page
    Set Mobile Viewport
    Verify Navigation Visible
    Verify Search Form Visible At Viewport
    Take Viewport Screenshot    search    mobile

Search Page Renders On Tablet
    [Documentation]    Vérifie que la page recherche s'affiche correctement sur tablette.
    Open Flights Page
    Go To Search Page
    Set Tablet Viewport
    Verify Navigation Visible
    Verify Search Form Visible At Viewport
    Take Viewport Screenshot    search    tablet

Search Page Renders On Desktop
    [Documentation]    Vérifie que la page recherche s'affiche correctement sur desktop.
    Open Flights Page
    Go To Search Page
    Set Desktop Viewport
    Verify Navigation Visible
    Verify Search Form Visible At Viewport
    Take Viewport Screenshot    search    desktop

Add Passenger Button Visible On Mobile
    [Documentation]    Vérifie que le bouton Add Passenger est visible sur mobile.
    Open Flights Page
    Click First Flight
    Set Mobile Viewport
    Verify Add Passenger Button Visible
    Take Viewport Screenshot    add_passenger_btn    mobile

Add Passenger Button Visible On Desktop
    [Documentation]    Vérifie que le bouton Add Passenger est visible sur desktop.
    Open Flights Page
    Click First Flight
    Set Desktop Viewport
    Verify Add Passenger Button Visible
    Take Viewport Screenshot    add_passenger_btn    desktop
