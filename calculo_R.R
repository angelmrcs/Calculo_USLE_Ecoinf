### Calculating R factor (*Spatial interpolation*)

#The starting point is a .csv file called "R_anda_oriental.csv" that contains a list of points with R values associated. Each point corresponds to a meteorological station. The extent of this file is East Andalusia. We will use kriging as a way to interpolate point R values 


# ESTABLISH WORKING DIRECTORY

dir_trabajo<-'/Users/fjbonet/Google Drive/4_docencia/master_ugr_cons_bio/curso_2017_2018/ecoin_2017_2018/material/calculo_R'
setwd(dir_trabajo)

# INSTALLING AND LOADING REQUIRED PACKAGES

list_packages<-c("sp", "ggplot2", "rgdal", "automap", "aspace","gstat")
install.packages(list_packages, dep=TRUE)
library(sp)
library(rgdal)
library(automap)
library(ggplot2)
library(aspace)
library(gstat)

#IMPORTING CSV FILE WITH "R" VALUES. PLOTTING THE DISTRIBUTION OF METEOROLOGICAL STATIONS

lista_R<-read.table("R_anda_oriental.csv", dec=",", header=T, sep = ';')

ggplot (lista_R, aes(X,Y))+geom_point(aes(size=R), color="blue", alpha=3/4)+ggtitle("Distribuci??n de R en Andaluc??????a oriental")+
  coord_equal()+theme_bw()

# USING "aspace" PACKAGE TO CALCULATE STANTDARD DEVIATION ELLIPSE. THIS TOOL IS USEFUL TO DETERMINE WHETHER OUR STUDY AREA IS AFFECTED BY THE BORDER EFFECT

calc_sde(id=1, filename="SDE_Output.txt", centre.xy=NULL, calccentre=TRUE,
         points=data.frame(lista_R$X,lista_R$Y))
plot_sde(plotnew = TRUE)

elipse_shp<-convert.to.shapefile(sdeloc,sdeatt, "id",5)
write.shapefile(elipse_shp,"elipse_shp")

# CONVERT DATAFRAME TO A SPDF (SPATIAL DATAFRAME)

coordinates(lista_R)<-~ X + Y

bbox(lista_R)
coordinates(lista_R)
proj4string(lista_R)

# FITTING A VARIOGRAM

R.vgm<-variogram(log(R)~1, lista_R)
plot(R.vgm)


# PERFORMING ORDINARY KRIGING AND STORE RESULTS ON OBJECT OF TYPE "autoKrige" "list"

area_estudio<-readOGR(dsn=".", layer="area_estudio_23030")
grid <- makegrid(area_estudio, cellsize = 100)
gridded(grid) =~ x1+x2
kriging_result = autoKrige(R~1, lista_R, grid)
plot(kriging_result) 
kriging.pred <- kriging_result$krige_output
writeGDAL(kriging.pred["var1.pred"], "KrigingPred.asc")
writeGDAL(kriging.pred["var1.var"], "KrigingVar.asc")
