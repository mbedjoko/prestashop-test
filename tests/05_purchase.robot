*** Settings ***
Documentation     Parcours d'achat : recherche, panier, commande et paiement fictif.
...               Techniques : cas d'utilisation (parcours complet), valeurs limites (quantite),
...               transitions d'etat du panier (plein -> vide).
Resource          ../resources/keywords.resource
Suite Setup       Initialiser Suite Avec Compte Client
Suite Teardown    Fermer Navigateur
Test Setup        Preparer Test
Test Teardown     Terminer Test
Test Tags         achat    front-office

*** Test Cases ***
PUR-01 Parcours d'achat complet avec paiement fictif
    [Documentation]    Connexion -> produit -> panier -> adresse -> livraison -> paiement -> confirmation.
    [Tags]    smoke    critique    cas-d-utilisation
    Se Connecter    ${CLIENT_EMAIL}    ${CLIENT_PASSWORD}
    Verifier Utilisateur Connecte
    Ouvrir Premier Produit
    Ajouter Produit Au Panier
    Finaliser Commande

PUR-02 Recherche puis ajout au panier
    [Tags]    smoke
    Rechercher    ${TERME_RECHERCHE}
    Wait Until Element Is Visible    ${LOC_PRODUCT_THUMB}    ${TIMEOUT}
    Click Element    ${LOC_PRODUCT_THUMB}
    Wait Until Element Is Visible    ${LOC_ADD_TO_CART}    ${TIMEOUT}
    Ajouter Produit Au Panier

PUR-03 Panier vide
    [Tags]    transitions-etat
    Ouvrir Page Panier
    Wait Until Element Is Visible    ${LOC_CART_EMPTY}    ${TIMEOUT}

PUR-04 Quantite superieure au stock disponible
    [Documentation]    Resultat attendu a confirmer avec le Test Analyst : ajout au panier bloque.
    [Tags]    valeurs-limites
    Ouvrir Premier Produit
    Definir Quantite Produit    999999
    Wait Until Keyword Succeeds    10s    1s    Element Should Be Disabled    ${LOC_ADD_TO_CART}

PUR-05 Suppression de l'unique article du panier
    [Tags]    transitions-etat
    Ouvrir Premier Produit
    Ajouter Produit Au Panier
    Ouvrir Page Panier
    Wait Until Element Is Visible    ${LOC_CART_REMOVE}    ${TIMEOUT}
    Click Element    ${LOC_CART_REMOVE}
    Wait Until Element Is Visible    ${LOC_CART_EMPTY}    ${TIMEOUT}

PUR-06 Commande impossible avec un panier vide
    [Tags]    transitions-etat    controle-acces
    Se Connecter    ${CLIENT_EMAIL}    ${CLIENT_PASSWORD}
    Verifier Utilisateur Connecte
    Ouvrir Page Panier
    Wait Until Element Is Visible    ${LOC_CART_EMPTY}    ${TIMEOUT}
    Page Should Not Contain Element    ${LOC_CART_CHECKOUT_BTN}
