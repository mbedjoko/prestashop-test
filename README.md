# Branche `qa-securite` — QA / testeur sécurité

**Responsable :** MAFOUPI Cerena Shirel

## Ton livrable
- **Partie 6** — Tests de sécurité : analyse statique du code, scan dynamique, attaques manuelles (SQLi, XSS, authentification, sessions, droits), fuzzing.

## Déjà fourni par le Test Architect (Partie 4) — à vérifier, pas à prendre pour argent comptant
Deux rapports bruts t'attendent à la racine du dépôt :
- `semgrep-report.json` / `semgrep-report.txt` — analyse statique complète (407 findings : 43 ERROR, 361 WARNING, 3 INFO)
- `semgrep-errors-only.json` — uniquement les 43 findings ERROR, pour aller droit à l'essentiel
- `zap/zap-report.html` / `zap/zap-report.json` — scan dynamique passif (448 URLs, 52 PASS, 16 WARN, 0 FAIL)

**Important** : ce sont des résultats d'outils automatiques, pas des anomalies confirmées. Conformément à la stratégie de test (risque de faux positifs), chaque finding doit être **vérifié manuellement** avant d'être consigné comme anomalie réelle.

## Pistes prioritaires à vérifier manuellement
| Finding Semgrep | Fichier | Pourquoi c'est intéressant |
|---|---|---|
| `tainted-sql-string` | `classes/Product.php:6422, 6428, 6439` | Candidat sérieux à une injection SQL — priorité haute |
| `eval-use` | `classes/module/Module.php`, `classes/PrestaShopAutoload.php` | Risque d'exécution de code arbitraire |
| `exec-use` | `classes/ImageManager.php` | Risque d'injection de commande (traitement d'images) |
| `md5-loose-equality` | `Cookie.php`, `Upgrader.php`, `FrontController.php` | Faille classique de comparaison de type PHP (`==` au lieu de `===`) |

| Finding ZAP | Détail |
|---|---|
| Vulnerable JS Library | `jquery-ui.min.js` — vérifier la version et les CVE associées |
| Apache HTTP Server Version with Known Vulnerabilities | Version Apache embarquée avec CVE connues |
| Absence of Anti-CSRF Tokens | Sur plusieurs pages du front-office |
| Headers manquants | CSP, X-Content-Type-Options, anti-clickjacking |

## Tests manuels à mener toi-même
- **Contournement de droits back-office** : un compte employé à profil restreint ("Commercial") a déjà été créé pour les tests. Vérifier si, en tapant directement une URL d'administration sensible (ex. gestion des employés, gestionnaire SQL), ce compte peut accéder à des fonctions qui ne lui sont pas censées être autorisées malgré le menu qui les masque.
- **Injection SQL / XSS** sur les formulaires publics (recherche, contact, inscription) et sur les paramètres d'URL.
- **Fuzzing** des champs de saisie (valeurs aléatoires/malformées) — outil suggéré : ZAP fuzzer ou script Python, selon le rapport de cadrage original.
- Utiliser **Burp Community** (recommandé dans le document de cadrage) pour intercepter/modifier les requêtes et contourner les validations côté client.

## Environnement
```bash
git clone https://github.com/mbedjoko/prestashop-test.git
cd prestashop-test && git checkout qa-securite
docker compose up -d
```
Front-office : http://localhost:8080 — Back-office : http://localhost:8080/admin (`admin@test.local` / `PrestaTest123!`)

## Workflow
Voir `CONTRIBUTING.md` — branche, commits, Pull Request vers `main` quand ta partie est prête. Transmets aussi tes anomalies confirmées au Defect Manager (branche `defect-manager`) avec preuve et sévérité proposée.
