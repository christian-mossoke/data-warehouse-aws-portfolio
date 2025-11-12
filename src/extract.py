# ==========================================================
# SCRIPT : extract_transform_load.py
# AUTEUR : Christian MOSSOKE
# OBJECTIF : pipeline ETL local vers Data Warehouse (modèle étoile)
# ==========================================================

import pandas as pd
import sqlite3
from datetime import datetime

# ==========================================================
#================== EXTRACTION =============================
#===========================================================

customers = pd.read_csv("../Data/clients.csv")
orders = pd.read_csv("../Data/commandes.csv")
ordersdetails = pd.read_csv("../Data/lignes_commandes.csv")
products = pd.read_csv("../Data/produits.csv")

print("data load sucessfully")

# ==========================================================
# =================== TRANSFORMATION =======================
# ==========================================================

# =================== dim_customers ================================
dim_customers = customers.copy()
dim_customers.rename(columns= {

    'client_id' : 'customer_id',
    'nom' : 'customer_name',
    'email' : 'email',
    'pays' : 'country',
    'ville' : 'city'
}, inplace = True)

#============================ dim_products ==========================
dim_products = products.copy()
dim_products.rename(columns= {
    'produit_id' : 'product_id',
    'nom' : 'product_name',
    'categorie' : 'category',
    'prix' : 'price'
}, inplace  = True)

# =============== dim_date =========================================
dim_date = orders[['date_commande']].drop_duplicates().copy()
dim_date['date_id'] = pd.to_datetime(dim_date['date_commande'])
dim_date['year'] = dim_date['date_id'].dt.year
dim_date['month'] = dim_date['date_id'].dt.month
dim_date['day']  = dim_date['date_id'].dt.day 
dim_date['quarter'] = dim_date['date_id'].dt.quarter
dim_date = dim_date[['date_id','year','month','day','quarter']]

# ================== fact_sales ====================================

fact_sales = ordersdetails.merge(orders, on ='commande_id', how='left')
fact_sales = fact_sales.merge(customers, on= 'client_id', how='left')
fact_sales = fact_sales.merge(products, on=  'produit_id', how='left')

fact_sales['total_amount'] = fact_sales['quantite'] * fact_sales['prix_unitaire']

fact_sales_final = fact_sales[['commande_id','client_id','produit_id','date_commande','quantite','total_amount','statut']].copy()

fact_sales_final.rename(columns={'date_commande': 'date_id'}, inplace = True)

print("transfomation done successfully")

# =======================================================================
# ============================ LOAD =====================================
#========================================================================

conn = sqlite3.connect('../datawarehouse.db')

# Loading tables to SQLite
dim_customers.to_sql('dim_customers', conn, if_exists = 'replace',index= False)
dim_products.to_sql('dim_products', conn, if_exists = 'replace', index= False)
dim_date.to_sql('dim_date', conn, if_exists = 'replace', index= False)
fact_sales_final.to_sql('fact_sales', conn, if_exists = 'replace', index= False)

conn.close()

print("donnes chargees avec succes dans datawarehouse.db")
print("pipeline ETL termine avec succes.")