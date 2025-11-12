🧱 Data Warehouse AWS Portfolio Project
🚀 Objectif du projet

Ce projet fait partie d’une série de projets data engineering destinés à mon portfolio professionnel.
L’objectif est de concevoir, déployer et automatiser une data warehouse complète sur AWS, en partant de fichiers CSV locaux jusqu’à une infrastructure cloud orchestrée par AWS Step Functions.

🗂️ Architecture du projet
1. Sources de données

Quatre fichiers CSV simulant un environnement e-commerce :

clients.csv

produits.csv

commandes.csv

lignes_commandes.csv

Ces fichiers contiennent les données brutes servant de base à la Data Warehouse.

2. Étapes principales

Ingestion locale et préparation des données

Nettoyage et transformation avec extract-transform-load.py

Chargement dans une base Postgres locale (datawarehouse)

Migration vers AWS

Les fichiers sont transférés dans un bucket S3 structuré :

s3://datawarehouse-portfolio/
  ├── raw/
  ├── processed/
  └── glue_scripts/


Déploiement d’infrastructure avec Terraform

Bucket S3

Base de données AWS Glue Data Catalog

Rôle IAM pour Glue & Step Functions

Job AWS Glue (etl_glue_script.py)

Orchestration avec AWS Step Functions

Exploration et analyse

Requêtes SQL sur S3 avec Amazon Athena

Vue logique de la Data Warehouse via tables dimensionnelles et fact tables

🧰 Stack technique
Domaine	Outil / Technologie
Langage principal	Python 3
Cloud	AWS
Infrastructure as Code	Terraform
ETL	AWS Glue (PySpark)
Orchestration	AWS Step Functions
Stockage	Amazon S3
Requêtage analytique	Amazon Athena
Base de test locale	PostgreSQL
IDE	VS Code
Monitoring & visualisation	DBeaver / AWS Console
📁 Structure du projet
data-warehouse-aws-portfolio/
│
├── data/                         # Fichiers CSV bruts
│   ├── clients.csv
│   ├── produits.csv
│   ├── commandes.csv
│   └── lignes_commandes.csv
│
├── sql/                          # Scripts SQL
│   ├── create_tables.sql
│   └── queries/
│
├── scripts/
│   └── extract-transform-load.py # Pipeline ETL local
│
├── infra/
│   └── terraform/
│       ├── main.tf
│       ├── s3.tf
│       ├── glue.tf
│       ├── iam.tf
│       ├── stepfunction.tf
│       ├── variables.tf
│       ├── outputs.tf
│       └── glue_scripts/
│           └── etl_glue_script.py
│
├── README.md
└── .gitignore

⚙️ Instructions d’exécution
Étape 1 — Local

Créer l’environnement :

python -m venv venv
source venv/bin/activate  # ou venv\Scripts\activate sur Windows


Installer les dépendances :

pip install -r requirements.txt


Créer la base de données locale :

psql -U postgres -c "CREATE DATABASE datawarehouse;"


Créer les tables :

psql -U postgres -d datawarehouse -f sql/create_tables.sql


Lancer le script ETL :

python scripts/extract-transform-load.py

Étape 2 — AWS Infrastructure (Terraform)

Aller dans le dossier Terraform :

cd infra/terraform


Initialiser Terraform :

terraform init


Vérifier le plan :

terraform plan


Appliquer le déploiement :

terraform apply

Étape 3 — Orchestration avec Step Functions

Le workflow exécute :

Le job AWS Glue pour traiter les données brutes → données transformées

La mise à jour du catalogue Glue

La validation finale du job

Étape 4 — Analyse

Exécuter des requêtes SQL dans Amazon Athena :

SELECT produit_id, SUM(total) AS total_ventes
FROM processed.commandes
GROUP BY produit_id
ORDER BY total_ventes DESC;

🧠 Compétences démontrées

Modélisation de Data Warehouse (star schema)

Conception de pipeline ETL (local → cloud)

Infrastructure as Code avec Terraform

Orchestration serverless (AWS Step Functions)

Déploiement AWS Glue Job

Analyse avec Athena

Automatisation de bout en bout (CI/CD possible)

🌍 Auteur

Christian Mossoke
💼 Data Engineer 
📧 Contact : christian.mossoke.pro@gmail.com