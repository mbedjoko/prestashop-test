# PrestaShop — Projet de test et validation de la sécurité

Environnement de test reproductible pour le rapport *"Rapport de test et validation de la sécurité — PrestaShop"*, combinant tests fonctionnels, analyse statique, scan dynamique et automatisation sur une instance locale de PrestaShop 8.1.7.

## Démarrage rapide

```bash
git clone https://github.com/mbedjoko/prestashop-test.git
cd prestashop-test
git checkout <ta-branche>   # voir le tableau ci-dessous
docker compose up -d
```

| Service | Accès |
|---|---|
| Front-office | http://localhost:8080 |
| Back-office | http://localhost:8080/admin (`admin@test.local` / `PrestaTest123!`) |
| Emails de test (Mailpit) | http://localhost:8025 |
| Jenkins (CI) | http://localhost:8090 |

## Équipe et branches

Chaque membre travaille sur sa propre branche (jamais directement sur `main`, qui est protégée). Le détail des instructions et règles se trouve dans le `README.md` **de chaque branche** et dans [`CONTRIBUTING.md`](CONTRIBUTING.md).

| Branche | Rôle | Responsable | Livrable |
|---|---|---|---|
| `test-manager` | Test Manager | MOUSSENI TAGUE Jessica Estelle | Parties 1, 3, 10 |
| `test-architect` | Test Architect | MEKEME BEDJOKO Michel | Parties 2, 4 |
| `test-analyst` | Test Analyst | MATCHINDA TAKU Alice Beldouce | Partie 5 + grille de tests |
| `qa-securite` | QA / testeur sécurité | MAFOUPI Cerena Shirel | Partie 6 |
| `automation-engineer` | Automation Engineer | MBOUGUEM FOTSO Henri Michel | Partie 7 |
| `defect-manager` | Defect Manager | MAGNI NGOSSI Elvira | Parties 8, 9 |

## Contenu déjà disponible sur `main`

| Fichier | Description |
|---|---|
| `docker-compose.yml` | Environnement complet : PrestaShop, MySQL, Mailpit, Jenkins |
| `Rapport_PrestaShop_TestArchitect.docx` | Parties 2 et 4 rédigées |
| `semgrep-report.json` / `.txt` | Analyse statique complète (407 findings) |
| `semgrep-errors-only.json` | Findings critiques (43 ERROR) à vérifier — pour le QA |
| `zap/zap-report.html` / `.json` | Scan dynamique OWASP ZAP (448 URLs, 16 WARN) |
| `CONTRIBUTING.md` | Règles de contribution et workflow Git |

## Règles essentielles

- **Jamais de push direct sur `main`** — passe par une Pull Request.
- **N'inclus pas ton `README.md` de branche dans une PR vers `main`** — il est spécifique à ton rôle et reste sur ta branche.
- Toute anomalie doit être accompagnée d'une preuve et d'un identifiant de cas de test.

Voir [`CONTRIBUTING.md`](CONTRIBUTING.md) pour le détail complet du workflow.
