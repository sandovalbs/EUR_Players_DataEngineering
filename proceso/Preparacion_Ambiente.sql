-- Databricks notebook source
-- MAGIC %python
-- MAGIC dbutils.widgets.removeAll()

-- COMMAND ----------

create widget text storageName default "datlkeempresa";

-- COMMAND ----------

-- MAGIC %python
-- MAGIC
-- MAGIC container_name = "raw"
-- MAGIC storage_account = "datlkeempresa"
-- MAGIC file_path = "circuits.csv"
-- MAGIC raw_container_path = 'abfss://raw@datlkeempresa.dfs.core.windows.net/'
-- MAGIC # Construye la ruta URI completa
-- MAGIC full_path = f"abfss://{container_name}@{storage_account}.dfs.core.windows.net/{file_path}"
-- MAGIC
-- MAGIC print(f"{raw_container_path = }")
-- MAGIC
-- MAGIC
-- MAGIC df = spark.read.format("csv").option("header", "true").load(full_path)
-- MAGIC # display(df)
-- MAGIC

-- COMMAND ----------

DROP CATALOG IF EXISTS catalog_Empresa CASCADE;

-- COMMAND ----------

CREATE CATALOG IF NOT EXISTS catalog_Empresa
MANAGED LOCATION 'abfss://raw@datlkeempresa.dfs.core.windows.net/'
COMMENT 'Catalogo para la arquitectura medallion del ambiente de dev';

-- COMMAND ----------

CREATE SCHEMA IF NOT EXISTS catalog_Empresa.raw;
CREATE SCHEMA IF NOT EXISTS catalog_Empresa.bronze;
CREATE SCHEMA IF NOT EXISTS catalog_Empresa.silver;
CREATE SCHEMA IF NOT EXISTS catalog_Empresa.golden;
CREATE SCHEMA IF NOT EXISTS catalog_Empresa.exploratory;

CREATE VOLUME IF NOT EXISTS catalog_Empresa.raw.datasets;

-- COMMAND ----------

CREATE EXTERNAL LOCATION IF NOT EXISTS `exlt-bronze`
URL 'abfss://bronze@datlkeempresa.dfs.core.windows.net/'
WITH (STORAGE CREDENTIAL `empresacred`)
COMMENT 'Ubicación externa para las tablas bronze del Data Lake';

-- COMMAND ----------

CREATE EXTERNAL LOCATION IF NOT EXISTS `exlt-silver`
URL 'abfss://silver@datlkeempresa.dfs.core.windows.net/'
WITH (STORAGE CREDENTIAL `empresacred`)
COMMENT 'Ubicación externa para las tablas silver del Data Lake';

-- COMMAND ----------

CREATE EXTERNAL LOCATION IF NOT EXISTS `exlt-golden`
URL 'abfss://golden@datlkeempresa.dfs.core.windows.net/'
WITH (STORAGE CREDENTIAL `empresacred`)
COMMENT 'Ubicación externa para las tablas golden del Data Lake';

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Creacion de tablas bronze

-- COMMAND ----------

-- CREATE TABLE IF NOT EXISTS catalog_Empresa.bronze.circuits (
-- circuit_id integer,
-- circuit_ref string,
-- name string,
-- location string,
-- country string,
-- latitude double,
-- longitude double,
-- altitude integer,
-- ingestion_date timestamp
-- )
-- USING DELTA
-- LOCATION "abfss://bronze@datlkeempresa.dfs.core.windows.net/circuits"

-- COMMAND ----------

-- select * from catalog_empresa.bronze.circuits;

-- COMMAND ----------


-- CREATE TABLE IF NOT EXISTS catalog_empresa.bronze.races (
-- race_id integer,
-- race_year integer,
-- round integer,
-- circuit_id integer,
-- name string,
-- ingestion_date timestamp
-- )
-- USING DELTA
-- LOCATION "abfss://bronze@datlkeempresa.dfs.core.windows.net/races"

-- COMMAND ----------

-- select * from catalog_empresa.bronze.races;

-- COMMAND ----------

-- CREATE TABLE IF NOT EXISTS catalog_empresa.bronze.constructors (
--   constructor_id integer,
--   constructor_ref string,
--   name string,
--   nationality string,
--   ingestion_date timestamp
-- )
-- USING DELTA
-- LOCATION "abfss://bronze@datlkeempresa.dfs.core.windows.net/constructors"

-- COMMAND ----------

-- select * from catalog_empresa.bronze.constructors

-- COMMAND ----------

-- MAGIC %md
-- MAGIC CREACION DE TABLAS SILVER

-- COMMAND ----------

-- CREATE TABLE IF NOT EXISTS catalog_empresa.silver.circuits_transformed (
--   race_id integer,
--   race_year integer,
--   round integer,
--   circuit_id integer,
--   name_race string,
--   ingestion_date timestamp,
--   circuit_ref string,
--   name string,
--   location string,
--   country string,
--   latitude double,
--   longitude double,
--   altitude integer,
--   altitude_category string,
--   years_diferences integer,
--   lat_diff integer,
--   race_type string,
--   near_equator string
-- )
-- USING DELTA
-- LOCATION "abfss://silver@datlkeempresa.dfs.core.windows.net/circuits_transformed"

-- COMMAND ----------

-- SELECT * FROM catalog_empresa.silver.circuits_transformed

-- COMMAND ----------

-- CREATE TABLE IF NOT EXISTS catalog_empresa.golden.golden_raced_partitioned (
--   race_year integer,
--   conteo long,
--   max_altitude integer,
--   min_altitude integer,
--   country string,
--   race_type string,
--   near_equator string
-- )
-- USING DELTA
-- LOCATION "abfss://golden@datlkeempresa.dfs.core.windows.net/golden_raced_partitioned"

-- COMMAND ----------

-- SELECT * FROM catalog_empresa.golden.golden_raced_partitioned
