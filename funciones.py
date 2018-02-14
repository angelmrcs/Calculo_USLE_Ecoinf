# -*- coding: utf-8 -*-
"""
Created on Wed Feb  7 16:16:27 2018

@author: Tobi
"""

import rasterio

def cargar_raster(nombre_raster): #definir funcion
    raster = rasterio.open(nombre_raster) # ruta completa, relativa o dentro de carpeta de trabajo
    banda = raster.read(1) # cargar banda 1 de tif
    
    return banda # devolver datos


    

