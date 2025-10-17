# Demografía
# Análisis demográfico del Municipio de Texcoco, Estado de México

# Laboratorio 2 - Censo 2010 y 2020
# Realizado por: ROM

#################################################################
#################################################################

# Eliminar objetos existentes. Borramos a las variables creadas anteriormente.
rm(list=ls())

# Limpiamos la consola para tener un lugar de trabajo más limpio
cat("\14")

# Seleccionar la ruta del directorio de trabajo
ruta <- choose.dir()
ruta

# Establecer la ruta del directorio como directorio de trabajo
setwd(ruta)

# Imprime en la consola los nombres de los archivos y su extensión que existen en el directorio de trabajo establecido
list.files()

#########################################################
#########################################################

######## Pirámides de Población ########

# Librería de R para hacer pirámides de población
# install.packages('pyramid')
library(pyramid)

#########################################################
######## Pirámide de Población 2010  ########

# Leer la fuente de información de la Población Corregida en 2010 (sin redondeo)
Quinquenios2010_CorrCua <- read.csv("Correccion2010_cuadratura.csv", header = TRUE)

# Ver dataframe en pestaña nueva
View(Quinquenios2010_CorrCua)

# Elimina la primera columna
Quinquenios2010_CorrCua <- Quinquenios2010_CorrCua[, -1]

# Redondeamos la Polación Corregida en 2010
Quinquenios2010_CorrCua[, 2:3] <- round(Quinquenios2010_CorrCua[, 2:3])

# Para ver si es igual a la población redondeada (borrar)
# Prueba <- read.csv("Correccion2010_cuadratura_redondeo.csv", header = TRUE)
# Prueba <- Prueba[, -1]
# Quinquenios2010_CorrCua == Prueba

# Cambiamos de lugar las columnas
PiramidePob2010 <- Quinquenios2010_CorrCua[, c(2,3,1)] # Hombres, mujeres, edad

# Para poner en porcentajes la población
PiramidePob2010[, 1:2] <- PiramidePob2010[, 1:2] / sum(PiramidePob2010[, 1:2]) * 100

# Para crear la imagen de la pirámide de población 2010
pyramid(PiramidePob2010, Llab="Hombres", Rlab="Mujeres", Clab="Edad", Rcol="#FFB6C1",
        Lcol="#ADD8E6", AxisFM="d", main="Texcoco, Estado de México - 2010")

#########################################################
######## Pirámide de Población 2020  ########

# Leer la fuente de información de la Población Corregida redondeada en 2020
Quinquenios2020_CorrCua <- read.csv("Correccion2020_cuadratura.csv", header = TRUE)

# Ver dataframe en pestaña nueva
View(Quinquenios2020_CorrCua)

# Elimina la primera columna
Quinquenios2020_CorrCua <- Quinquenios2020_CorrCua[, -1]

# Redondeamos la Polación Corregida en 2020
Quinquenios2020_CorrCua[, 2:3] <- round(Quinquenios2020_CorrCua[, 2:3])

# Para ver si es igual a la población redondeada (borrar)
# Prueba <- read.csv("Correccion2020_cuadratura_redondeo.csv", header = TRUE)
# Prueba <- Prueba[, -1]
# Quinquenios2020_CorrCua == Prueba

# Cambiamos de lugar las columnas
PiramidePob2020 <- Quinquenios2020_CorrCua[, c(2,3,1)] # Hombres, mujeres, edad

# Para poner en porcentajes la población
PiramidePob2020[, 1:2] <- PiramidePob2020[, 1:2] / sum(PiramidePob2020[, 1:2]) * 100

# Para crear la imagen de la pirámide de población 2020
pyramid(PiramidePob2020, Llab="Hombres", Rlab="Mujeres", Clab="Edad", Rcol="#FFF68F",
        Lcol="#6B8E23", AxisFM="d", main="Texcoco, Estado de México - 2020")


#########################################################
#########################################################
######## Crecimiento geométrico y exponencial censo 2010 y 2020  ########

# A partir del crecimiento geometrico y exponencial se llevara a mitad de año 2015 y 2020, 
# a la poblacion de hombres y de mujeres en cada grupo de edad menores de 1, 1 a 4, 5 a 9,...,80 a 84, 85 y mas años de edad.

#########################################################
#### 1. Cargamos las Bases de Datos ####

