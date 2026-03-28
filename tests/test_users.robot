*** Settings ***
Resource    ../pages/users_page.robot

*** Test Cases ***
Admin Login Test
    Open Users Page
    Login As Admin
    Verify Login Success
    Close Users Session