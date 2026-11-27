# Branche `test-architect` — Test Architect

**Responsable :** MEKEME BEDJOKO Michel

## Tes livrables — déjà complétés sur `main`
- **Partie 2** — Présentation de la cible
- **Partie 4** — Environnement et outils

Le texte rédigé se trouve dans `Rapport_PrestaShop_TestArchitect.docx` (déjà sur `main`).

## Récapitulatif de ce qui a été livré à l'équipe
| Élément | Détail |
|---|---|
| Environnement Docker | `docker-compose.yml` : PrestaShop 8.1.7, MySQL 8.0, Mailpit (SMTP de test), Jenkins LTS |
| Versions documentées | PHP 8.1.34, MySQL 8.0.46, Apache 2.4.65 |
| Jeux de données | 19 produits en base, compte client + compte employé restreint créés |
| Analyse statique | Semgrep — `semgrep-report.json`/`.txt`, `semgrep-errors-only.json` (43 ERROR extraits pour le QA) |
| Scan dynamique | OWASP ZAP — `zap/zap-report.html`/`.json` (448 URLs, 16 WARN) |
| Intégration continue | Jenkins sur `http://localhost:8090`, fourni pour l'Automation Engineer |
| Gestion de configuration | Dépôt Git public, protection de `main`, une branche par rôle, `CONTRIBUTING.md` |

## Reste à faire côté Test Architect
- Suivre la demande de restriction d'accès en attente (public vs privé — décision à trancher).
- Rester disponible pendant la semaine si l'environnement partagé tombe en panne (risque identifié en Partie 7 du document de cadrage).
- Retrouver les comptes GitHub de MAFOUPI Cerena Shirel et MAGNI NGOSSI Elvira pour les inviter comme collaboratrices.

## Workflow
Voir `CONTRIBUTING.md` — branche, commits, Pull Request vers `main`.
