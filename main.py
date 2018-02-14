# -*- coding: utf-8 -*-
"""
Created on Wed Feb  7 16:16:58 2018

@author: Tobi
"""
#alternativa: from funciones import cargar_raster # selecionar cuales funciones a importar

import funciones as fun # archivo de funciones.py
import numpy as np

lado = 5

flow_acc = fun.cargar_raster('flowacc.tif')
a = flow_acc * lado**2 # **derivado, funcion tiene que empezar con minuscula


import gdal

gdal.DEMProcessing('aspect.tif', 'filldem.tif', 'aspect')

aspect = fun.cargar_raster ('aspect.tif') #cargar raster
aspect_rad = aspect * np.pi/180 

aspect_sen =  np.sin(aspect_rad) #calcular sinus (seno)
aspect_cos = np.cos(aspect_rad) #calcular cosinus

aspect_sen_pos = np.abs(aspect_sen)
aspect_cos_pos = np.abs(aspect_cos) #absolute/positive values 

b = 5 * (aspect_sen_pos + aspect_cos_pos)

a_e = a/b

gdal.DEMProcessing('slope.tif', 'filldem.tif', 'slope')

slope = fun.cargar_raster ('slope.tif') #cargar raster
slope_rad = slope * np.pi/180 
slope_sen =  np.sin(slope_rad) #calcular sinus (seno)

#para erosion laminar 
m = 0.4
n = 1

ls = (m+1)*(a_e/22.13)**m * (slope_sen/0.896)**n

import rasterio

mde = rasterio.open('filldem.tif')
profile = mde.profile

capa_ls = rasterio.open('capa_ls.tif', 'w', **profile)
capa_ls.write(ls,1)
capa_ls.close()