# Cargamos las bases de datos de la Población Prorrateada del censo de 2010 y 2020:
Pob2010_Prorrateo <- read.csv("Pob2010_Prorrateo.csv", header = TRUE)
Pob2020_Prorrateo <- read.csv("Pob2020_Prorrateo.csv", header = TRUE)

# Ver dataframe en pestaña nueva
View(Pob2010_Prorrateo)
View(Pob2020_Prorrateo)

# Eliminamos la primera columna de cada una
Pob2010_Prorrateo <- Pob2010_Prorrateo[, -1]
Pob2020_Prorrateo <- Pob2020_Prorrateo[, -1]

# Cargamos las bases de datos de la Población Corregida antes del redondeo del censo de 2010 y 2020: 
Correccion2010_cuadratura <- read.csv("Correccion2010_cuadratura.csv", header =  TRUE)
Correccion2020_cuadratura <- read.csv("Correccion2020_cuadratura.csv", header = TRUE)

# Ver dataframe en pestaña nueva
View(Correccion2010_cuadratura)
View(Correccion2020_cuadratura)

# Eliminamos la primera columna de cada una
Correccion2010_cuadratura <- Correccion2010_cuadratura[, -1]
Correccion2020_cuadratura <- Correccion2020_cuadratura[, -1]

# Censo 2010, fecha de referencia: 12 junio 2010
# Censo 2020, fecha de referencia: 15 marzo 2020

f1 <- as.Date(c("2010-06-12", "2020-03-15"))
# Número de días entre las fechas de referencias del censo de 2010 y 2020
dias = as.numeric(f1[2]-f1[1]) 
# Número de años entre las fechas de referencias del censo de 2010 y 2020, debe ser 9.764384
n = dias/365; n 

#########################################################
#### 1.1 Censo 2010 ####

# Separamos al grupo de 0 a 4 años en: menor de 1 año y de 1 a 4 años

# Unimos la población de 0 años (menor a 1 año) a la población corregida que esta en quinquenios
# Y la pondremos en la primera fila, antes del quinquenio de 0 a 4 años
Correccion2010_cuadratura = rbind(Pob2010_Prorrateo[1,],Correccion2010_cuadratura)

# Le ponemos el nombre a la primera fila
Correccion2010_cuadratura[1,1] = c("Menor a 1 año")

# La segunda fila tendrá la población de 1 a 4 años
# Restamos la población de 0 a 4 años (fila 2) menos la población de solo 0 años (fila 1)
Correccion2010_cuadratura[2,2:3] = Correccion2010_cuadratura[2,2:3] - Correccion2010_cuadratura[1,2:3]

# Le ponemos el nombre a la segunda fila
Correccion2010_cuadratura[2,1] = c("1 a 4 años"); Correccion2010_cuadratura

# Guardamos en un .csv esta nueva base de datos en 
#write.csv(Correccion2010_cuadratura,"Correccion2010_cuadratura_lab2.csv")

#########################################################
#### 1.2 Censo 2020 ####

# Separamos al grupo de 0 a 4 años en: menor de 1 año y de 1 a 4 años

# Unimos la población de 0 años (menor a 1 año) a la población corregida que esta en quinquenios
# Y la pondremos en la primera fila, antes del quinquenio de 0 a 4 años
Correccion2020_cuadratura = rbind(Pob2020_Prorrateo[1,],Correccion2020_cuadratura)

# Le ponemos el nombre a la primera fila
Correccion2020_cuadratura[1,1] = c("Menor a 1 año")

# La segunda fila tendrá la población de 1 a 4 años
# Restamos la población de 0 a 4 años (fila 2) menos la población de solo 0 años (fila 1)
Correccion2020_cuadratura[2,2:3] = Correccion2020_cuadratura[2,2:3] - Correccion2020_cuadratura[1,2:3]

# Le ponemos el nombre a la segunda fila
Correccion2020_cuadratura[2,1] = c("1 a 4 años"); Correccion2020_cuadratura

# Guardamos en un .csv esta nueva base de datos en 
#write.csv(Correccion2020_cuadratura,"Correccion2020_cuadratura_lab2.csv")

#########################################################
# ****  2. Mitad de año censal: ****

# Llevamos a mitad de año (30/junio/t) a los hombres y a las mujeres para el 2015 y 2020

# Fechas
f2 <- as.Date(c("2010-06-12", "2015-06-30"))
f3 <- as.Date(c("2020-03-15", "2020-06-30"))

