*** Settings ***
Library           SeleniumLibrary
Suite Setup       Open Browser To Login Page
Suite Teardown    Close Browser
Test Setup        Go To Login Page

*** Variables ***
${BROWSER}        Chrome
${URL}            https://the-internet.herokuapp.com/login
${USERNAME}       tomsmith
${PASSWORD}       SuperSecretPassword!
${DASHBOARD_URL}  https://the-internet.herokuapp.com/secure
${LOGOUT_URL}     https://the-internet.herokuapp.com/logout

*** Test Cases ***
Vérifier Connexion Utilisateur
    [Documentation]    Vérifie qu'un utilisateur peut se connecter avec des identifiants valides
    Input Text         id=username       ${USERNAME}
    Input Text         id=password       ${PASSWORD}
    Click Button       css=button.radius
    Wait Until Page Contains Element     css=.flash.success
    Location Should Be                  ${DASHBOARD_URL}

Accès Page Protégée
    [Documentation]    Vérifie l'accès à une page réservée après connexion
    Go To              ${DASHBOARD_URL}
    Page Should Contain Element         css=h2
    Element Text Should Be              css=h2    Secure Area

Déconnexion Utilisateur
    [Documentation]    Vérifie que l'utilisateur peut se déconnecter
    Wait Until Element Is Visible       xpath=//a[@href='/logout']     timeout=10s
    Click Element                       xpath=//a[@href='/logout']
    Wait Until Page Contains            Login Page
    Location Should Contain             /login

*** Keywords ***
Open Browser To Login Page
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window

Go To Login Page
    Go To    ${URL}
