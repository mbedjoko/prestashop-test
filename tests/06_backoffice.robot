*** Settings ***
Documentation     Back-office : authentification, controle d'acces et navigation.
...               La creation de produit (BO-09) est taguee "a-valider" : selecteurs de la page
...               produit v2 a confirmer sur l'instance avant de l'integrer a la campagne.
Resource          ../resources/keywords.resource
Suite Setup       Initialiser Suite Avec Compte Client
Suite Teardown    Fermer Navigateur
Test Setup        Preparer Test
Test Teardown     Terminer Test
Test Tags         back-office

*** Test Cases ***
BO-01 Connexion administrateur valide
    [Tags]    smoke    critique    authentification
    Tenter Connexion Backoffice    ${ADMIN_EMAIL}    ${ADMIN_PASSWORD}    succes

BO-02 Mot de passe administrateur incorrect
    [Tags]    critique    authentification
    Tenter Connexion Backoffice    ${ADMIN_EMAIL}    MauvaisMdp!1    echec

BO-03 Email administrateur inexistant
    [Tags]    authentification
    Tenter Connexion Backoffice    inconnu.robot@test.com    ${ADMIN_PASSWORD}    echec

BO-04 Champs de connexion vides
    [Tags]    authentification
    Tenter Connexion Backoffice    ${EMPTY}    ${EMPTY}    echec

BO-05 Injection SQL dans le mot de passe administrateur
    [Tags]    securite    sqli    authentification
    Tenter Connexion Backoffice    ${ADMIN_EMAIL}    ' OR '1'='1    echec

BO-06 Acces direct a une page du back-office sans authentification
    [Tags]    securite    controle-acces    critique
    Go To    ${ADMIN_URL}/index.php?controller=AdminOrders
    Verifier Backoffice Refuse

BO-07 Une session client front-office ne donne pas acces au back-office
    [Tags]    securite    controle-acces    critique
    Se Connecter    ${CLIENT_EMAIL}    ${CLIENT_PASSWORD}
    Verifier Utilisateur Connecte
    Go To    ${ADMIN_URL}
    Verifier Backoffice Refuse

BO-08 Navigation vers les produits et les commandes
    [Tags]    smoke    navigation
    Se Connecter Au Backoffice    ${ADMIN_EMAIL}    ${ADMIN_PASSWORD}
    Verifier Backoffice Connecte
    Naviguer Menu Backoffice    subtab-AdminCatalog    products
    Page Should Contain Element    css:table
    Naviguer Menu Backoffice    subtab-AdminParentOrders    orders
    Page Should Contain Element    css:table

BO-09 Creation d'un produit standard
    [Documentation]    A VALIDER : selecteurs de la page produit v2 (PrestaShop 8.1+) a confirmer.
    [Tags]    a-valider    gestion-produits
    Se Connecter Au Backoffice    ${ADMIN_EMAIL}    ${ADMIN_PASSWORD}
    Verifier Backoffice Connecte
    Naviguer Menu Backoffice    subtab-AdminCatalog    products
    ${horodatage}=    Get Current Date    result_format=%H%M%S
    ${nom}=    Set Variable    Produit Robot ${horodatage}
    Creer Produit Standard    ${nom}    19.99
    Reload Page
    Wait Until Element Is Visible    ${LOC_BO_PRODUCT_NAME}    ${TIMEOUT}
    Textfield Value Should Be    ${LOC_BO_PRODUCT_NAME}    ${nom}
