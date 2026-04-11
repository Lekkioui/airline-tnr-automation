*** Settings ***
Documentation    Test suite for user authentication and logout.
Library          SeleniumLibrary
Resource         ../pages/users_page.resource
Resource         ../resources/common.resource
Test Setup     Reset Test Data
Test Teardown    Run Keyword If Test Failed    Capture Page Screenshot


*** Test Cases ***
Admin Login Test
    [Documentation]    Vérifie que l'admin peut se connecter et est redirigé vers /flights/.
    Open Users Page
    Login As Admin
    Verify Login Success

Invalid Login Test
    [Documentation]    Vérifie qu'un login invalide affiche un message d'erreur.
    Open Users Page
    Login With Credentials    fakeuser    wrongpass
    Verify Login Failed

Logout Test
    [Documentation]    Vérifie que le bouton Logout dans la topbar déconnecte l'utilisateur
    ...                et le redirige vers la page de login.
    Open Users Page
    Login As Admin
    Verify Login Success
    Click Logout Button
    Verify Logout Success
    [Tags]    logout    authentication
