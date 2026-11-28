*** Settings ***
Documentation     Mots-cles metier (couche "page objects") reutilises par toutes les suites.
...               Les tests ne contiennent AUCUN localisateur : ils appellent ces mots-cles,
...               qui s'appuient sur locators.resource.
Library           SeleniumLibrary    screenshot_root_directory=EMBED
Library           DateTime
Library           String
Library           OperatingSystem
Resource          variables.resource
Resource          locators.resource

*** Keywords ***
# =====================================================================
# Navigateur et cycle de vie des tests
# =====================================================================
Ouvrir Navigateur
    [Documentation]    Ouvre Chrome (visible ou headless selon ${HEADLESS}).
    ${options}=    Set Variable    add_argument("--window-size=1920,1080")
    ${headless}=    Convert To Boolean    ${HEADLESS}
    IF    ${headless}
        ${options}=    Catenate    SEPARATOR=;    ${options}    add_argument("--headless=new")
    END
    Open Browser    about:blank    ${BROWSER}    options=${options}
    Set Selenium Timeout    ${TIMEOUT}
    Set Selenium Speed    ${SPEED}
    IF    not ${headless}
        Maximize Browser Window
    END

Fermer Navigateur
    Close All Browsers

Preparer Test
    [Documentation]    Isole chaque test : session vierge (cookies supprimes) puis page cible.
    [Arguments]    ${page}=${URL}
    Delete All Cookies
    Go To    ${page}

Terminer Test
    [Documentation]    Capture d'ecran integree a log.html en cas d'echec (preuve pour le registre des anomalies).
    IF    $TEST_STATUS == 'FAIL'
        Capture Page Screenshot
        Run Keyword And Ignore Error    Sauvegarder Source Page
    END

Initialiser Suite Avec Compte Client
    [Documentation]    Ouvre le navigateur et cree un compte client unique reutilise par la suite.
    Ouvrir Navigateur
    ${email}=    Creer Compte Client Unique
    Set Suite Variable    ${CLIENT_EMAIL}    ${email}

# =====================================================================
# Utilitaires
# =====================================================================
Generer Email Unique
    ${horodatage}=    Get Current Date    result_format=%Y%m%d%H%M%S%f
    RETURN    robot.${horodatage}@test.com

Resoudre Email
    [Documentation]    UNIQUE -> email jamais utilise ; EXISTANT -> email du compte de la suite.
    [Arguments]    ${valeur}
    IF    '${valeur}' == 'UNIQUE'
        ${valeur}=    Generer Email Unique
    ELSE IF    '${valeur}' == 'EXISTANT'
        ${valeur}=    Set Variable    ${CLIENT_EMAIL}
    END
    RETURN    ${valeur}

Cocher Case
    [Documentation]    Clic JavaScript : les cases du theme classic sont stylisees (input masque).
    [Arguments]    ${nom_champ}
    Execute JavaScript    var e = document.querySelector("input[name='${nom_champ}']"); if (e && !e.checked) { e.click(); }

Verifier Absence Erreur Serveur
    [Documentation]    Detecte les fuites d'erreurs PHP/SQL dans le code source de la page.
    Wait For Condition    return document.readyState === 'complete'    ${TIMEOUT}
    ${source}=    Get Source
    Should Not Contain Any    ${source}
    ...    Fatal error    SQLSTATE    PrestaShopDatabaseException    Stack trace    Parse error    Internal Server Error

# =====================================================================
# Authentification front-office
# =====================================================================
Ouvrir Page Connexion
    Go To    ${URL_LOGIN}
    Wait Until Element Is Visible    ${LOC_LOGIN_FORM}

Se Connecter
    [Arguments]    ${email}    ${mot_de_passe}
    Ouvrir Page Connexion
    Input Text    ${LOC_LOGIN_EMAIL}    ${email}
    Input Password    ${LOC_LOGIN_PASSWORD}    ${mot_de_passe}
    Click Button    ${LOC_LOGIN_SUBMIT}

Se Deconnecter
    Click Element    ${LOC_LOGOUT_LINK}
    Wait Until Page Does Not Contain Element    ${LOC_LOGOUT_LINK}    ${TIMEOUT}

Verifier Utilisateur Connecte
    Wait Until Page Contains Element    ${LOC_LOGOUT_LINK}    ${TIMEOUT}

Verifier Connexion Refusee
    Wait Until Element Is Visible    ${LOC_LOGIN_FORM}    ${TIMEOUT}
    Page Should Not Contain Element    ${LOC_LOGOUT_LINK}

Verifier Page Connexion Affichee
    [Documentation]    Utilise pour les controles d'acces : l'utilisateur doit etre renvoye au formulaire de connexion.
    Wait Until Element Is Visible    ${LOC_LOGIN_FORM}    ${TIMEOUT}
    Page Should Not Contain Element    ${LOC_LOGOUT_LINK}

