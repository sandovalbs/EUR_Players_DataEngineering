# Databricks notebook source
dbutils.widgets.removeAll()

# COMMAND ----------

dbutils.widgets.dropdown("debugmode", "0", ["1", "0"])

# COMMAND ----------

df_plyr=spark.read.table("catalog_empresa.bronze.player")
df_plyr_attr=spark.read.table("catalog_empresa.bronze.player_attributes")
# df_constructor=spark.read.table("catalog_empresa.bronze.constructor")

# COMMAND ----------

if dbutils.widgets.get("debugmode") == "1":
    display(df_plyr.limit(10))
    display(df_plyr_attr.limit(10))

# COMMAND ----------

plyr = df_plyr.alias("plyr")
attr = df_plyr_attr.alias("attr")
df_join = plyr.join(attr, plyr.player_fifa_api_id == attr.player_fifa_api_id)

# COMMAND ----------

df_player_attributes = df_join.select(plyr.player_name,plyr.height,plyr.weight,attr.date, attr.acceleration, attr.ball_control, attr.dribbling, attr.finishing,attr.free_kick_accuracy)

# COMMAND ----------

if dbutils.widgets.get("debugmode") == "1":
    display(df_player_attributes.filter("player_name LIKE '%Messi%' OR player_name LIKE '%Cristiano Ronaldo%' OR player_name LIKE '%Neymar%'"))
    print(df_player_attributes.count())


# COMMAND ----------

df_player_attributes.write.format("delta").mode("overwrite").saveAsTable("catalog_empresa.silver.player_attributes")
