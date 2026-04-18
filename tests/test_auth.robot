*** Settings ***
Documentation       Test suite for authentication — login, logout, register.
Library             SeleniumLibrary
Resource            ../pages/auth_page.resource
Resource            ../resources/common.resource
Test Setup          Reset Test Data
Test Teardown       Run Keywords
...    Run Keyword If Test Failed    Capture Page Screenshot
...    AND    Close Session
Test Tags           auth


*** Test Cases ***
Admin Login Success
    [Documentation]    Vérifie que l'admin peut se connecter et est redirigé vers /flights/.
    [Tags]    login
    Open Browser Headless
    Go To    ${LOGIN_URL}
    Verify Login Page Loaded
    Login With Credentials    ${ADMIN_USER}    ${ADMIN_PASS}
    Verify Login Success
    Verify Logout Button Visible

Invalid Login Shows Error
    [Documentation]    Vérifie qu'un login invalide affiche un message d'erreur.
    [Tags]    login
    Open Browser Headless
    Go To    ${LOGIN_URL}
    Verify Login Page Loaded
    Login With Credentials    fakeuser    wrongpass
    Verify Login Failed

Logout Via Topbar Button
    [Documentation]    Vérifie que le bouton Logout dans la topbar déconnecte l'utilisateur.
    [Tags]    logout
    Open Browser Headless
    Login As Admin
    Verify Logout Button Visible
    Click Logout
    Verify Logout Success

Register New User Success
    [Documentation]    Vérifie qu'un nouvel utilisateur peut s'inscrire et est redirigé.
    [Tags]    register
    ${username}=    Generate Unique Username
    ${email}=       Set Variable    ${username}@test.com
    Open Browser Headless
    Go To    ${REGISTER_URL}
    Fill Register Form
    ...    ${username}    ${email}    password123    password123
    Verify Register Success

Register Duplicate Email Shows Error
    [Documentation]    Vérifie qu'une inscription avec email existant affiche une erreur.
    [Tags]    register
    Open Browser Headless
    Go To    ${REGISTER_URL}
    Fill Register Form
    ...    anotheruser    anasse@gmail.com    password123    password123
    Verify Register Error    already exists

Protected Page Redirects To Login
    [Documentation]    Vérifie qu'une page protégée redirige vers login sans authentification.
    [Tags]    security
    Open Browser Headless
    Go To    ${FLIGHTS_URL}
    Wait Until Location Contains    /users/login    timeout=${DEFAULT_TIMEOUT}
    Wait Until Element Is Visible   ${SEL_INPUT_USERNAME}    timeout=${DEFAULT_TIMEOUT}
