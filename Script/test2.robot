*** Settings ***
Library           SeleniumLibrary
Suite Setup       Open Browser To Login Page
Suite Teardown    Close Browser
Test Setup        Go To Login Page

*** Variables ***
${BROWSER}        Chrome
${URL}            https://the-internet.herokuapp.com/login
${HOMEPAGE}       https://the-internet.herokuapp.com/
${USERNAME}       tomsmith
${PASSWORD}       SuperSecretPassword!
${DASHBOARD_URL}  https://the-internet.herokuapp.com/secure
${LOGOUT_URL}     https://the-internet.herokuapp.com/logout
${ADD_BUTTON}       xpath=//button[text()='Add Element']
${DELETE_BUTTON}    xpath=//button[text()='Delete']
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


Login With Invalid Credentials
    Go To    ${HOMEPAGE} 
    Click Link    Form Authentication
    Input Text    id=username    invalid
    Input Text    id=password    wrong
    Click Button    xpath=//button[@type='submit']
    Wait Until Page Contains    Your username is invalid    timeout=5s


Ajouter Et Supprimer Des Éléments
    Go To    ${HOMEPAGE} 
    Click Link    Add/Remove Elements
    Log    🔄 Ajout de 3 éléments...
    Click Element    ${ADD_BUTTON}
    Click Element    ${ADD_BUTTON}
    Click Element    ${ADD_BUTTON}
    ${delete_buttons}=    Get WebElements    ${DELETE_BUTTON}
    Length Should Be    ${delete_buttons}    3

    Log    ❌ Suppression d’un élément...
    Click Element    ${DELETE_BUTTON}

    ${remaining}=    Get WebElements    ${DELETE_BUTTON}
    Length Should Be    ${remaining}    2

#Déconnexion Utilisateur
    #[Documentation]    Vérifie que l'utilisateur peut se déconnecter
    #Wait Until Element Is Visible       xpath=//a[@href='/logout']     timeout=10s
    #Click Element                       xpath=//a[@href='/logout']
    #Wait Until Page Contains            Login Page
    #Location Should Contain             /login

*** Keywords ***
Open Browser To Login Page
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window

Go To Login Page
    Go To    ${URL}
