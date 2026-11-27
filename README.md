# Branche `test-manager` — Test Manager

**Responsable :** MOUSSENI TAGUE Jessica Estelle

## Tes livrables
- **Partie 1** — Introduction et contexte (enjeux du test et de la sécurité logicielle, objectifs du devoir, présentation de l'équipe)
- **Partie 3** — Périmètre et stratégie de test (une base existe déjà dans le document de cadrage original : cible, in/out scope, types de tests, approche, critères d'entrée/sortie — à reprendre et adapter avec les résultats réels)
- **Partie 10** — Conclusion et annexes (bilan, limites du test, captures d'écran, scripts, grille complète des cas de test)

## Ce que tu dois en plus faire
1. **Assembler le rapport final** : récupérer le contenu des 6 branches (une Pull Request par rôle), dans l'ordre des parties 1 à 10, harmoniser la mise en forme (le Test Architect a utilisé Times New Roman, noir sur blanc — garder cette cohérence pour tout le document).
2. **Approuver les Pull Requests** des autres membres vers `main` (la branche est protégée : 1 revue obligatoire avant fusion).
3. **Suivre le planning** :
   - Vendredi 27 : exécution complète par chaque rôle, anomalies consignées.
   - Samedi 28 (matin) : assemblage du rapport.
   - Dimanche 29 (avant midi) : relecture croisée, corrections de forme uniquement, envoi.

## Déjà disponible dans le dépôt
- `Rapport_PrestaShop_TestArchitect.docx` — Parties 2 et 4 déjà rédigées (Test Architect).
- `CONTRIBUTING.md` — règles de l'équipe, tableau rôles/branches/noms.
- `semgrep-errors-only.json`, `zap-report.html` — matière pour la Partie 6 (à récupérer une fois complétée par le QA).

## Workflow
1. `git pull origin test-manager`
2. Rédige ta partie (fichier `rapport/partie-1-introduction.docx`, `rapport/partie-3-perimetre.docx`, `rapport/partie-10-conclusion.docx`, par exemple).
3. `git add` puis `git commit` avec un message clair.
4. `git push origin test-manager`
5. Ouvre une Pull Request vers `main` — voir `CONTRIBUTING.md` pour le détail des règles.
