*** Settings ***
Documentation    Test suite for responsive design.
Test Tags         responsive
Library          SeleniumLibrary
Resource         ../pages/dashboard_page.resource
Resource         ../resources/common.resource
Suite Setup      Create Results Directories
Test Setup       Reset Test Data
Test Teardown    Run Keywords
...    Run Keyword If Test Failed    Capture Page Screenshot
...    AND    Close Session


*** Variables ***
${MOBILE_WIDTH}     375
${MOBILE_HEIGHT}    812
${DESKTOP_WIDTH}    1920
${DESKTOP_HEIGHT}   1080


*** Test Cases ***
Index Page Responsive Mobile
    [Documentation]    Verifie que la page index s affiche correctement sur mobile.
    [Tags]    mobile
    Setup Mobile Browser
    Go To    ${FLIGHTS_URL}
    Wait Until Element Is Visible    ${SEL_PAGE_TITLE_FLIGHTS}    timeout=${DEFAULT_TIMEOUT}
    Element Should Be Visible        ${SEL_TOPBAR}
    Element Should Be Visible        ${SEL_FLIGHT_TABLE}
    Capture Page Screenshot    filename=${EXECDIR}/results/screenshots/index_mobile.png

Flight Detail Responsive Mobile
    [Documentation]    Verifie que la page detail vol s affiche correctement sur mobile.
    [Tags]    mobile
    Setup Mobile Browser
    Go To    ${SEARCH_URL}?status=SCHEDULED
    Wait Until Element Is Visible    ${SEL_SEARCH_RESULTS}    timeout=${DEFAULT_TIMEOUT}
    ${link}=    Get WebElement    xpath=(//a[@data-testid='search-flight-link'])[1]
    ${href}=    Get Element Attribute    ${link}    href
    Go To    ${href}
    Wait Until Element Is Visible    ${SEL_FLIGHT_HEADER}    timeout=${DEFAULT_TIMEOUT}
    Element Should Be Visible        ${SEL_DETAIL_STATUS}
    Element Should Be Visible        ${SEL_DETAIL_CAPACITY}
    Capture Page Screenshot    filename=${EXECDIR}/results/screenshots/flight_detail_mobile.png

Search Page Responsive Mobile
    [Documentation]    Verifie que la page recherche s affiche correctement sur mobile.
    [Tags]    mobile
    Setup Mobile Browser
    Go To    ${SEARCH_URL}
    Wait Until Element Is Visible    ${SEL_PAGE_TITLE_SEARCH}    timeout=${DEFAULT_TIMEOUT}
    Element Should Be Visible        ${SEL_SEARCH_ORIGIN}
    Element Should Be Visible        ${SEL_SEARCH_STATUS}
    Capture Page Screenshot    filename=${EXECDIR}/results/screenshots/search_mobile.png

Dashboard Responsive Desktop
    [Documentation]    Verifie que le dashboard s affiche correctement sur desktop.
    [Tags]    desktop
    Setup Desktop Browser
    Go To    ${DASHBOARD_URL}
    Wait Until Element Is Visible    ${SEL_PAGE_TITLE_DASHBOARD}    timeout=${DEFAULT_TIMEOUT}
    Element Should Be Visible        ${SEL_KPI_GRID}
    Element Should Be Visible        ${SEL_TODAY_BAR}
    Capture Page Screenshot    filename=${EXECDIR}/results/screenshots/dashboard_desktop.png


*** Keywords ***
Setup Mobile Browser
    [Documentation]    Opens a headless browser, logs in as admin, and sets the window size to mobile dimensions.
    Open Browser Headless
    Login As Admin
    Set Window Size    ${MOBILE_WIDTH}    ${MOBILE_HEIGHT}

Setup Desktop Browser
    [Documentation]    Opens a headless browser, logs in as admin, and sets the window size to desktop dimensions.
    Open Browser Headless
    Login As Admin
    Set Window Size    ${DESKTOP_WIDTH}    ${DESKTOP_HEIGHT}
