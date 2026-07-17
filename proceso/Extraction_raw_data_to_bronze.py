# Databricks notebook source
dbutils.widgets.removeAll()

# COMMAND ----------

dbutils.widgets.text("catalogo","catalog_empresa")
dbutils.widgets.text("csv_raw_data","Player.csv,Player_Attributes.csv")
# dbutils.widgets.text("json_raw_data","constructors.json")

# COMMAND ----------

catalogo = dbutils.widgets.get("catalogo")
csv_raw_data = dbutils.widgets.get("csv_raw_data")
# json_raw_data = dbutils.widgets.get("json_raw_data")
volume_path = f'/Volumes/{catalogo}/raw/datasets/'

print(f"{volume_path =}")
print(f"{csv_raw_data =}")
# print(f"{json_raw_data =}")

plyr = f"{volume_path}{csv_raw_data.split(",")[0]}"
plyr_attr = f"{volume_path}{csv_raw_data.split(",")[1]}"
# constructor = f"{volume_path}{json_raw_data}"
print(f"{plyr =}")
print(f"{plyr_attr =}")

# COMMAND ----------


df_plyr = spark.read.csv(plyr, header=True)
df_plyr_attr = spark.read.csv(plyr_attr, header=True)
# df_constructor = spark.read.json(constructor)


df_plyr.write.format("delta").mode("overwrite").saveAsTable("catalog_empresa.bronze.player")
df_plyr_attr.write.format("delta").mode("overwrite").saveAsTable("catalog_empresa.bronze.player_attributes")
# df_constructor.write.format("delta").mode("overwrite").saveAsTable("catalog_empresa.bronze.constructor")

# COMMAND ----------

# display(df_constructor)
