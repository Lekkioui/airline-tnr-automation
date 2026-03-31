*** Settings ***
Library     Process
Library     OperatingSystem
Library     SeleniumLibrary
Resource    ../pages/users_page.robot
Resource    ../resources/common.robot
Test Setup      Reset Test Data
Test Teardown   Close Browser

*** Test Cases ***
Admin Login Test
    Open Users Page
    Login As Admin
    Verify Login Success

Invalid Login Test
    Open Users Page
    Login With Credentials    fakeuser    wrongpass
    Verify Login Failed
