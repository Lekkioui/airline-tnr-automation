*** Settings ***
Library     SeleniumLibrary
Resource    ../pages/users_page.robot
Resource    ../resources/common.robot
Test Setup      Reset Test Data
Test Teardown    Run Keyword If Test Failed    Capture Page Screenshot

*** Test Cases ***
Admin Login Test
    [Documentation]    Vérifie que l'admin peut se connecter et est redirigé vers /flights/
    Open Users Page
    Login As Admin
    Verify Login Success

Invalid Login Test
    [Documentation]    Vérifie qu'un login invalide affiche un message d'erreur
    Open Users Page
    Login With Credentials    fakeuser    wrongpass
    Verify Login Failed

Logout Test
    [Documentation]    Vérifie que la déconnexion fonctionne
    Open Users Page
    Login As Admin
    Verify Login Success
    Go To    http://127.0.0.1:8000/users/logout
    Wait Until Page Contains    Logged Out    timeout=10s