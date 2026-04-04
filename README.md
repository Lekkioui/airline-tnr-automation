# ✈ AirLine TNR Automation

![CI](https://github.com/Lekkioui/airline-tnr-automation/actions/workflows/tests.yml/badge.svg)
![Robot Framework](https://img.shields.io/badge/Robot%20Framework-6.1.1-brightgreen)
![Python](https://img.shields.io/badge/Python-3.10-blue)
![Selenium](https://img.shields.io/badge/Selenium-4.8.2-yellow)
![Robocop](https://img.shields.io/badge/Robocop-0%20issues-success)

> Projet de fin d'études — Mise en place d'une solution d'automatisation des tests de non-régression (TNR) avec Robot Framework, intégrée dans une chaîne d'intégration continue via GitHub Actions et publication automatique des résultats dans Xray.

**Auteur :** Anasse Lekkioui  
**École :** EMSI - École Marocaine des Sciences de l'Ingénieur  

---

## Table des matières

- [Présentation du projet](#présentation-du-projet)
- [Application testée](#application-testée)
- [Architecture du projet](#architecture-du-projet)
- [Stack technique](#stack-technique)
- [Prérequis](#prérequis)
- [Installation](#installation)
- [Lancer les tests](#lancer-les-tests)
- [Pipeline CI/CD](#pipeline-cicd)
- [Couverture des tests](#couverture-des-tests)
- [Pattern Page Object Model](#pattern-page-object-model)
- [Variables centralisées](#variables-centralisées)
- [Qualité du code — Robocop](#qualité-du-code--robocop)
- [Tests responsive](#tests-responsive)
- [Intégration Xray](#intégration-xray)
- [Structure des fichiers](#structure-des-fichiers)

---

## Présentation du projet

Ce projet met en place une solution complète d'automatisation des tests de non-régression pour une application web Django de gestion de vols aériens. Il couvre l'ensemble de la chaîne qualité :

- **Automatisation des tests UI** avec Robot Framework et SeleniumLibrary
- **Pattern Page Object Model (POM)** pour une architecture maintenable
- **Variables centralisées** pour éviter la duplication des sélecteurs et données
- **Pipeline CI/CD** avec GitHub Actions qui exécute les tests à chaque push
- **Lint du code de test** avec Robocop pour garantir la qualité
- **Tests responsive** sur mobile, tablette et desktop
- **Publication des résultats** dans Xray (Jira)

---

## Application testée

L'application **AirLine** est une application Django de gestion de vols aériens.

**Repo Django :** [airline-django](https://github.com/Lekkioui/airline-django)

### Fonctionnalités couvertes par les tests

| Fonctionnalité | Description |
|---|---|
| Liste des vols | Affichage de tous les vols disponibles |
| Détail d'un vol | Informations complètes, capacité, statut |
| Ajout de passager | Formulaire avec validation (email, passport, classe) |
| Suppression de passager | Retrait d'un passager d'un vol |
| Profil passager | Affichage des informations et vols d'un passager |
| Recherche de vols | Filtres par origine, destination, statut |
| Changement de statut | Transitions SCHEDULED → BOARDING → DEPARTED / CANCELLED |
| Authentification | Login, logout, redirection |

---

## Architecture du projet
airline-automation/
├── .github/
│   └── workflows/
│       └── tests.yml          # Pipeline CI/CD GitHub Actions
├── pages/                     # Page Objects (POM)
│   ├── flights_page.resource
│   ├── flight_details_page.resource
│   ├── passenger_page.resource
│   ├── search_page.resource
│   ├── status_page.resource
│   ├── users_page.resource
│   └── responsive_page.resource
├── resources/                 # Ressources partagées
│   ├── common.resource        # Keywords communs + configuration Chrome
│   └── variables.resource     # Variables centralisées (URLs, sélecteurs, données)
├── tests/                     # Suites de tests
│   ├── test_flights.robot
│   ├── test_add_passenger.robot
│   ├── test_passenger.robot
│   ├── test_search.robot
│   ├── test_status.robot
│   ├── test_users.robot
│   └── test_responsive.robot
├── results/                   # Rapports générés (gitignored)
│   └── screenshots/           # Screenshots responsive
├── requirements.txt
└── README.md

---

## Stack technique

| Outil | Version | Rôle |
|---|---|---|
| Robot Framework | 6.1.1 | Framework de test |
| SeleniumLibrary | 6.1.0 | Automatisation navigateur |
| Selenium | 4.8.2 | Driver navigateur |
| Robocop | 5.6.0 | Lint du code Robot |
| Python | 3.10 | Langage |
| Django | 4.2.7 | Application testée |
| GitHub Actions | — | Pipeline CI/CD |
| Xray | — | Gestion des résultats *(à venir)* |

---

## Prérequis

- Python 3.10+
- Google Chrome installé
- ChromeDriver compatible avec votre version de Chrome
- Git

---

## Installation

### 1. Cloner le repo d'automatisation
```bash
git clone https://github.com/Lekkioui/airline-tnr-automation.git
cd airline-tnr-automation
```

### 2. Installer les dépendances Python
```bash
pip install -r requirements.txt
```

### 3. Cloner et configurer le projet Django
```bash
git clone https://github.com/Lekkioui/airline-django.git ../airline-django
cd ../airline-django
python -m venv venv

# Windows
venv\Scripts\activate

# Linux / macOS
source venv/bin/activate

pip install django
python manage.py migrate
python manage.py setup_test_data
python manage.py runserver
```

---

## Lancer les tests

### Tous les tests
```bash
python -m robot --outputdir results tests/
```

### Une suite spécifique
```bash
python -m robot --outputdir results tests/test_flights.robot
python -m robot --outputdir results tests/test_add_passenger.robot
python -m robot --outputdir results tests/test_search.robot
python -m robot --outputdir results tests/test_passenger.robot
python -m robot --outputdir results tests/test_status.robot
python -m robot --outputdir results tests/test_users.robot
python -m robot --outputdir results tests/test_responsive.robot
```

### Lint avec Robocop
```bash
python -m robocop --reports all tests/ pages/ resources/
```

### Réinitialiser les données de test
```bash
# Windows
..\airline-django\venv\Scripts\python.exe ..\airline-django\manage.py setup_test_data

# Linux / macOS
python ../airline-django/manage.py setup_test_data
```

---

## Pipeline CI/CD

Le pipeline GitHub Actions s'exécute automatiquement à chaque `push` ou `pull_request` sur la branche `main`.

### Jobs
push / pull_request
│
▼
┌─────────┐
│  lint   │  ← Robocop analyse la qualité du code Robot
└────┬────┘
│ needs: lint
▼
┌─────────┐
│  test   │  ← Clone Django, migrate, setup_test_data, lance les tests
└─────────┘
│
▼
Upload artifacts (report.html, log.html, output.xml)

### Fonctionnalités du pipeline

- **Cache pip** — les dépendances sont mises en cache selon le hash de `requirements.txt`
- **Job lint** — Robocop vérifie la qualité du code avant les tests
- **Job test** — dépend du job lint (`needs: lint`)
- **Chrome headless** — les tests tournent sans interface graphique
- **Artifacts** — les rapports HTML sont téléchargeables après chaque run

---

## Couverture des tests

| Suite | Fichier | Nombre de tests |
|---|---|---|
| Liste et détail des vols | `test_flights.robot` | 7 |
| Gestion des passagers | `test_add_passenger.robot` | 13 |
| Profil passager | `test_passenger.robot` | 10 |
| Recherche de vols | `test_search.robot` | 12 |
| Changement de statut | `test_status.robot` | 11 |
| Authentification | `test_users.robot` | 3 |
| Responsive design | `test_responsive.robot` | 11 |
| **Total** | | **67 tests** |

### Types de tests couverts

- **Tests fonctionnels** — vérification des fonctionnalités métier
- **Tests négatifs** — validation des erreurs (email doublon, passport invalide, champs vides)
- **Tests de navigation** — liens, redirections, retour arrière
- **Tests de données** — vérification de l'affichage des données correctes
- **Tests de workflow** — transitions de statut, séquences d'actions
- **Tests responsive** — rendu sur mobile (375px), tablette (768px) et desktop (1920px)

---

## Pattern Page Object Model

Le projet applique le **Page Object Model (POM)** — standard industriel en test automation.

### Principe
┌─────────────────────────────────────────────┐
│              Tests (.robot)                 │
│  "Ce qu'on teste"                           │
│  test_flights.robot, test_search.robot...   │
└──────────────────┬──────────────────────────┘
│ utilise
┌──────────────────▼──────────────────────────┐
│           Page Objects (.resource)          │
│  "Comment on interagit avec les pages"      │
│  flights_page, flight_details_page...       │
└──────────────────┬──────────────────────────┘
│ utilise
┌──────────────────▼──────────────────────────┐
│           Resources partagées               │
│  common.resource — keywords communs         │
│  variables.resource — sélecteurs, URLs      │
└─────────────────────────────────────────────┘

### Avantages

- **Maintenabilité** — si un sélecteur change dans le HTML, on ne modifie que le fichier page concerné
- **Réutilisabilité** — les keywords sont réutilisés dans plusieurs suites de tests
- **Lisibilité** — les tests lisent comme des scénarios métier
- **Séparation des responsabilités** — la logique de navigation est séparée de la logique de test

---

## Variables centralisées

Toutes les URLs, sélecteurs CSS et données de test sont centralisés dans `resources/variables.resource`.

### Exemple
```robotframework
# URLs
${FLIGHTS_URL}     http://127.0.0.1:8000/flights/
${LOGIN_URL}       http://127.0.0.1:8000/users/login

# Sélecteurs
${SEL_FLIGHT_LINK}       css:[data-test='flight-details-link']
${SEL_PASSENGER_LIST}    css:[data-testid='passenger-list']

# Données de test
${PASSENGER_EMAIL_ECONOMY}      john@test.com
${PASSENGER_PASSPORT_ECONOMY}   JD123456

# Timeouts
${DEFAULT_TIMEOUT}    10s
${LONG_TIMEOUT}       30s
```

### Avantage

Si l'URL de base change (ex: passage en production), une seule modification dans `variables.resource` suffit pour mettre à jour tous les tests.

---

## Qualité du code — Robocop

[Robocop](https://robocop.readthedocs.io/) est un outil de lint statique pour Robot Framework.

### Résultat
Processed 9 files but no issues were found.
Found 0 issues.

### Règles appliquées

| Règle | Description |
|---|---|
| `missing-doc-keyword` | Chaque keyword doit avoir une documentation |
| `missing-doc-suite` | Chaque suite doit avoir une documentation |
| `deprecated-statement` | `[Return]` remplacé par `RETURN`, `Run Keyword If` remplacé par `IF` |
| `empty-lines-between-sections` | 2 lignes vides entre les sections |
| `missing-trailing-blank-line` | Ligne vide en fin de fichier |
| `can-be-resource-file` | Fichiers sans tests renommés en `.resource` |
| `too-many-calls-in-keyword` | Maximum 10 appels par keyword |

---

## Tests responsive

Les tests responsive vérifient que l'application s'affiche correctement sur trois viewports.

| Viewport | Dimensions | Usage |
|---|---|---|
| Mobile | 375 x 812 px | iPhone SE / standard mobile |
| Tablet | 768 x 1024 px | iPad / tablette standard |
| Desktop | 1920 x 1080 px | Écran Full HD |

### Pages testées

- Page liste des vols
- Page détail d'un vol
- Page recherche
- Bouton Add Passenger

### Screenshots

Les screenshots sont sauvegardés automatiquement dans `results/screenshots/` avec des noms explicites :
results/screenshots/
├── flights_mobile.png
├── flights_tablet.png
├── flights_desktop.png
├── flight_detail_mobile.png
├── flight_detail_tablet.png
├── flight_detail_desktop.png
├── search_mobile.png
├── search_tablet.png
└── search_desktop.png

---

## Intégration Xray

> **Statut : À venir** — En attente des accès Jira

### Plan d'intégration

**Xray** est un plugin de gestion de tests pour Jira qui permet de lier les tests automatisés aux cas de test Jira, gérer les campagnes de tests et tracer la couverture des exigences.

### Architecture prévue
Robot Framework
│
│ génère output.xml
▼
GitHub Actions
│
│ POST /rest/raven/1.0/import/execution/robot
▼
Xray (Jira)
│
▼
Tableau de bord des résultats
Traçabilité exigences ↔ tests
Historique des campagnes

### Étapes d'intégration prévues

1. Créer les cas de test dans Jira avec les IDs correspondants
2. Ajouter les tags Xray dans les fichiers Robot Framework :
```robotframework
Add Economy Passenger
    [Tags]    AIRLINE-1
    [Documentation]    Vérifie qu'on peut ajouter un passager en classe Economy.
    Open Flights Page
    ...
```
3. Configurer les credentials Xray dans les secrets GitHub Actions
4. Ajouter le step d'import dans le pipeline :
```yaml
- name: Import results to Xray
  run: |
    curl -H "Content-Type: multipart/form-data" \
    -u ${{ secrets.JIRA_USER }}:${{ secrets.JIRA_TOKEN }} \
    -F "file=@results/output.xml" \
    https://your-jira-instance/rest/raven/1.0/import/execution/robot
```

---

## Structure des fichiers

### `resources/common.resource`
Keywords partagés par tous les tests :
- `Get Chrome Options` — configure Chrome headless avec les flags de performance
- `Reset Test Data` — réinitialise la BDD Django avant chaque test
- `Create Results Directories` — crée les dossiers de résultats

### `resources/variables.resource`
Variables centralisées :
- URLs de toutes les pages
- Sélecteurs CSS de tous les éléments testés
- Données de test (noms, emails, passeports)
- Timeouts (`SHORT_TIMEOUT`, `DEFAULT_TIMEOUT`, `LONG_TIMEOUT`)

### `pages/*.resource`
Un fichier par page de l'application :
- `flights_page.resource` — liste des vols
- `flight_details_page.resource` — détail vol + gestion passagers
- `passenger_page.resource` — profil passager
- `search_page.resource` — recherche de vols
- `status_page.resource` — changement de statut
- `users_page.resource` — authentification
- `responsive_page.resource` — utilitaires responsive

### `tests/*.robot`
Une suite par fonctionnalité testée. Chaque suite :
- Utilise `Test Setup: Reset Test Data` pour repartir d'une BDD propre
- Capture un screenshot en cas d'échec (`Run Keyword If Test Failed`)
- Ferme le browser après chaque test

---

*README généré dans le cadre du projet de fin d'études — EMSI 2026*