Tenter Connexion
    [Documentation]    Mot-cle modele (Test Template) : resultat = succes | echec.
    [Arguments]    ${email}    ${mot_de_passe}    ${resultat}
    Se Connecter    ${email}    ${mot_de_passe}
    IF    '${resultat}' == 'succes'
        Verifier Utilisateur Connecte
    ELSE
        Verifier Connexion Refusee
    END
    Verifier Absence Erreur Serveur

# =====================================================================
# Inscription
# =====================================================================
Ouvrir Page Inscription
    Go To    ${URL_REGISTER}
    Wait Until Element Is Visible    ${LOC_REG_FORM}

Inscrire Client
    [Arguments]    ${prenom}    ${nom}    ${email}    ${mot_de_passe}    ${consentement}=oui
    Ouvrir Page Inscription
    Input Text    ${LOC_REG_FIRSTNAME}    ${prenom}
    Input Text    ${LOC_REG_LASTNAME}    ${nom}
    Input Text    ${LOC_REG_EMAIL}    ${email}
    Input Password    ${LOC_REG_PASSWORD}    ${mot_de_passe}
    IF    '${consentement}' == 'oui'
        Cocher Case    customer_privacy
        Cocher Case    psgdpr
    END
    Click Button    ${LOC_REG_SUBMIT}

Creer Compte Client Unique
    [Documentation]    Cree un client avec un email unique et retourne cet email.
    ${email}=    Generer Email Unique
    Inscrire Client    ${CLIENT_PRENOM}    ${CLIENT_NOM}    ${email}    ${CLIENT_PASSWORD}
    Verifier Utilisateur Connecte
    RETURN    ${email}

Verifier Inscription Refusee
    Wait Until Element Is Visible    ${LOC_REG_FORM}    ${TIMEOUT}
    Page Should Not Contain Element    ${LOC_LOGOUT_LINK}
    Alert Should Not Be Present

Tenter Inscription
    [Documentation]    Mot-cle modele : resultat = succes | echec ; email accepte UNIQUE / EXISTANT.
    [Arguments]    ${prenom}    ${nom}    ${email}    ${mot_de_passe}    ${consentement}    ${resultat}
    ${email}=    Resoudre Email    ${email}
    Inscrire Client    ${prenom}    ${nom}    ${email}    ${mot_de_passe}    ${consentement}
    IF    '${resultat}' == 'succes'
        Verifier Utilisateur Connecte
    ELSE
        Verifier Inscription Refusee
    END
    Verifier Absence Erreur Serveur

# =====================================================================
# Recherche, catalogue, formulaire de contact
# =====================================================================
Rechercher
    [Arguments]    ${terme}
    Go To    ${URL}
    Wait Until Element Is Visible    ${LOC_SEARCH_INPUT}    ${TIMEOUT}
    Input Text    ${LOC_SEARCH_INPUT}    ${terme}
    Press Keys    ${LOC_SEARCH_INPUT}    ENTER

Rechercher Et Verifier Robustesse
    [Documentation]    Mot-cle modele : aucune erreur serveur, aucune alerte JavaScript (XSS).
    [Arguments]    ${terme}
    Rechercher    ${terme}
    Verifier Absence Erreur Serveur
    Alert Should Not Be Present

Soumettre Formulaire Contact
    [Arguments]    ${email}    ${message}
    Go To    ${URL_CONTACT}
    Wait Until Element Is Visible    ${LOC_CONTACT_MESSAGE}    ${TIMEOUT}
    Input Text    ${LOC_CONTACT_EMAIL}    ${email}
    Input Text    ${LOC_CONTACT_MESSAGE}    ${message}
    Click Element    ${LOC_CONTACT_SUBMIT}

# =====================================================================
# Produit, panier et tunnel de commande
# =====================================================================
Ouvrir Premier Produit
    Go To    ${URL}
    Wait Until Element Is Visible    ${LOC_PRODUCT_THUMB}    ${TIMEOUT}
    Click Element    ${LOC_PRODUCT_THUMB}
    Wait Until Element Is Visible    ${LOC_ADD_TO_CART}    ${TIMEOUT}

Definir Quantite Produit
    [Arguments]    ${quantite}
    Input Text    ${LOC_QTY_INPUT}    ${quantite}
    Press Keys    ${LOC_QTY_INPUT}    TAB

Ajouter Produit Au Panier
    Wait Until Element Is Enabled    ${LOC_ADD_TO_CART}    ${TIMEOUT}
    Click Button    ${LOC_ADD_TO_CART}
    Wait Until Element Is Visible    ${LOC_CART_MODAL}    ${TIMEOUT}

Ouvrir Page Panier
    Go To    ${URL_CART}

Commander Depuis Le Panier
    Ouvrir Page Panier
    Wait Until Element Is Visible    ${LOC_CART_CHECKOUT_BTN}    ${TIMEOUT}
    Click Element    ${LOC_CART_CHECKOUT_BTN}

