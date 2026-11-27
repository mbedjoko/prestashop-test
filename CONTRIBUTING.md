# Règles de contribution — Projet PrestaShop

## Règle n°1 — Jamais de push direct sur `main`
La branche `main` est protégée : toute modification doit passer par une Pull Request (PR),
relue et approuvée avant fusion.

## Règle n°2 — Une branche par personne / par rôle
Travaille uniquement sur ta branche :

| Branche              | Rôle                    | Nom                                  |
|-----------------------|-------------------------|----------------------------------------|
| `test-manager`        | Test Manager            | MOUSSENI TAGUE Jessica Estelle          |
| `test-architect`      | Test Architect          | MEKEME BEDJOKO Michel                   |
| `test-analyst`        | Test Analyst            | MATCHINDA TAKU Alice Beldouce           |
| `qa-securite`         | QA / testeur sécurité   | MAFOUPI Cerena Shirel                   |
| `automation-engineer` | Automation Engineer     | MBOUGUEM FOTSO Henri Michel             |
| `defect-manager`      | Defect Manager          | MAGNI NGOSSI Elvira                     |

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
