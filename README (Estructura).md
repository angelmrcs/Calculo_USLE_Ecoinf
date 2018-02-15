# Estructura del repositorio

El objetivo del repositorio fue el cálculo de aquellos factores necesarios para la obtención de la erosión potencial (A) a través de la USLE (LS, R, C, K).
---------

**Cálculo de LS**
Se lleva a cabo a través de Python.
Incluye 2 (dos) archivos:

*funciones.py*
*main.py*

El archivo "main" es el principal, mientras que "funciones" recopila las funciones que se ejecutarán en el mismo.


----------


**Cálculo de R**
Se lleva a cabo mediante RStudio.
Incluye 8 (ocho) archivos:

*.RData*
*.Rhistory*
*_Rapp.history*
*calculo_R.R*
*escript.R*
*notas.Rmd*
*R.Rproj*
*R_anda_oriental.csv*

Mediante R se generaron los archivos .asc y .shp necesarios, no incluidos en el repositorio.


----------
**Cálculo de C**
La C se calculó para dos años (1956 y 2003) a través de QGIS y Access. De estos dos cálculos se derivan 6 (seis) archivos que contienen el código SQL que organiza las consultas en Access:

*asigna_c_CLC.txt*
*asigna_c_CLC._2.txt*
*atrib_shp_99.txt*
*genera_tabla_atributos_shape.txt*
*genera_tabla_atributos_shape_2.txt*
*lista_usos_cubillas.txt*


----------
**Cálculo de K**
El archivo no se calculó a lo largo del trabajo, fue obtenido directamente. No aparece, por tanto, ningún archivo ligado al mismo en este repositorio.