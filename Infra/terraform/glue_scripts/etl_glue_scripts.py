# simple Glue PySpark job script: lit raw CSVs, joint et écrit Parquet
import sys
from awsglue.transforms import *
from awsglue.utils import getResolvedOptions
from pyspark.context import SparkContext
from awsglue.context import GlueContext
from awsglue.job import Job

args = getResolvedOptions(sys.argv, ['JOB_NAME'])
sc = SparkContext()
glueContext = GlueContext(sc)
spark = glueContext.spark_session
job = Job(glueContext)
job.init(args['JOB_NAME'], args)

# Replace these paths if you change bucket name
bucket = "REPLACE_BUCKET"  # Terraform will upload script; but better to pass via args in prod

clients_path = "s3://{}/raw/clients.csv".format(bucket)
commandes_path = "s3://{}/raw/commandes.csv".format(bucket)
lignes_path = "s3://{}/raw/lignes_commandes.csv".format(bucket)
produits_path = "s3://{}/raw/produits.csv".format(bucket)

clients = glueContext.create_dynamic_frame.from_options(
    connection_type="s3",
    connection_options={"paths": [clients_path]},
    format="csv",
    format_options={"withHeader": True, "separator": ","}
)

commandes = glueContext.create_dynamic_frame.from_options(
    connection_type="s3",
    connection_options={"paths": [commandes_path]},
    format="csv",
    format_options={"withHeader": True, "separator": ","}
)

lignes = glueContext.create_dynamic_frame.from_options(
    connection_type="s3",
    connection_options={"paths": [lignes_path]},
    format="csv",
    format_options={"withHeader": True, "separator": ","}
)

produits = glueContext.create_dynamic_frame.from_options(
    connection_type="s3",
    connection_options={"paths": [produits_path]},
    format="csv",
    format_options={"withHeader": True, "separator": ","}
)

# join lignes -> produits -> commandes
ventes = Join.apply(lignes, produits, "id_produit", "id_produit")
ventes = Join.apply(ventes, commandes, "id_commande", "id_commande")

# write result as parquet to processed/
glueContext.write_dynamic_frame.from_options(
    frame = ventes,
    connection_type = "s3",
    connection_options = {"path": "s3://{}/processed/ventes/".format(bucket)},
    format = "parquet"
)

job.commit()
