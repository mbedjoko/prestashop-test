*** Settings ***
Documentation     Inscription d'un client.
...               Techniques : partitions d'equivalence, valeurs limites (mot de passe),
...               table de decision (consentement) et injections dans les champs de saisie.
...               Email : UNIQUE = genere a chaque execution ; EXISTANT = compte cree par la suite.
Resource          ../resources/keywords.resource
Suite Setup       Initialiser Suite Avec Compte Client
Suite Teardown    Fermer Navigateur
Test Setup        Preparer Test
Test Teardown     Terminer Test
Test Template     Tenter Inscription
Test Tags         inscription    front-office

*** Test Cases ***                                      PRENOM              NOM                 EMAIL              MOT_DE_PASSE          CONSENTEMENT    RESULTAT
REG-01 Inscription valide
    [Tags]    smoke    critique
    ${CLIENT_PRENOM}    ${CLIENT_NOM}    UNIQUE    ${CLIENT_PASSWORD}    oui    succes

REG-02 Email deja utilise
    ${CLIENT_PRENOM}    ${CLIENT_NOM}    EXISTANT    ${CLIENT_PASSWORD}    oui    echec

REG-03 Email sans arobase
    ${CLIENT_PRENOM}    ${CLIENT_NOM}    emailinvalide    ${CLIENT_PASSWORD}    oui    echec

REG-04 Email vide
    ${CLIENT_PRENOM}    ${CLIENT_NOM}    ${EMPTY}    ${CLIENT_PASSWORD}    oui    echec

REG-05 Mot de passe vide
    ${CLIENT_PRENOM}    ${CLIENT_NOM}    UNIQUE    ${EMPTY}    oui    echec

REG-06 Mot de passe trop court (4 caracteres)
    [Tags]    valeurs-limites
    ${CLIENT_PRENOM}    ${CLIENT_NOM}    UNIQUE    Ab1!    oui    echec

REG-07 Prenom contenant des chiffres
    Jean123    ${CLIENT_NOM}    UNIQUE    ${CLIENT_PASSWORD}    oui    echec

REG-08 Nom contenant des caracteres dangereux (XSS)
    [Tags]    securite    xss
    ${CLIENT_PRENOM}    <script>alert(1)</script>    UNIQUE    ${CLIENT_PASSWORD}    oui    echec

REG-09 Consentement non coche
    [Tags]    table-decision
    ${CLIENT_PRENOM}    ${CLIENT_NOM}    UNIQUE    ${CLIENT_PASSWORD}    non    echec

REG-10 Tous les champs obligatoires vides
    ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY}    oui    echec
