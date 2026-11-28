*** Settings ***
Documentation     Variables globales du projet. Toute valeur peut etre surchargee
...               en ligne de commande : robot --variable URL:http://localhost:8081 tests

*** Variables ***
# ---------- Cible ----------
${URL}                 http://localhost:8080
${ADMIN_URL}           ${URL}/admin
${URL_LOGIN}           ${URL}/index.php?controller=authentication
${URL_REGISTER}        ${URL}/index.php?controller=registration
${URL_ACCOUNT}         ${URL}/index.php?controller=my-account
${URL_CART}            ${URL}/index.php?controller=cart&action=show
${URL_CONTACT}         ${URL}/index.php?controller=contact

# ---------- Navigateur ----------
${BROWSER}             chrome
${HEADLESS}            False
${TIMEOUT}             15s

# ---------- Compte administrateur (cf. docker-compose.yml) ----------
${ADMIN_EMAIL}         admin@test.local
${ADMIN_PASSWORD}      PrestaTest123!

# ---------- Donnees de test client ----------
# CLIENT_EMAIL est calcule a l'execution (compte cree par la suite) : valeur par defaut vide.
${CLIENT_EMAIL}        ${EMPTY}
${CLIENT_PRENOM}       Jean
${CLIENT_NOM}          Dupont
${CLIENT_PASSWORD}     Rf!Test2026#Secure
&{ADRESSE_TEST}        ligne1=12 rue de la Paix    code_postal=75002    ville=Paris

# ---------- Donnees de test recherche ----------
${TERME_RECHERCHE}     mug
${CHAINE_LONGUE}       ${{ 'A' * 1000 }}

# Delai entre actions (secondes), ex. 0.7 pour filmer
${SPEED}               0