# Diferencia en años del 12/jun/2010 (fecha de referencia censo 2010) al 30/jun/2015
n1 = as.numeric(f2[2]-f2[1])/365  

# Diferencia en años del 15/marzo/2020 (fecha de referencia censo 2020) al 30/jun/2020  
n2 = as.numeric(f3[2]-f3[1])/365  

#########################################################
# ****  3. Crecimiento Geometrico: ****

# Obtenemos la tasa de crecimiento geométrico intercensal para hombres y para mujeres, por cada grupo de edad
r_Geom = Correccion2020_cuadratura 
r_Geom$Hombres = ((Correccion2020_cuadratura$Hombres/Correccion2010_cuadratura$Hombres)^(1/n))-1
r_Geom$Mujeres = ((Correccion2020_cuadratura$Mujeres/Correccion2010_cuadratura$Mujeres)^(1/n))-1
View(r_Geom)

# ****  3.1 Proyección de Población ****

# Llevamos a mitad de año (30/junio/t) a los hombres y a las mujeres para el 2015 y 2020:

# Llevamos a 30/jun/2015 la población del 12/jun/2010 (fecha de referencia censo 2010)
Pob_Mitad2015_Geom = Correccion2010_cuadratura
Pob_Mitad2015_Geom$Hombres = Correccion2010_cuadratura$Hombres*(1+r_Geom$Hombres)^(n1)
Pob_Mitad2015_Geom$Mujeres = Correccion2010_cuadratura$Mujeres*(1+r_Geom$Mujeres)^(n1)
View(Pob_Mitad2015_Geom)

# Llevamos a 30/jun/2010 la población del 15/marzo/2020 (fecha de referencia censo 2020)
Pob_Mitad2020_Geom = Correccion2020_cuadratura
Pob_Mitad2020_Geom$Hombres = Correccion2020_cuadratura$Hombres*(1+r_Geom$Hombres)^(n2)
Pob_Mitad2020_Geom$Mujeres = Correccion2020_cuadratura$Mujeres*(1+r_Geom$Mujeres)^(n2)
View(Pob_Mitad2020_Geom)

# Guardamos la información obtenida
#write.csv(r_Geom, "Tasa_Geométrica.csv")
#write.csv(Pob_Mitad2015_Geom, "Población_Mitad2015_Geom.csv")
#write.csv(Pob_Mitad2020_Geom, "Población_Mitad2020_Geom.csv")

#########################################################
# **** 4. Crecimiento Exponencial: ****
r_Exp = Correccion2020_cuadratura
r_Exp$Hombres = log(Correccion2020_cuadratura$Hombres/Correccion2010_cuadratura$Hombres)/n
r_Exp$Mujeres = log(Correccion2020_cuadratura$Mujeres/Correccion2010_cuadratura$Mujeres)/n
View(r_Exp)

# ****  4.1 Proyección de Población ****

# Llevamos a mitad de año (30/junio/t) a los hombres y a las mujeres para el 2015 y 2020: 

# Llevamos a 30/jun/2015 la población del 12/jun/2010 (fecha de referencia censo 2010)
Pob_Mitad2015_Exp = Correccion2010_cuadratura
Pob_Mitad2015_Exp$Hombres = Correccion2010_cuadratura$Hombres*(exp(r_Exp$Hombres*n1))
Pob_Mitad2015_Exp$Mujeres = Correccion2010_cuadratura$Mujeres*(exp(r_Exp$Mujeres*n1))
View(Pob_Mitad2015_Exp)

# Llevamos a 30/jun/2010 la población del 15/marzo/2020 (fecha de referencia censo 2020)
Pob_Mitad2020_Exp = Correccion2020_cuadratura
Pob_Mitad2020_Exp$Hombres = Correccion2020_cuadratura$Hombres*(exp(r_Exp$Hombres*n2))
Pob_Mitad2020_Exp$Mujeres = Correccion2020_cuadratura$Mujeres*(exp(r_Exp$Mujeres*n2))
View(Pob_Mitad2020_Exp)

# Guardamos la información obtenida
#write.csv(r_Exp, "Tasa_Exponencial.csv")
#write.csv(Pob_Mitad2015_Exp, "Población_Mitad2015_Exp.csv")
#write.csv(Pob_Mitad2020_Exp, "Población_Mitad2020_Exp.csv")

# FIN