*** Settings ***
Documentation     Authentification front-office.
...               Technique : partitions d'equivalence (identifiants valides / invalides / vides)
...               et attaques par injection (SQLi) sur les champs de connexion.
...               Une ligne du tableau = un cas de test, a rapprocher de la grille du Test Analyst.
Resource          ../resources/keywords.resource
Suite Setup       Initialiser Suite Avec Compte Client
Suite Teardown    Fermer Navigateur
Test Setup        Preparer Test
Test Teardown     Terminer Test
Test Template     Tenter Connexion
Test Tags         authentification    front-office

*** Test Cases ***                                         EMAIL                     MOT_DE_PASSE           RESULTAT
AUTH-01 Identifiants valides
    [Tags]    smoke    critique
    ${CLIENT_EMAIL}           ${CLIENT_PASSWORD}     succes

AUTH-02 Mot de passe incorrect
    [Tags]    critique
    ${CLIENT_EMAIL}           MauvaisMdp!1           echec

AUTH-03 Email inexistant
    inconnu.robot@test.com    ${CLIENT_PASSWORD}     echec

AUTH-04 Email et mot de passe vides
    ${EMPTY}                  ${EMPTY}               echec

AUTH-05 Email renseigne et mot de passe vide
    ${CLIENT_EMAIL}           ${EMPTY}               echec

AUTH-06 Email vide et mot de passe renseigne
    ${EMPTY}                  ${CLIENT_PASSWORD}     echec

AUTH-07 Email au format invalide
    pas-un-email              ${CLIENT_PASSWORD}     echec

AUTH-08 Mot de passe avec espaces en debut et fin
    ${CLIENT_EMAIL}           ${SPACE}${CLIENT_PASSWORD}${SPACE}    echec

AUTH-09 Injection SQL dans le mot de passe
    [Tags]    securite    sqli
    ${CLIENT_EMAIL}           ' OR '1'='1            echec

AUTH-10 Injection SQL dans le mot de passe (commentaire)
    [Tags]    securite    sqli
    ${CLIENT_EMAIL}           ' OR 1=1 --            echec

AUTH-11 Injection SQL dans l'email (format accepte par le navigateur)
    [Tags]    securite    sqli
    admin'--@test.com         ${CLIENT_PASSWORD}     echec
