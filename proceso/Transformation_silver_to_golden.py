# Databricks notebook source
dbutils.widgets.removeAll()

# COMMAND ----------

dbutils.widgets.dropdown("debugmode", "0", ["1", "0"])

# COMMAND ----------

df_plyr_attr=spark.read.table("catalog_empresa.silver.player_attributes")

# COMMAND ----------

from pyspark.sql.functions import avg, col
df_plyr_attr_avg = df_plyr_attr.groupBy("player_name").agg(
    avg("acceleration").cast("decimal(10,4)").alias("avg_acceleration"),
    avg("ball_control").cast("decimal(10,4)").alias("avg_ball_control"),
    avg("dribbling").cast("decimal(10,4)").alias("avg_dribbling"),
    avg("finishing").cast("decimal(10,4)").alias("avg_finishing"),
    avg("free_kick_accuracy").cast("decimal(10,4)").alias("avg_free_kick_accuracy")
)

# COMMAND ----------

if dbutils.widgets.get("debugmode") == "1":
    display(df_plyr_attr_avg.filter("player_name LIKE '%Messi%' OR player_name LIKE '%Cristiano Ronaldo%' OR player_name LIKE '%Neymar%'"))
    print(df_plyr_attr_avg.count())


# COMMAND ----------

df_plyr_attr_avg.write.format("delta").mode("overwrite").saveAsTable("catalog_empresa.golden.player_attributes")
