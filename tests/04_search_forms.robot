*** Settings ***
Documentation     Recherche du catalogue et formulaires publics.
...               Techniques : valeurs limites (vide, tres long), caracteres speciaux,
...               fuzzing manuel de payloads (SQLi, XSS) avec controle de robustesse :
...               aucune erreur serveur ni alerte JavaScript ne doit apparaitre.
Resource          ../resources/keywords.resource
Suite Setup       Ouvrir Navigateur
Suite Teardown    Fermer Navigateur
Test Setup        Preparer Test
Test Teardown     Terminer Test
Test Tags         recherche    front-office

*** Test Cases ***
SRCH-01 Recherche d'un produit existant
    [Tags]    smoke
    Rechercher    ${TERME_RECHERCHE}
    Wait Until Page Contains Element    ${LOC_PRODUCT_MINIATURE}    ${TIMEOUT}

SRCH-02 Recherche sans resultat
    Rechercher    zzzxqy123introuvable
    Wait Until Location Contains    search    ${TIMEOUT}
    Verifier Absence Erreur Serveur
    Page Should Not Contain Element    ${LOC_PRODUCT_MINIATURE}

SRCH-03 Recherche vide
    [Tags]    valeurs-limites
    Rechercher Et Verifier Robustesse    ${EMPTY}

SRCH-04 Recherche avec une chaine tres longue (1000 caracteres)
    [Tags]    valeurs-limites
    Rechercher Et Verifier Robustesse    ${CHAINE_LONGUE}

SRCH-05 Recherche avec des caracteres speciaux
    [Tags]    valeurs-limites
    Rechercher Et Verifier Robustesse    %&$#@!*()[]{}\\/éàç

SRCH-06 Injection SQL dans la recherche (condition toujours vraie)
    [Tags]    securite    sqli
    Rechercher Et Verifier Robustesse    ' OR 1=1 --

SRCH-07 Injection SQL dans la recherche (UNION)
    [Tags]    securite    sqli
    Rechercher Et Verifier Robustesse    1' UNION SELECT NULL--

SRCH-08 XSS reflechi dans la recherche (balise script)
    [Tags]    securite    xss
    Rechercher Et Verifier Robustesse    <script>alert('xss')</script>

SRCH-09 XSS reflechi dans la recherche (attribut onerror)
    [Tags]    securite    xss
    Rechercher Et Verifier Robustesse    <img src=x onerror=alert(1)>

FORM-01 Formulaire de contact avec une charge XSS dans le message
    [Documentation]    Robustesse uniquement : l'envoi de mail peut echouer dans l'environnement Docker.
    [Tags]    securite    xss
    Soumettre Formulaire Contact    robot.contact@test.com    <script>alert('xss')</script>
    Verifier Absence Erreur Serveur
    Alert Should Not Be Present
