# Branche `automation-engineer` — Automation Engineer

**Responsable :** MBOUGUEM FOTSO Henri Michel

## Ton livrable
- **Partie 7** — Automatisation : scripts Robot Framework, parcours automatisés, rapports `log.html` et `report.html`.

## Outils déjà fournis par le Test Architect (Partie 4)
- **Jenkins** (LTS, v2.580.3) : `http://localhost:8090`
  - Plugins installés : suite standard (Git, GitHub, Pipeline) + **HTML Publisher** (pour afficher `report.html`/`log.html` comme résultat de build)
  - Connecté au réseau Docker `prestashop-test_prestashop_net`
  - Socket Docker monté (`/var/run/docker.sock`) si tu as besoin de lancer des conteneurs depuis un job
  - Identifiants admin : à récupérer auprès du Test Architect (pas stockés dans le dépôt)

## ⚠️ Piège réseau important
PrestaShop redirige automatiquement toute requête vers son domaine configuré (`PS_DOMAIN=localhost:8080`). Si un script ou un job Jenkins cible l'application par le nom du conteneur (`http://prestashop_app:80`), la redirection vers `localhost:8080` casse la requête (ça nous a fait perdre du temps avec ZAP). Solutions :
- Cibler **`http://localhost:8080`** directement.
- Si le job tourne dans un conteneur, le lancer en mode réseau **`host`** (comme on l'a fait pour ZAP : `docker run --network host ...`).
- Ou exécuter les scripts Robot Framework directement depuis l'agent Jenkins sur la machine hôte plutôt que dans un conteneur isolé.

## Ce qu'il te reste à faire (pas encore fait par le Test Architect)
1. **Installer Robot Framework + SeleniumLibrary** (ex. dans un environnement virtuel Python, ou dans l'agent Jenkins) :
   ```bash
   python3 -m venv venv && source venv/bin/activate
   pip install robotframework robotframework-seleniumlibrary
   ```
2. **Écrire les scripts `.robot`** pour les parcours critiques identifiés dans la stratégie de test :
   - Connexion / inscription
   - Panier → commande → paiement fictif → confirmation
   - Formulaires et remises (codes promo)
3. **Configurer le pipeline Jenkins** : récupérer le code depuis ce dépôt, exécuter les scripts Robot Framework, publier `log.html`/`report.html` via le plugin HTML Publisher.
4. **Documenter** dans ta Partie 7 : scripts utilisés, parcours couverts, résultats d'exécution.

## Environnement PrestaShop
```bash
git clone https://github.com/mbedjoko/prestashop-test.git
cd prestashop-test && git checkout automation-engineer
docker compose up -d
```
Front-office : http://localhost:8080 — Back-office : http://localhost:8080/admin (`admin@test.local` / `PrestaTest123!`)

## Workflow
Voir `CONTRIBUTING.md` — branche, commits, Pull Request vers `main` quand ta partie est prête.