Renseigner Adresse Si Necessaire
    [Documentation]    Remplit le formulaire d'adresse s'il est affiche (premiere commande du compte).
    ${formulaire}=    Run Keyword And Return Status
    ...    Wait Until Element Is Visible    ${LOC_ADDR_ADDRESS1}    5s
    IF    ${formulaire}
        Input Text    ${LOC_ADDR_ADDRESS1}    ${ADRESSE_TEST}[ligne1]
        Input Text    ${LOC_ADDR_POSTCODE}    ${ADRESSE_TEST}[code_postal]
        Input Text    ${LOC_ADDR_CITY}    ${ADRESSE_TEST}[ville]
    END
    Wait Until Element Is Visible    ${LOC_CONFIRM_ADDRESSES}    ${TIMEOUT}
    Click Button    ${LOC_CONFIRM_ADDRESSES}

Choisir Livraison
    Wait Until Element Is Visible    ${LOC_CONFIRM_DELIVERY}    ${TIMEOUT}
    Click Button    ${LOC_CONFIRM_DELIVERY}

Payer Et Confirmer
    [Documentation]    Paiement fictif (module de test par defaut), CGV acceptees, commande validee.
    Wait Until Page Contains Element    ${LOC_PAYMENT_OPTION}    ${TIMEOUT}
    Execute JavaScript    document.getElementById('payment-option-1').click();
    Cocher Case    conditions_to_approve[terms-and-conditions]
    Wait Until Element Is Visible    ${LOC_PLACE_ORDER}    ${TIMEOUT}
    Wait Until Element Is Enabled    ${LOC_PLACE_ORDER}    ${TIMEOUT}
    Click Button    ${LOC_PLACE_ORDER}

Verifier Commande Confirmee
    Wait Until Page Contains Element    ${LOC_ORDER_CONFIRMATION}    ${TIMEOUT}

Finaliser Commande
    [Documentation]    Du panier a la page de confirmation (parcours d'achat de bout en bout).
    Commander Depuis Le Panier
    Renseigner Adresse Si Necessaire
    Choisir Livraison
    Payer Et Confirmer
    Verifier Commande Confirmee

# =====================================================================
# Back-office
# =====================================================================
Se Connecter Au Backoffice
    [Arguments]    ${email}    ${mot_de_passe}
    Go To    ${ADMIN_URL}
    Wait Until Element Is Visible    ${LOC_BO_EMAIL}    ${TIMEOUT}
    Input Text    ${LOC_BO_EMAIL}    ${email}
    Input Password    ${LOC_BO_PASSWORD}    ${mot_de_passe}
    Click Button    ${LOC_BO_SUBMIT}

Verifier Backoffice Connecte
    Wait Until Page Contains Element    ${LOC_BO_LOGOUT}    ${TIMEOUT}
    Page Should Not Contain Element    ${LOC_BO_SUBMIT}

Verifier Backoffice Refuse
    Wait Until Element Is Visible    ${LOC_BO_EMAIL}    ${TIMEOUT}
    Page Should Not Contain Element    ${LOC_BO_LOGOUT}

Tenter Connexion Backoffice
    [Documentation]    Mot-cle modele : resultat = succes | echec.
    [Arguments]    ${email}    ${mot_de_passe}    ${resultat}
    Se Connecter Au Backoffice    ${email}    ${mot_de_passe}
    IF    '${resultat}' == 'succes'
        Verifier Backoffice Connecte
    ELSE
        Verifier Backoffice Refuse
    END
    Verifier Absence Erreur Serveur

Naviguer Menu Backoffice
    [Documentation]    Clique sur une entree du menu lateral (ex. subtab-AdminCatalog) et attend un fragment d'URL.
    [Arguments]    ${id_menu}    ${fragment_url}
    Click Element    css:#${id_menu} > a
    Wait Until Location Contains    ${fragment_url}    ${TIMEOUT}

Creer Produit Standard
    [Documentation]    A VALIDER sur l'instance (page produit v2 de PrestaShop 8.1+, selecteurs a confirmer).
    [Arguments]    ${nom}    ${prix}
    Click Element    ${LOC_BO_NEW_PRODUCT}
    Wait Until Element Is Visible    css:.modal.show button.btn-primary    ${TIMEOUT}
    Click Element    css:.modal.show button.btn-primary
    Wait Until Element Is Visible    ${LOC_BO_PRODUCT_NAME}    ${TIMEOUT}
    Input Text    ${LOC_BO_PRODUCT_NAME}    ${nom}
    Input Text    ${LOC_BO_PRODUCT_PRICE}    ${prix}
    Click Button    ${LOC_BO_PRODUCT_SAVE}

Sauvegarder Source Page
    [Documentation]    Enregistre l'URL et le HTML de la page en echec dans results/sources/.
    ${nom}=    Replace String Using Regexp    ${TEST NAME}    [^A-Za-z0-9_-]+    _
    ${adresse}=    Get Location
    ${source}=    Get Source
    Create File    ${OUTPUT DIR}${/}sources${/}${nom}.html    <!-- URL: ${adresse} -->\n${source}