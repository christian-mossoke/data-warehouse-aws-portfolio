# 🏬 Retail Data Warehouse on AWS

![AWS](https://img.shields.io/badge/AWS-%23FF9900.svg?style=for-the-badge&logo=amazon-aws&logoColor=white)
![Python](https://img.shields.io/badge/Python-%233776AB.svg?style=for-the-badge&logo=python&logoColor=white)
![Terraform](https://img.shields.io/badge/Terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-%23336791.svg?style=for-the-badge&logo=postgresql&logoColor=white)
![Glue](https://img.shields.io/badge/AWS_Glue-%23FF4F00.svg?style=for-the-badge&logo=amazonaws&logoColor=white)
![Athena](https://img.shields.io/badge/AWS_Athena-%23232F3E.svg?style=for-the-badge&logo=amazonaws&logoColor=white)
![Step Functions](https://img.shields.io/badge/AWS_Step_Functions-%23C925D1.svg?style=for-the-badge&logo=amazonaws&logoColor=white)

---

## 📖 Project Overview

This project implements a **Retail Data Warehouse on AWS**, built to showcase modern **data engineering best practices**.  
The pipeline automates the **ETL (Extract, Transform, Load)** process using AWS native services and Terraform for infrastructure provisioning.

💡 **Goal**:  
Design and deploy a scalable data warehouse architecture where retail data from CSV sources is ingested, transformed, and queried through AWS Athena.

---

## 🧰 Tech Stack

| Category | Technology |
|-----------|-------------|
| Language | Python 3 |
| Orchestration | AWS Step Functions |
| Data Transformation | AWS Glue |
| Storage | Amazon S3 |
| Query Engine | AWS Athena |
| Data Warehouse | PostgreSQL |
| Infrastructure as Code | Terraform |
| Development | Visual Studio Code |
| Visualization | DBeaver / QuickSight |

---

## 🏗️ Data Architecture

```
                   ┌─────────────────────────────┐
                   │        Source Data (CSV)    │
                   │     Local or External File  │
                   └──────────────┬──────────────┘
                                  │
                                  ▼
                     ┌─────────────────────────┐
                     │       Amazon S3         │
                     │  (Raw Data Storage)     │
                     └────────────┬────────────┘
                                  │
                                  ▼
                     ┌─────────────────────────┐
                     │        AWS Glue         │
                     │ Transformation & ETL Job│
                     └────────────┬────────────┘
                                  │
                                  ▼
                     ┌─────────────────────────┐
                     │   AWS Step Functions    │
                     │ Orchestrate ETL Process │
                     └────────────┬────────────┘
                                  │
                                  ▼
                     ┌─────────────────────────┐
                     │     PostgreSQL (RDS)    │
                     │  Data Warehouse Layer   │
                     └────────────┬────────────┘
                                  │
                                  ▼
                     ┌─────────────────────────┐
                     │     AWS Athena / BI     │
                     │  Query & Visualization  │
                     └─────────────────────────┘
```

---

## 🔄 ETL Workflow

1. **Extract** – Python scripts extract data from CSV files and upload them into an S3 bucket.  
2. **Transform** – AWS Glue cleans, standardizes, and formats data for the warehouse.  
3. **Load** – The transformed data is stored in PostgreSQL (RDS).  
4. **Orchestrate** – AWS Step Functions trigger and monitor the full workflow automatically.  
5. **Query & Visualize** – Data is queried in Athena and visualized in QuickSight.

---

## 📂 Project Structure

```
data-warehouse-aws-portfolio/
│
├── data/                          # Raw CSV data
├── sql/
│   ├── create_tables.sql          # PostgreSQL schema
│
├── scripts/
│   ├── extract_transform_load.py  # Local ETL logic
│
├── infra/
│   └── terraform/                 # Infrastructure as code
│       ├── main.tf
│       ├── s3.tf
│       ├── glue.tf
│       ├── step_functions.tf
│       └── variables.tf
│
├── notebooks/
│   ├── analysis.ipynb             # Optional data exploration
│
└── README.md                      # Project documentation
```

---

## 🚀 Deployment Steps

### 1️⃣ Infrastructure Setup
```bash
cd infra/terraform
terraform init
terraform plan
terraform apply
```

### 2️⃣ Run ETL Locally (optional)
```bash
python scripts/extract_transform_load.py
```

### 3️⃣ Trigger AWS Step Function
Launch the state machine in the AWS Console or via CLI to orchestrate the full ETL process.

---

## 📊 Results

- Data successfully ingested from multiple CSVs  
- Cleaned and modeled in PostgreSQL (RDS)  
- Queryable via AWS Athena  
- Ready for BI dashboards (QuickSight or Power BI)

---

## 🧑‍💻 About Me

👋 Hi, I’m **Christian Mossoke** — an aspiring **Cloud Data Engineer**, passionate about building **data-driven architectures** and mastering AWS technologies.  
I love turning raw data into actionable insights through robust pipelines and automation.

🔗 [GitHub](https://github.com/ChristianMossoke)  
📧 christian.mossoke@example.com *(replace with your real email)*  
💼 [LinkedIn](https://linkedin.com/in/christian-mossoke)

---

## 🌟 Future Improvements
- Add CI/CD with GitHub Actions  
- Implement Delta Lake with AWS Glue Catalog  
- Automate data validation using AWS Lambda  

---

## 📜 License
This project is licensed under the MIT License.

---

⭐ *by Christian Mossoke — Cloud Data Engineer*
