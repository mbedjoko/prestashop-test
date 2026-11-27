# Règles de contribution — Projet PrestaShop

## Règle n°1 — Jamais de push direct sur `main`
La branche `main` est protégée : toute modification doit passer par une Pull Request (PR),
relue et fusionnée par le Test Manager (ou le Test Architect en son absence).

## Règle n°2 — Une branche par rôle
Travaille uniquement sur la branche correspondant à ton rôle :

| Branche              | Rôle                  | Livrable attendu                          |
|----------------------|-----------------------|--------------------------------------------|
| `test-manager`       | Test Manager           | Parties 1, 3, 10 + assemblage final        |
| `test-architect`     | Test Architect         | Parties 2 et 4 (déjà fournies sur `main`)  |
| `test-analyst`       | Test Analyst            | Partie 5 + grille des cas de test          |
| `automation-engineer`| Automation Engineer    | Partie 7 + scripts Robot Framework/Jenkins |
| `qa-securite`        | QA / testeur sécurité  | Partie 6 (voir semgrep-errors-only.json et zap-report.html) |
| `defect-manager`     | Defect Manager         | Parties 8 et 9                             |

## Règle n°3 — Workflow
1. `git checkout <ta-branche>`
2. `git pull origin <ta-branche>`
3. Travaille, commite régulièrement avec des messages clairs.
4. `git push origin <ta-branche>`
5. Ouvre une Pull Request vers `main` sur GitHub quand ta partie est prête.
6. N'auto-fusionne pas ta propre PR — attends la relecture.

## Règle n°4 — Organisation des fichiers
Place le contenu de ta partie dans un fichier `rapport/partie-X-<nom>.docx` ou `.md`
pour que l'assemblage final soit simple.

## Règle n°5 — Preuves et reproductibilité
Toute anomalie signalée doit être accompagnée d'une preuve (capture, log) et d'un numéro
de cas de test (grille de la Partie 5), conformément à la stratégie définie en Partie 3.
