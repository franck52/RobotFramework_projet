*** Settings ***
Library    SeleniumLibrary
Suite Setup    Open Browser To Login Page
Suite Teardown    Close Browser

*** Variables ***
${URL}         https://www.saucedemo.com/v1/
${BROWSER}     chrome
${USERNAME}    standard_user
${PASSWORD}    secret_sauce

*** Test Cases ***
Ajout d’un seul produit au panier
    [Tags]    panier
    Connexion utilisateur
    Ajouter Produit Au Panier    Sauce Labs Backpack
    Aller Au Panier
    Vérifier Produit Dans Panier    Sauce Labs Backpack

Ajout de plusieurs produits au panier
    [Tags]    panier
    Connexion utilisateur
    @{produits}=    Create List    Sauce Labs Backpack    Sauce Labs Onesie    Sauce Labs Bolt T-Shirt
    FOR    ${produit}    IN    @{produits}
        Ajouter Produit Au Panier    ${produit}
    END
    Aller Au Panier
    FOR    ${produit}    IN    @{produits}
        Vérifier Produit Dans Panier    ${produit}
    END

#Réinitialiser l’état de l’application
    #Connexion utilisateur
    #Cliquer Sur Le Menu
    #Click Link    id=reset_sidebar_link
    #Cliquer Sur Le Menu
    #Attendre Que Le Menu Soit Fermé
    #Aller Au Panier
    #Page Should Not Contain Element    class=inventory_item_name
Réinitialiser l’état de l’application
    Connexion utilisateur
    Cliquer Sur Le Menu
    Click Link    id=reset_sidebar_link
    Fermer Le Menu
    Aller Au Panier

Filtrage des produits A-Z
    [Tags]    tri
    Connexion utilisateur
    Select From List By Value    class=product_sort_container    az
    Page Should Contain    Sauce Labs Backpack

Déconnexion de l’utilisateur
    [Tags]    logout
    Connexion utilisateur
    Cliquer Sur Le Menu
    Click Link    id=logout_sidebar_link
    Page Should Contain Element    id=login-button

*** Keywords ***

Connexion Utilisateur
    [Documentation]    Ouvre le navigateur et se connecte avec un utilisateur valide.
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Input Text      id:user-name       ${USERNAME}
    Input Text      id:password        ${PASSWORD}
    Click Button    id:login-button
    Location Should Be    https://www.saucedemo.com/v1/inventory.html

Open Browser To Login Page
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Speed    0.3s

Ajouter Produit Au Panier
    [Arguments]    ${nom_produit}
    Click Button    xpath=//div[text()='${nom_produit}']/ancestor::div[@class='inventory_item']//button

Vérifier Produit Dans Panier
    [Arguments]    ${nom_produit}
    Page Should Contain Element    xpath=//div[text()='${nom_produit}']

Aller Au Panier
    Click Link    class=shopping_cart_link

Cliquer Sur Le Menu
    Click Button    xpath=//button[text()='Open Menu']
    Sleep    1s    # Laisser le menu apparaître (JS animé)

Fermer Le Menu
    Click Button    xpath=//*[@id="menu_button_container"]/div/div[2]/div[2]/div/button
    #Wait Until Keyword Succeeds    10x    1s    Element Should Not Be Visible    css=.bm-menu
    #//*[@id="menu_button_container"]/div/div[2]/div[2]/div/button


Attendre Que Le Menu Soit Fermé
    Wait Until Element Is Not Visible    css=.bm-menu    #timeout=5s
    Wait Until Element Is Not Visible    css=.bm-overlay   # timeout=5s





