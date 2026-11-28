*** Settings ***
Documentation     Gestion des sessions et controle d'acces cote client.
Resource          ../resources/keywords.resource
Suite Setup       Initialiser Suite Avec Compte Client
Suite Teardown    Fermer Navigateur
Test Setup        Preparer Test
Test Teardown     Terminer Test
Test Tags         session    front-office

*** Test Cases ***
SESS-01 Deconnexion apres une connexion valide
    [Tags]    smoke
    Se Connecter    ${CLIENT_EMAIL}    ${CLIENT_PASSWORD}
    Verifier Utilisateur Connecte
    Se Deconnecter
    Page Should Not Contain Element    ${LOC_LOGOUT_LINK}

SESS-02 Acces a Mon compte sans etre connecte
    [Tags]    critique    controle-acces
    Go To    ${URL_ACCOUNT}
    Verifier Page Connexion Affichee

SESS-03 Acces a Mon compte impossible apres deconnexion
    [Tags]    critique    controle-acces
    Se Connecter    ${CLIENT_EMAIL}    ${CLIENT_PASSWORD}
    Verifier Utilisateur Connecte
    Se Deconnecter
    Go To    ${URL_ACCOUNT}
    Verifier Page Connexion Affichee

SESS-04 Suppression du cookie de session invalide la connexion
    [Tags]    securite    controle-acces
    Se Connecter    ${CLIENT_EMAIL}    ${CLIENT_PASSWORD}
    Verifier Utilisateur Connecte
    Delete All Cookies
    Go To    ${URL_ACCOUNT}
    Verifier Page Connexion Affichee

SESS-05 Message d'erreur affiche apres un echec de connexion
    Se Connecter    ${CLIENT_EMAIL}    MauvaisMdp!1
    Wait Until Element Is Visible    ${LOC_LOGIN_ERROR}    ${TIMEOUT}
