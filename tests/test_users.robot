*** Settings ***
Resource    ../pages/users_page.robot
Resource    ../resources/common.robot
Test Setup   Reset Test Data

*** Test Cases ***
Admin Login Test
    Open Users Page
    Login As Admin
    Verify Login Success
    Close Users Session

Invalid Login Test
    Open Users Page
    Login With Credentials    fakeuser    wrongpass
    Verify Login Failed
    Close Users Session