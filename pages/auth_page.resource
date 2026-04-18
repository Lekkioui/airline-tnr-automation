*** Settings ***
Documentation       Page Object for authentication (login, logout, register).
Library             SeleniumLibrary
Resource            ../resources/common.resource


*** Keywords ***
Verify Login Page Loaded
    [Documentation]    Verifies the login page is displayed.
    Wait Until Element Is Visible    ${SEL_INPUT_USERNAME}    timeout=${DEFAULT_TIMEOUT}
    Page Should Contain Element      ${SEL_INPUT_PASSWORD}
    Page Should Contain Element      ${SEL_BTN_SIGNIN}

Login With Credentials
    [Documentation]    Fills and submits the login form.
    [Arguments]    ${username}    ${password}
    Input Text     ${SEL_INPUT_USERNAME}    ${username}
    Input Text     ${SEL_INPUT_PASSWORD}    ${password}
    Click Element  ${SEL_BTN_SIGNIN}

Verify Login Success
    [Documentation]    Verifies redirect to flights page after login.
    Wait Until Location Contains     /flights/                  timeout=${DEFAULT_TIMEOUT}
    Wait Until Element Is Visible    ${SEL_PAGE_TITLE_FLIGHTS}  timeout=${DEFAULT_TIMEOUT}

Verify Login Failed
    [Documentation]    Verifies error message on failed login.
    Wait Until Element Is Visible    ${SEL_INPUT_USERNAME}    timeout=${DEFAULT_TIMEOUT}
    Page Should Contain              Invalid credentials

Verify Logout Button Visible
    [Documentation]    Verifies the logout button is in the topbar.
    Wait Until Element Is Visible    ${SEL_BTN_LOGOUT}    timeout=${DEFAULT_TIMEOUT}

Click Logout
    [Documentation]    Clicks the logout button.
    Wait Until Element Is Visible    ${SEL_BTN_LOGOUT}    timeout=${DEFAULT_TIMEOUT}
    Click Element                    ${SEL_BTN_LOGOUT}

Verify Logout Success
    [Documentation]    Verifies redirect to login page after logout.
    Wait Until Location Contains     /users/login       timeout=${DEFAULT_TIMEOUT}
    Wait Until Element Is Visible    ${SEL_INPUT_USERNAME}    timeout=${DEFAULT_TIMEOUT}

Fill Register Form
    [Documentation]    Fills the registration form.
    [Arguments]    ${username}    ${email}    ${password}    ${password2}
    Input Text    ${SEL_INPUT_REG_USERNAME}    ${username}
    Input Text    ${SEL_INPUT_REG_EMAIL}       ${email}
    Input Text    ${SEL_INPUT_REG_PASSWORD}    ${password}
    Input Text    ${SEL_INPUT_REG_PASSWORD2}   ${password2}
    Click Element    ${SEL_BTN_REGISTER}

Verify Register Success
    [Documentation]    Verifies redirect to flights page after registration.
    Wait Until Location Contains     /flights/                  timeout=${DEFAULT_TIMEOUT}
    Wait Until Element Is Visible    ${SEL_PAGE_TITLE_FLIGHTS}  timeout=${DEFAULT_TIMEOUT}

Verify Register Error
    [Documentation]    Verifies error message on failed registration.
    [Arguments]    ${expected_text}
    Wait Until Element Is Visible    ${SEL_REGISTER_ERROR}    timeout=${DEFAULT_TIMEOUT}
    Element Should Contain           ${SEL_REGISTER_ERROR}    ${expected_text}

Generate Unique Username
    [Documentation]    Generates a unique username using the current epoch timestamp.
    ${timestamp}=    Get Time    epoch
    ${username}=     Set Variable    newuser_${timestamp}
    RETURN    ${username}
