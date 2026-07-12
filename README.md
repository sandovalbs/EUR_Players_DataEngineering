# EUR_Players_DataEngineering

Este repositorio contiene el proceso de ingeniería de datos para jugadores europeos, incluyendo la extracción, transformación y carga (ETL) de datos futbolísticos. El directorio `/proceso` alberga notebooks que documentan cada etapa del flujo de trabajo:

- **Preparacion_Ambiente.ipynb**: Crea las External locations para los diferentes contenedores creados en el datalake administrado por azure, asi como los catalogos necesarios para alojar las tablas delta bronze, silver y gold.
- **Extraction_raw_data_to_bronze.ipynb**: Notebook para la ingesta de datos brutos desde fuentes externas alojadas en un volumen del catalogo raw: 
catalog_empresa.raw.datasets/Players.csv y Players_Attributes.csv en tablas delta dentro del schema **bronze**.
- **Transformation_bronze_to_silver.ipynb**: Procesamiento y limpieza de datos, normalización y enriquecimiento.
- **Transformation_silver_to_bronze.ipynb**: Calculo y agrupamiento de datos para su posterior lectura.
- **DeltaSharing.ipynb**: Exportación de resultados y generación de reportes finales.

Cada notebook está diseñado para ser ejecutado secuencialmente, facilitando la trazabilidad y reproducibilidad del proceso de ingeniería de datos.