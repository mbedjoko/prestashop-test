# Branche `defect-manager` — Defect Manager

**Responsable :** MAGNI NGOSSI Elvira

## Tes livrables
- **Partie 8** — Résultats et gestion des anomalies : registre des anomalies (identifiant, sévérité, priorité, preuve, statut), statistiques, retests.
- **Partie 9** — Risques et recommandations (avec le QA) : risques classés par criticité, correctifs proposés, risques résiduels.

## D'où viennent tes anomalies
1. **Du Test Analyst** (branche `test-analyst`) : les cas de test fonctionnels en échec (grille de la Partie 5).
2. **Du QA/testeur sécurité** (branche `qa-securite`) : les findings Semgrep/ZAP **confirmés manuellement** (pas les findings bruts — seulement ceux que le QA a vérifiés comme vrais positifs). Voir en particulier les pistes prioritaires listées dans son README : injection SQL potentielle (`Product.php`), `eval-use`, `exec-use`, absence de jetons CSRF, etc.

## Format suggéré pour le registre d'anomalies (Partie 8)
| ID | Description | Sévérité | Priorité | Preuve | Statut | Testeur | Date | Retest |
|---|---|---|---|---|---|---|---|---|

Sévérités suggérées : Bloquant / Majeur / Mineur / Cosmétique.

## Exemple à citer en Partie 9 (méthodologie anti-faux-positifs)
Lors de la mise en place de l'environnement, le test "mot de passe oublié" montrait d'abord un comportement incohérent (message d'erreur différent selon que l'email existait ou non), ce qui ressemblait à une faille d'énumération de comptes. Vérification faite : c'était dû au mode démo de PrestaShop (actif par défaut dans l'image Docker) qui bloquait l'envoi réel des e-mails. Une fois corrigé, le comportement était identique et sécurisé dans les deux cas. **Ce n'était donc pas une anomalie réelle** — bon exemple à citer pour illustrer la rigueur de vérification avant de consigner une anomalie (risque "faux positifs des outils automatiques" identifié dans la stratégie de test).

## Pour la Partie 9 — Risques
Reprends la logique de criticité déjà définie dans la stratégie de test :
1. Authentification et sessions
2. Back-office (contrôle des droits)
3. Commande et paiement
4. Formulaires publics et recherche
5. Catalogue

Croise cet ordre avec les anomalies réellement confirmées pour prioriser les recommandations de correctifs.

## Environnement (si tu as besoin de reproduire une anomalie)
```bash
git clone https://github.com/mbedjoko/prestashop-test.git
cd prestashop-test && git checkout defect-manager
docker compose up -d
```

## Workflow
Voir `CONTRIBUTING.md` — branche, commits, Pull Request vers `main` quand ta partie est prête.
