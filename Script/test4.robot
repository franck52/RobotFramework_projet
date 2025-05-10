*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${browser}    chrome
${url}        https://www.saucedemo.com/v1/
${username}   standard_user
${password}   secret_sauce
*** Keywords ***
Connexion Utilisateur
    [Documentation]    Ouvre le navigateur et se connecte avec un utilisateur valide.
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Input Text      id:user-name       ${USERNAME}
    Input Text      id:password        ${PASSWORD}
    Click Button    id:login-button
    Location Should Be    https://www.saucedemo.com/v1/inventory.html

*** Test Cases ***
Home test
    Open Browser    ${url}    ${browser}
    Set Browser Implicit Wait    2
    Maximize Browser Window
#Login To Saucedemo
    
    #Input Text    id:user-name    ${username}
    #Sleep   2
    #Input Text    id:password     ${password}
    #Sleep    2
    #Click Button  id:login-button
    #Page Should Contain Element    id:inventory_container
    #Sleep 2
   # Close Browser
Test Connexion Valide
    Connexion Utilisateur
    Close Browser
Test Add Produits
    Connexion Utilisateur
    Click Button    xpath=//*[@id="inventory_container"]/div/div[1]/div[3]/button
    #Click Link      id:shopping_cart_container
    Page Should Contain Element    xpath=//div[text()='Sauce Labs Backpack']
    Close Browser
