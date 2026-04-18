# ✈ AirLine TNR Automation

![CI](https://github.com/Lekkioui/airline-tnr-automation/actions/workflows/tests.yml/badge.svg)
![Robot Framework](https://img.shields.io/badge/Robot%20Framework-6.1.1-brightgreen)
![Python](https://img.shields.io/badge/Python-3.11-blue)
![Selenium](https://img.shields.io/badge/Selenium-4.8.2-yellow)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-15-blue)

> Projet de fin d'études — Mise en place d'une solution d'automatisation des tests de non-régression (TNR) avec Robot Framework, intégrée dans une chaîne d'intégration continue via GitHub Actions.

**Auteur :** Anasse Lekkioui  
**École :** EMSI - École Marocaine des Sciences de l'Ingénieur  
**Programme :** 5IIR26  

---

## Table des matières
```
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
- [Structure des fichiers](#structure-des-fichiers)
```
---

## Présentation du projet

Ce projet met en place une solution complète d'automatisation des tests de non-régression pour une application web Django de gestion de vols aériens. Il couvre l'ensemble de la chaîne qualité :

- **Automatisation des tests UI** avec Robot Framework et SeleniumLibrary
- **Pattern Page Object Model (POM)** pour une architecture maintenable
- **Variables centralisées** pour éviter la duplication des sélecteurs et données
- **Pipeline CI/CD** avec GitHub Actions qui exécute les tests à chaque push
- **Base de données PostgreSQL** réelle avec données réalistes (1000+ vols)
- **Tests responsive** sur mobile et desktop

---

## Application testée

L'application **AirLine** est une application Django de gestion de vols aériens avec PostgreSQL.

**Repo Django :** [airline-django](https://github.com/Lekkioui/airline-django)

### Fonctionnalités couvertes par les tests
```

| Fonctionnalité | Description |
|---|---|
| Authentification | Login, logout, inscription, protection des pages |
| Tableau des vols | Filtres, pagination, stats bar, périodes |
| Détail d'un vol | Infos complètes, statut, capacité, passagers |
| Gestion des statuts | Transitions SCHEDULED → BOARDING → DEPARTED / CANCELLED |
| Système de réservation | Seat map, sélection siège, confirmation, annulation |
| Pricing dynamique | Prix par classe + yield management selon taux d'occupation |
| Boarding pass | Génération et téléchargement de la carte d'embarquement |
| Profil passager | Affichage des informations et vols d'un passager |
| Recherche de vols | Filtres par origine, destination, statut, date |
| Dashboard | KPIs, stats aujourd'hui, top routes, revenus |
| Responsive design | Rendu mobile et desktop |
```
---

## Architecture du projet
```
airline-automation/
├── .github/
│   └── workflows/
│       └── tests.yml
├── pages/
│   ├── auth_page.resource
│   ├── index_page.resource
│   ├── flight_detail_page.resource
│   ├── booking_page.resource
│   ├── passenger_page.resource
│   ├── search_page.resource
│   └── dashboard_page.resource
├── resources/
│   ├── common.resource
│   ├── variables.resource
│   └── test_ids.resource          ← généré automatiquement par setup_test_data
├── tests/
│   ├── test_auth.robot
│   ├── test_index.robot
│   ├── test_flight_detail.robot
│   ├── test_booking.robot
│   ├── test_passenger.robot
│   ├── test_search.robot
│   ├── test_dashboard.robot
│   └── test_responsive.robot
├── results/
│   └── screenshots/
├── requirements.txt
└── README.md
```
---

## Stack technique

| Outil | Version | Rôle |
|---|---|---|
| Robot Framework | 6.1.1 | Framework de test |
| SeleniumLibrary | 6.1.0 | Automatisation navigateur |
| Selenium | 4.8.2 | Driver navigateur |
| Python | 3.11 | Langage |
| Django | 4.0.2 | Application testée (AUT) |
| PostgreSQL | 15 | Base de données réelle |
| GitHub Actions | — | Pipeline CI/CD |

---

## Prérequis

- Python 3.11+
- Google Chrome installé
- ChromeDriver compatible avec votre version de Chrome
- PostgreSQL 15+
- Git

---

## Installation

### 1. Cloner le repo d'automatisation

```bash
git clone https://github.com/Lekkioui/airline-tnr-automation.git
cd airline-tnr-automation
pip install -r requirements.txt
```

### 2. Cloner et configurer le projet Django

```bash
git clone https://github.com/Lekkioui/airline-django.git ../airline-django
cd ../airline-django
python -m venv venv
venv\Scripts\activate          # Windows
pip install -r requirements.txt
```

### 3. Configurer PostgreSQL

```sql
CREATE DATABASE airline_db;
CREATE USER airline_user WITH PASSWORD 'airline_pass';
GRANT ALL ON SCHEMA public TO airline_user;
GRANT ALL PRIVILEGES ON DATABASE airline_db TO airline_user;
```

### 4. Configurer `settings.py`

```python
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': 'airline_db',
        'USER': 'airline_user',
        'PASSWORD': 'airline_pass',
        'HOST': 'localhost',
        'PORT': '5432',
    }
}
```

### 5. Initialiser la base de données et lancer le serveur

```bash
python manage.py migrate
python manage.py setup_test_data
python manage.py runserver
```

> `setup_test_data` génère automatiquement 1000+ vols, des passagers réalistes et le fichier `resources/test_ids.resource` utilisé par les tests.

---

## Lancer les tests

### Tous les tests

```bash
robot -d results .\tests\
```

### Une suite spécifique

```bash
robot -d results .\tests\test_auth.robot
robot -d results .\tests\test_index.robot
robot -d results .\tests\test_flight_detail.robot
robot -d results .\tests\test_booking.robot
robot -d results .\tests\test_passenger.robot
robot -d results .\tests\test_search.robot
robot -d results .\tests\test_dashboard.robot
robot -d results .\tests\test_responsive.robot
```

### Dry run (vérification sans exécution)

```bash
robot --dryrun -d results .\tests\
```

### Réinitialiser les données de test

```bash
# Windows
..\airline-django\venv\Scripts\python.exe ..\airline-django\manage.py setup_test_data
```

---

## Pipeline CI/CD

Le pipeline GitHub Actions s'exécute automatiquement à chaque `push` ou `pull_request` sur la branche `main`.
```
push sur airline-django
│
▼
┌─────────────────────┐
│   GitHub Actions    │
│   airline-django    │
│                     │
│  repository_dispatch│──────────────────────────┐
└─────────────────────┘                          │
▼
┌──────────────────────────┐
│   GitHub Actions         │
│   airline-tnr-automation │
│                          │
│  1. Clone Django         │
│  2. Setup PostgreSQL     │
│  3. migrate              │
│  4. setup_test_data      │
│  5. runserver            │
│  6. robot tests/         │
│  7. Upload artifacts     │
└──────────────────────────┘
```

### Artifacts disponibles après chaque run

- `report.html` — rapport visuel des tests
- `log.html` — log détaillé avec screenshots
- `output.xml` — résultats bruts

---

## Couverture des tests
```
| Suite | Fichier | Tests |
|---|---|---|
| Authentification | `test_auth.robot` | 6 |
| Tableau des vols | `test_index.robot` | 8 |
| Détail vol & statuts | `test_flight_detail.robot` | 6 |
| Réservation complète | `test_booking.robot` | 8 |
| Profil passager | `test_passenger.robot` | 6 |
| Recherche | `test_search.robot` | 6 |
| Dashboard | `test_dashboard.robot` | 4 |
| Responsive | `test_responsive.robot` | 4 |
| **Total** | | **48 tests** |
```
### Types de tests couverts

- **Tests fonctionnels** — vérification des fonctionnalités métier
- **Tests négatifs** — validation des erreurs (email doublon, passport invalide, champs vides)
- **Tests de navigation** — liens, redirections, retour arrière
- **Tests de workflow** — transitions de statut, séquences de réservation
- **Tests de sécurité** — accès sans authentification, dashboard inaccessible aux non-admins
- **Tests de pricing** — vérification du prix affiché sur la seat map et la confirmation
- **Tests responsive** — rendu sur mobile (375px) et desktop (1920px)

---

## Pattern Page Object Model

Le projet applique strictement le **Page Object Model (POM)**.
```
┌─────────────────────────────────────────────┐
│              Tests (.robot)                 │
│  "Ce qu'on teste — les scénarios métier"    │
│  test_auth, test_booking, test_search...    │
└──────────────────┬──────────────────────────┘
│ utilise
┌──────────────────▼──────────────────────────┐
│           Page Objects (.resource)          │
│  "Comment on interagit avec les pages"      │
│  auth_page, booking_page, search_page...    │
└──────────────────┬──────────────────────────┘
│ utilise
┌──────────────────▼──────────────────────────┐
│           Resources partagées               │
│  common.resource   — keywords communs       │
│  variables.resource — sélecteurs, URLs      │
│  test_ids.resource  — IDs générés auto      │
└─────────────────────────────────────────────┘
```
---

## Variables centralisées

Toutes les URLs, sélecteurs CSS et données de test sont centralisés dans `resources/variables.resource`.

```
robotframework
# URLs
${FLIGHTS_URL}        http://127.0.0.1:8000/flights/
${SEARCH_URL}         http://127.0.0.1:8000/flights/search/
${DASHBOARD_URL}      http://127.0.0.1:8000/flights/dashboard/
${LOGIN_URL}          http://127.0.0.1:8000/users/login

# Sélecteurs
${SEL_FLIGHT_TABLE}      css:[data-testid='flight-table']
${SEL_BOOKING_REFERENCE} css:[data-testid='booking-reference']
${SEL_PRICE_ECONOMY}     css:[data-testid='price-ECONOMY']

# Timeouts
${DEFAULT_TIMEOUT}    10s
${LONG_TIMEOUT}       30s
```

---

## Structure des fichiers

### `resources/common.resource`
Keywords partagés par tous les tests :
- `Open Browser Headless` — ouvre Chrome headless avec tous les flags nécessaires
- `Login As Admin` — connexion admin depuis n'importe quelle page
- `Reset Test Data` — réinitialise la DB Django avant chaque test et régénère `test_ids.resource`
- `Close Session` — ferme le navigateur

### `resources/test_ids.resource`
Généré automatiquement par `setup_test_data` — contient les IDs des vols dédiés aux tests (SCHEDULED, BOARDING, DEPARTED, CANCELLED) et les données du passager de référence.

### `pages/*.resource`
Un fichier par domaine fonctionnel :
- `auth_page.resource` — login, logout, inscription
- `index_page.resource` — tableau des vols, filtres, pagination
- `flight_detail_page.resource` — détail vol, transitions de statut
- `booking_page.resource` — seat map, confirmation, succès, annulation
- `passenger_page.resource` — profil passager, suppression de vol
- `search_page.resource` — recherche multi-critères
- `dashboard_page.resource` — KPIs, stats, top routes

### `tests/*.robot`
Une suite par fonctionnalité. Chaque suite :
- Utilise `Test Setup: Reset Test Data` pour repartir d'une DB propre
- Capture un screenshot en cas d'échec
- Ferme le navigateur après chaque test

---

*Projet de fin d'études — EMSI 2026*