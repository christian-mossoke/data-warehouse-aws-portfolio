------------------------------------------------------------------------
-- SCRIPT: creation du data warehouse schema en etoile 
-- AUTEUR: MOSSOKE CHRISTIAN 
-- OBJECTIF: creer les tables dimensionnelles et de faits
-- COMPATIBLE: Redshift AWS / PostgresSQL
------------------------------------------------------------------------

--Suppression des tables si elles existent deja

drop table if exists fact_sales CASCADE;
drop table if exists dim_customers CASCADE;
drop table if exists dim_products CASCADE;
drop table if exists dim_date CASCADE;

-- table de dimension dim_customers:

create table dim_client(
    customer_id int primary key,
    customer_name varchar(55),
    email varchar(255),
    country varchar(55),
    city varchar(55),
    subscription_date date, 
);

create table dim_products(
    product_id int primary key, 
    product_name varchar(255),
    category varchar(255),
    price decimal(10,2),
);

create table dim_date(
    date_id date primary key,
    year int,
    month int,
    day int, 
    quarter int, 
);

create table fact_sales(
    sale_id bigint identity(1,1) primary key,
    order_id int,
    customer_id int references dim_customers(customer_id),
    product_id int references dim_products(product_id),
    date_id date references dim_date(date_id)
    quantity int,
    total_amount int,
    reduction decimal,
    sale_statut varchar(55)
);

--INDEXES 
create index idx_fact_sales_customer on fact_sales(customer_id);
create index idx_fact_sales_product on fact_sales(product_id);
create index idx_fact_sales_date on fact_sales(date_id);