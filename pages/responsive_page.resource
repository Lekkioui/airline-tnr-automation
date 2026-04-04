*** Settings ***
Documentation    Page Object for responsive design testing.
Library          SeleniumLibrary
Resource         ../resources/common.resource


*** Variables ***
${MOBILE_WIDTH}     375
${MOBILE_HEIGHT}    812
${TABLET_WIDTH}     768
${TABLET_HEIGHT}    1024
${DESKTOP_WIDTH}    1920
${DESKTOP_HEIGHT}   1080


*** Keywords ***
Set Mobile Viewport
    [Documentation]    Sets the browser viewport to mobile size (375x812).
    Set Window Size    ${MOBILE_WIDTH}    ${MOBILE_HEIGHT}

Set Tablet Viewport
    [Documentation]    Sets the browser viewport to tablet size (768x1024).
    Set Window Size    ${TABLET_WIDTH}    ${TABLET_HEIGHT}

Set Desktop Viewport
    [Documentation]    Sets the browser viewport to desktop size (1920x1080).
    Set Window Size    ${DESKTOP_WIDTH}    ${DESKTOP_HEIGHT}

Verify Page Title Visible
    [Documentation]    Verifies that the main page title is visible at current viewport.
    [Arguments]    ${selector}
    Wait Until Element Is Visible    ${selector}    timeout=${DEFAULT_TIMEOUT}
    Element Should Be Visible        ${selector}

Verify Element Visible At Viewport
    [Documentation]    Verifies that an element is visible at the current viewport size.
    [Arguments]    ${selector}
    Element Should Be Visible    ${selector}

Verify Navigation Visible
    [Documentation]    Verifies that the top navigation bar is visible.
    Element Should Be Visible    css:[data-testid='topbar']

Verify Flight List Visible
    [Documentation]    Verifies that the flight list is visible at current viewport.
    Element Should Be Visible    css:[data-testid='flight-list']

Verify Flight Detail Elements Visible
    [Documentation]    Verifies that key flight detail elements are visible at current viewport.
    Element Should Be Visible    ${SEL_DETAIL_ORIGIN}
    Element Should Be Visible    ${SEL_DETAIL_DESTINATION}
    Element Should Be Visible    ${SEL_DETAIL_STATUS}
    Element Should Be Visible    ${SEL_DETAIL_CAPACITY}

Verify Search Form Visible At Viewport
    [Documentation]    Verifies that the search form is fully visible at current viewport.
    Element Should Be Visible    ${SEL_SEARCH_ORIGIN}
    Element Should Be Visible    ${SEL_SEARCH_DESTINATION}
    Element Should Be Visible    ${SEL_SEARCH_STATUS}
    Element Should Be Visible    ${SEL_BTN_SEARCH_SUBMIT}

Verify Add Passenger Button Visible
    [Documentation]    Verifies that the add passenger button is visible at current viewport.
    Element Should Be Visible    ${SEL_BTN_OPEN_MODAL}

Take Viewport Screenshot
    [Documentation]    Takes a screenshot with the viewport size in the filename.
    [Arguments]    ${page_name}    ${viewport_name}
    Capture Page Screenshot    filename=${EXECDIR}/results/screenshots/${page_name}_${viewport_name}.png
