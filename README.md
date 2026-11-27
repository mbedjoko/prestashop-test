# Branche `test-analyst` — Test Analyst

**Responsable :** MATCHINDA TAKU Alice Beldouce

## Ton livrable
- **Partie 5** — Tests fonctionnels (boîte noire) : cas de test par partition d'équivalence, valeurs limites, tables de décision, transitions d'état, cas d'utilisation.
- **La grille complète des cas de test** (annexe, réutilisée en Partie 10).

## Zones à couvrir, par ordre de priorité
1. Authentification et gestion des sessions (inscription, connexion, récupération de mot de passe)
2. Back-office — **uniquement l'aspect fonctionnel** (ex. : un admin peut-il créer/modifier un produit correctement ? formulaire bien validé ?). Le contournement de droits / sécurité relève du QA (Partie 6), pas de toi.
3. Commande et paiement (panier, paiement fictif, cycle de vie de la commande)
4. Formulaires publics et recherche
5. Affichage du catalogue

## Techniques à appliquer selon la zone
| Zone | Technique |
|---|---|
| Authentification | Partition d'équivalence + valeurs limites |
| Back-office (fonctionnel) | Partition d'équivalence + table de décision |
| Commande | Transitions d'état + table de décision (codes promo) |
| Formulaires publics | Partition + valeurs limites |
| Catalogue | Cas d'utilisation |

## Déjà fait (point de départ, à reprendre dans ta grille)
La zone **Authentification** a déjà été explorée avec le Test Architect pendant la mise en place de l'environnement. Résultats (tous conformes, à formaliser dans ta grille officielle) :

| ID | Cas | Technique | Résultat |
|---|---|---|---|
| TA-AUTH-01 | Inscription, champ vide | Partition | Pass (validation navigateur — à faire revérifier côté serveur par le QA) |
| TA-AUTH-02 | Inscription, email invalide | Partition | Pass (idem) |
| TA-AUTH-03 | Inscription, mot de passe trop court | Valeurs limites | Pass (min 8 car. + score fort exigé) |
| TA-AUTH-04 | Inscription, CGU non cochées | Partition | Pass |
| TA-AUTH-05 | Inscription valide | Cas nominal | Pass |
| TA-AUTH-06 | Connexion, email inconnu | Partition | Pass (message générique) |
| TA-AUTH-07 | Connexion, mauvais mot de passe | Partition | Pass (même message que 06, pas d'énumération) |
| TA-AUTH-08 | Connexion valide | Cas nominal | Pass |
| TA-AUTH-09 | Mdp oublié, email existant | Partition | Pass |
| TA-AUTH-10 | Mdp oublié, email inexistant | Partition | Pass (aucun email envoyé, pas d'énumération) |

**Remarque méthodologique** : au départ, le test du mot de passe oublié montrait une incohérence (message d'erreur différent selon l'email). Vérification faite : c'était dû au mode démo de PrestaShop qui bloquait l'envoi d'e-mails dans l'environnement de test, pas un vrai bug. Une fois le mode démo désactivé, le comportement était identique dans les deux cas. Bon exemple à citer en Partie 9 (risque de faux positif, vérifié avant d'être écarté).

## Environnement
```bash
git clone https://github.com/mbedjoko/prestashop-test.git
cd prestashop-test && git checkout test-analyst
docker compose up -d
```
- Front-office : http://localhost:8080
- Back-office : http://localhost:8080/admin (`admin@test.local` / `PrestaTest123!`)
- Emails de test (Mailpit) : http://localhost:8025

## Workflow
Voir `CONTRIBUTING.md` — branche, commits, Pull Request vers `main` quand ta partie est prête.
