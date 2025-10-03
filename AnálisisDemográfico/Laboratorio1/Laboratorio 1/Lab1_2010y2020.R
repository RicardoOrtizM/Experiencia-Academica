# Demografía
# Análisis demográfico del Municipio de Texcoco, Estado de México

# Laboratorio 1 - Censo 2010 y 2020
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

######## CENSO DE POBLACIÓN Y VIVIENDA 2010 DE TEXCOCO ########

# Leer la fuente de información de la Población en 2010
Pob2010 <- read.csv("Pob Texcoco 2010.csv", header = TRUE)
Pob2010

# Propiedades del dataframe
str(Pob2010)

# A los espacios en blanco de datos ponerles 0, si existen
Pob2010[is.na(Pob2010)] <- 0

# Ver dataframe en pestaña nueva
View(Pob2010)

#########################################################
######## Cálculo del Índice de Whipple ########

# Índice Whipple para Hombres:

# El numerador suma las edades avanzando 5 años desde los 25 hasta 60 años de edad
Pob2010$Hombres[26] # Edad 25 = Posición 26, por que las edades incian en 0 
Pob2010$Hombres[61] # Edad 60 = Posición 61, por que las edades incian en 0
num <- sum(Pob2010$Hombres[seq(26, 61, by=5)])

# El denominador suma las edades desde 23 a 62 años
Pob2010$Hombres[24] # Edad 23 = Posición 24, por que las edades incian en 0 
Pob2010$Hombres[63] # Edad 62 = Posición 63, por que las edades incian en 0
den <- sum(Pob2010$Hombres[seq(24, 63)])

Whipple_H2010 <- (num/den) * 500

Whipple_H2010


# Índice Whipple para Mujeres:

# El numerador suma las edades avanzando 5 años desde los 25 hasta 60 años de edad
Pob2010$Mujeres[26] # Edad 25 = Posición 26, por que las edades incian en 0 
Pob2010$Mujeres[61] # Edad 60 = Posición 61, por que las edades incian en 0
num <- sum(Pob2010$Mujeres[seq(26, 61, by=5)])

# El denominador suma las edades desde 23 a 62 años
Pob2010$Mujeres[24] # Edad 23 = Posición 24, por que las edades incian en 0 
Pob2010$Mujeres[63] # Edad 62 = Posición 63, por que las edades incian en 0
den <- sum(Pob2010$Mujeres[seq(24, 63)])

Whipple_M2010 <- (num/den) * 500

Whipple_M2010

#########################################################
######## Cálculo del Índice de Myers ########

# Índice de Myers para Hombres:

# Creamos una matriz de 10 filas (una para cada dígito "j" del 0 al 9) y 1 columna
# La matriz nos dirá el valor del numerador de cada Mj
MatrizNumMj_H2010 <- matrix(NA, 10, 1) # Se llena de valores nulos (NA)

# Calculamos el valor de cada numerador de cada Mj y lo colocamos en la matriz
for (j in 0:9) {
  # Suma las edades avanzando 10 años desde los 10 hasta los 60 años de edad
  # Edad 10 = Posición 11, por que las edades incian en 0
  # Edad 60 = Posición 61, por que las edades incian en 0 
  Pj1_H2010 <- sum(Pob2010$Hombres[seq(11+j, 61+j, by=10)])
  
  # Suma las edades avanzando 10 años desde los 20 hasta los 60 años de edad
  # Edad 20 = Posición 21, por que las edades incian en 0
  # Edad 70 = Posición 71, por que las edades incian en 0 
  Pj2_H2010 <- sum(Pob2010$Hombres[seq(21+j, 71+j, by=10)])
  
  # Rellenamos la fila correspondiente, como empieza en 1 entonces hacemos referencia a ella con j+1
  MatrizNumMj_H2010[j+1] <- (j+1)*Pj1_H2010 + (9-j)*Pj2_H2010
}

MatrizNumMj_H2010

# El denominador de cada Mj es la suma de los elementos de la matriz con los numeradores de cada Mj
denMj_H2010 <- sum(MatrizNumMj_H2010)

denMj_H2010

# Creamos una matriz de 10 filas (una para cada dígito "j" del 0 al 9) y 1 columna
# La matriz nos dirá el valor de cada Mj (concentración de la población en el dígito j)
# Matriz con los valores de cada Mj con j desde 0 hasta 9
Mj_H2010 <- matrix(NA, 10, 1) # Se llena de valores nulos (NA)

# Calculamos el valor de cada Mj y lo colocamos en la matriz
for (i in 1:10) {
  Mj_H2010[i] <- (MatrizNumMj_H2010[i] / denMj_H2010) - 0.10
}
Mj_H2010 <- Mj_H2010 * 100

Mj_H2010

# Índice de Myers para Hombres Resumido
Myers_H2010 <- sum(abs(Mj_H2010))

Myers_H2010


# Índice de Myers para Mujeres:

# Creamos una matriz de 10 filas (una para cada dígito "j" del 0 al 9) y 1 columna
# La matriz nos dirá el valor del numerador de cada Mj
MatrizNumMj_M2010 <- matrix(NA, 10, 1) # Se llena de valores nulos (NA)

# Calculamos el valor de cada numerador de cada Mj y lo colocamos en la matriz
for (j in 0:9) {
  # Suma las edades avanzando 10 años desde los 10 hasta los 60 años de edad
  # Edad 10 = Posición 11, por que las edades incian en 0
  # Edad 60 = Posición 61, por que las edades incian en 0 
  Pj1_M2010 <- sum(Pob2010$Mujeres[seq(11+j, 61+j, by=10)])
  
  # Suma las edades avanzando 10 años desde los 20 hasta los 60 años de edad
  # Edad 20 = Posición 21, por que las edades incian en 0
  # Edad 70 = Posición 71, por que las edades incian en 0 
  Pj2_M2010 <- sum(Pob2010$Mujeres[seq(21+j, 71+j, by=10)])
  
  # Rellenamos la fila correspondiente, como empieza en 1 entonces hacemos referencia a ella con j+1
  MatrizNumMj_M2010[j+1] <- (j+1)*Pj1_M2010 + (9-j)*Pj2_M2010
}

MatrizNumMj_M2010

# El denominador de cada Mj es la suma de los elementos de la matriz con los numeradores de cada Mj
denMj_M2010 <- sum(MatrizNumMj_M2010)

denMj_M2010

# Creamos una matriz de 10 filas (una para cada dígito "j" del 0 al 9) y 1 columna
# La matriz nos dirá el valor de cada Mj (concentración de la población en el dígito j)
# Matriz con los valores de cada Mj con j desde 0 hasta 9
Mj_M2010 <- matrix(NA, 10, 1) # Se llena de valores nulos (NA)

# Calculamos el valor de cada Mj y lo colocamos en la matriz
for (i in 1:10) {
  Mj_M2010[i] <- (MatrizNumMj_M2010[i] / denMj_M2010) - 0.10
}
Mj_M2010 <- Mj_M2010 * 100

Mj_M2010

# Índice de Myers para Mujeres Resumido
Myers_M2010 <- sum(abs(Mj_M2010))

Myers_M2010

#########################################################
######## Cálculo del Índice de Naciones Unidas (INU) ########

# Crear dataframe vacío de 3 columnas (Edad, Hombres, Mujeres) y 15 filas (total de quinquenios)
Pob_Quinquenios2010 <- data.frame(Edad = rep(NA, 15), # repite NA (nulos) 15 veces
                                  Hombres = rep(NA, 15),
                                  Mujeres = rep(NA, 15))

# Rellenar dataframe con la población de cada quinquenio correspondiente
for(i in 1:15) {
  Pob_Quinquenios2010[i, 1] <- paste0(5*(i-1), "-", 5*i-1) # Concatenar texto, columna de Edad
  Pob_Quinquenios2010[i, 2:3] <- colSums(Pob2010[(5*i-4):(5*i), 2:3]) # Rellena la población en los Quinquenios en Hombres y Mujeres
}

# Ver dataframe en pestaña nueva
View(Pob_Quinquenios2010)

# Comprobación de que la suma sea igual en ambos dataframe
colSums(Pob_Quinquenios2010[ , 2:3]) == colSums(Pob2010[1:75, 2:3])

# Índice Hombres:
I_H2010 <- 0

for(i in 2:14){
  num <- 2 * Pob_Quinquenios2010[i, 2]
  den <- Pob_Quinquenios2010[i-1, 2] + Pob_Quinquenios2010[i+1, 2]
  I_H2010 <- I_H2010 + 100*abs(num/den -1)/13
}

I_H2010


# Índice Mujeres:
I_M2010 <- 0

for(i in 2:14){
  num <- 2 * Pob_Quinquenios2010[i, 3]
  den <- Pob_Quinquenios2010[i-1, 3] + Pob_Quinquenios2010[i+1, 3]
  I_M2010 <- I_M2010 + 100*abs(num/den -1)/13
}

I_M2010


# Índice Ambos Sexos:
I_S2010 <- 0

for(i in 2:14){
  num <- Pob_Quinquenios2010[i, 2]
  den <- Pob_Quinquenios2010[i, 3]
  frac1 <- num/den
  
  num <- Pob_Quinquenios2010[i+1, 2]
  den <- Pob_Quinquenios2010[i+1, 3]
  frac2 <- num/den
  
  I_S2010 <- I_S2010 + 100*abs(frac1 - frac2)/13
}

I_S2010


# Índice de Naciones Unidas (INU):
I_NU2010 <- I_H2010 + I_M2010 + (3 * I_S2010)

I_NU2010

#########################################################
######## Cálculo de Índice de Masculinidad (IM) ########
# Indica la razón de hombres por cada 100 mujeres en una población por cada grupo quinquenal y para el grupo de 85 y más

# Crear dataframe vacío de 3 columnas (Edad, Hombres, Mujeres) y 18 filas (total de quinquenios)
Quinquenios2010 <- data.frame(Edad = rep(NA, 18), # repite NA (nulos) 18 veces
                              Hombres = rep(NA, 18),
                              Mujeres = rep(NA, 18))

# Rellenar dataframe con la población de cada quinquenio correspondiente
for (i in 1:17) {
  Quinquenios2010[i, 1] <- paste0(5*(i-1), "-", 5*i-1) # Concatenar texto, columna de Edad
  Quinquenios2010[i, 2:3] <- colSums(Pob2010[(5*i-4):(5*i), 2:3]) # Rellena la población en los Quinquenios en Hombres y Mujeres
}
Quinquenios2010[18, 1] <- "85 y más"
Quinquenios2010[18, 2:3] <- colSums(Pob2010[86:101, 2:3]) # Población de edad 85 (posición 86, porque inciamos en edad 0) hasta edad 100 (posición 101, porque inciamos en edad 0)

# Ver dataframe en pestaña nueva
View(Quinquenios2010)

# Comprobación de que la suma sea igual en ambos dataframe
colSums(Quinquenios2010[ , 2:3]) == colSums(Pob2010[1:101, 2:3])

# Índice de Masculinidad (IM), cantidad de hombres por cada 100 mujeres por Quinquenio
IM2010 <- round(Quinquenios2010[, 2] / Quinquenios2010[, 3] * 100, 0) # Redondear el Índice de Masculinidad

# Tabla de Presentación 2010
# Junta los dataframes con la población de Hombres y Mujeres por Quinquenio (Quinquenios2010) y el Índice de Masculinidad por Quinquenio (IM2010)
T_IM2010 <- cbind(Quinquenios2010, IM2010)

# Ver dataframe en pestaña nueva
View(T_IM2010)

#########################################################
######## Cálculo de Razón de Dependencia ########
# Número de personas dependientes por cada 100 personas en edad productiva

# Razón de Dependencia en Hombres:

RD_H2010 <- round(sum(Quinquenios2010[c(1:3, 14:18), 2]) / sum(Quinquenios2010[4:13, 2]) * 100) # Redondear la Razón de Dependencia en Hombres
# sum(Quinquenios2010[c(1:3, 14,18), 2] = Población de Hombres menor de 15 años (3 primeros Quinquenios) y mayor de 64 años (Quinquenio 14 a 18)
# sum(Quinquenios2010[4:13, 2]) = Población de Hombres de 15 a 64 (Quinquenio 4 al 13)

RD_H2010


# Razón de Dependencia en Mujeres:

RD_M2010 <- round(sum(Quinquenios2010[c(1:3, 14:18), 3]) / sum(Quinquenios2010[4:13, 3]) * 100) # Redondear la Razón de Dependencia en Mujeres
# sum(Quinquenios2010[c(1:3, 14,18), 3] = Población de Mujeres menor de 15 años (3 primeros Quinquenios) y mayor de 64 años (Quinquenio 14 a 18)
# sum(Quinquenios2010[4:13, 3]) = Población de Mujeres de 15 a 64 (Quinquenio 4 al 13)

RD_M2010


# Razón de Dependencia en General (Ambos Sexos)

RD_2010 <- round(sum(Quinquenios2010[c(1:3, 14:18), 2:3]) / sum(Quinquenios2010[4:13, 2:3]) * 100) # Redondear la Razón de Dependencia en General
# sum(Quinquenios2010[c(1:3, 14,18), 2:3] = Población de General menor de 15 años (3 primeros Quinquenios) y mayor de 64 años (Quinquenio 14 a 18)
# sum(Quinquenios2010[4:13, 2:3]) = Población de General de 15 a 64 (Quinquenio 4 al 13)

RD_2010

#########################################################
######## Prorrateo ########

# Porcentaje de concentración de la población No Especificada

## Para Hombres
Pob_Total_Hombres_2010 <- sum(Pob2010$Hombres)
Pob_NE_Hombres_2010 <- Pob2010$Hombres[length(Pob2010$Edad)] # Obtiene la Pob NE de Hombres, que se encuentra en el último renglón de Pob2010
alfa_Hombres_2010 <- (Pob_NE_Hombres_2010 / (Pob_Total_Hombres_2010 - Pob_NE_Hombres_2010))
alfa_Hombres_2010

## Para Mujeres
Pob_Total_Mujeres_2010 <- sum(Pob2010$Mujeres)
Pob_NE_Mujeres_2010 <- Pob2010$Mujeres[length(Pob2010$Edad)] # Obtiene la Pob NE de Mujeres, que se encuentra en el último renglón de Pob2010
alfa_Mujeres_2010 <- (Pob_NE_Mujeres_2010 / (Pob_Total_Mujeres_2010 - Pob_NE_Mujeres_2010))
alfa_Mujeres_2010

# Creamos Matriz donde ira la población prorrateada
Pob2010_Prorrateo <- matrix(NA, length(Pob2010$Edad) - 1, 3) # 3 columnas, una fila menos que Pob2010, se llena de NA (nulos)
colnames(Pob2010_Prorrateo) <- c("Edad", "Hombres", "Mujeres") # Asignamos los nombres a las columnas
Pob2010_Prorrateo <- data.frame(Pob2010_Prorrateo) # Convertimos la matriz en dataframe
Pob2010_Prorrateo$Edad <- Pob2010$Edad[-length(Pob2010$Edad)] # Asignamos nombres a cada fila de la columna Edad, iguales a los de Pob2010 pero sin la población NE

# Prorrateamos población

## Para Hombres
if(alfa_Hombres_2010 >= 0.05) {
  # Si la población NE es mayor o igual al 5% prorrateamos
  for (i in 1:(length(Pob2010$Edad) - 1)) {
    Pob2010_Prorrateo$Hombres[i] <- Pob2010$Hombres[i] * (1 + alfa_Hombres_2010)
  }
  
} else {
  # Si la población NE es menor al 5% ignoramos la fila de población NE
  Pob2010_Prorrateo$Hombres <- Pob2010$Hombres[-length(Pob2010$Edad)]
}

## Para Mujeres
if(alfa_Mujeres_2010 >= 0.05) {
  # Si la población NE es mayor o igual al 5% prorrateamos
  for (i in 1:(length(Pob2010$Edad) - 1)) {
    Pob2010_Prorrateo$Mujeres[i] <- Pob2010$Mujeres[i] * (1 + alfa_Mujeres_2010)
  }
  
} else {
  # Si la población NE es menor al 5% ignoramos la fila de población NE
  Pob2010_Prorrateo$Mujeres <- Pob2010$Mujeres[-length(Pob2010$Edad)]
}

# Compración
sum(Pob2010_Prorrateo$Hombres) == sum(Pob2010$Hombres[1:(length(Pob2010$Edad) - 1)])
sum(Pob2010_Prorrateo$Mujeres) == sum(Pob2010$Mujeres[1:(length(Pob2010$Edad) - 1)])

# Ver dataframe en pestaña nueva
View(Pob2010_Prorrateo)

# Creamos un archivo .csv con la información de Pob2010_Prorrateo
#write.csv(Pob2010_Prorrateo, "D:\\6° Semestre\\Demografía\\Proyecto Demografía\\Pob2010_Prorrateo.csv")

#########################################################
######## Método de 1/16 ########

# Se aplica a las poblaciones por grupos quinquenales desde 10-14 hasta 70-74 años
# Las poblaciones a las que no se les aplica no sufren cambios

# Generamos un dataframe para alojar los grupos quinquenales
quinquenios2010 <- data.frame(Edad = rep(NA, 18), # repite NA (nulos) 18 veces
                              Hombres = rep(NA, 18),
                              Mujeres = rep(NA, 18))
# colnames(quinquenios2010) <- c("Edad", "Hombres", "Mujeres")

# Rellenamos las columnas 2 y 3 con la información correspondiente 
# de la población de Hombres y Mujeres para cada quinquenio respectivamente
for (i in seq(5,85,by = 5)) {
  quinquenios2010[(i/5),2:3] <- cumsum(Pob2010_Prorrateo[(i-4):i,2:3])[5,]
}
quinquenios2010[18,2:3] <- cumsum(Pob2010_Prorrateo[86:101,2:3])[16,]

# Rellenamos la columna de Edad con los nombres de cada quinquenio correspondiente
for (i in 1:17) {
  quinquenios2010[i, 1] <- paste0(5*(i-1), "-", 5*i-1) # Concatenar texto, columna de Edad
}
quinquenios2010[18, 1] <- "85 y más"
# quinquenios2010$Edad <- c("0-4", "5-9", "10-14", "15-19", "20-24", "25-29", "30-34", "35-39", "40-44", "45-49", 
#                          "50-54", "55-59", "60-64", "65-69", "70-74", "75-79", "80-84","85 y más")

# Enumeramos los renglones
rownames(quinquenios2010) <- c(seq(1:18))

# Ver dataframe en pestaña nueva
View(quinquenios2010)

Correccion2010 <- quinquenios2010 
# Método de 1/16
for (i in 3:15) {
  Correccion2010[i,2:3] <- (1/16)*(-1*quinquenios2010[i+2, 2:3]
                                   +4*quinquenios2010[i+1, 2:3]
                                   +10*quinquenios2010[i, 2:3]
                                   +4*quinquenios2010[i-1, 2:3]
                                   -1*quinquenios2010[i-2, 2:3])
  
}
Correccion2010

fac_cuadratura2010  <-  Correccion2010
fac_cuadratura2010$Hombres  <-  Correccion2010$Hombres / sum(Correccion2010$Hombres)
fac_cuadratura2010$Mujeres  <-  Correccion2010$Mujeres / sum(Correccion2010$Mujeres)

Correccion2010_cuadratura  <-  Correccion2010
Correccion2010_cuadratura$Hombres  <-  sum(Pob2010_Prorrateo$Hombres) * fac_cuadratura2010$Hombres
Correccion2010_cuadratura$Mujeres  <-  sum(Pob2010_Prorrateo$Mujeres) * fac_cuadratura2010$Mujeres
View(Correccion2010_cuadratura)

# Corroborar:
sum(Pob2010_Prorrateo$Hombres) == sum(Correccion2010_cuadratura$Hombres)
sum(Pob2010_Prorrateo$Mujeres) == sum(Correccion2010_cuadratura$Mujeres)

# Creamos un archivo .csv con la información de quinquenios2010
#write.csv(quinquenios2010, "D:\\6° Semestre\\Demografía\\Proyecto Demografía\\quinquenios2010.csv")

# Creamos un archivo .csv con la información de Correccion2010_cuadratura
#write.csv(Correccion2010_cuadratura, "D:\\6° Semestre\\Demografía\\Proyecto Demografía\\Correccion2010_cuadratura.csv")

# Redondear
Correccion2010_cuadratura_redondeo <- Correccion2010_cuadratura
Correccion2010_cuadratura_redondeo[,2:3] <- round(Correccion2010_cuadratura_redondeo[,2:3])
rownames(Correccion2010_cuadratura_redondeo) <- c(seq(1:18))
View(Correccion2010_cuadratura_redondeo)

# Creamos un archivo .csv con la información de Correccion2010_cuadratura_redondeo
#write.csv(Correccion2010_cuadratura_redondeo, "D:\\6° Semestre\\Demografía\\Proyecto Demografía\\Correccion2010_cuadratura_redondeo.csv")

# Vemos que al redondear ya no queda igual:
sum(Pob2010_Prorrateo$Hombres) == sum(Correccion2010_cuadratura_redondeo$Hombres)
sum(Pob2010_Prorrateo$Mujeres) == sum(Correccion2010_cuadratura_redondeo$Mujeres)

#########################################################
#########################################################

######## CENSO DE POBLACIÓN Y VIVIENDA 2020 DE TEXCOCO ########

# Leer la fuente de información de la Población en 2020
Pob2020 <- read.csv("Pob Texcoco 2020.csv", header = TRUE)
Pob2020

# Propiedades del dataframe
str(Pob2020)

# A los espacios en blanco de datos ponerles 0, si existen
Pob2020[is.na(Pob2020)] <- 0

# Ver dataframe en pestaña nueva
View(Pob2020)

#########################################################
######## Cálculo del Índice de Whipple ########

# Índice Whipple para Hombres:

# El numerador suma las edades avanzando 5 años desde los 25 hasta 60 años de edad
Pob2020$Hombres[26] # Edad 25 = Posición 26, por que las edades incian en 0 
Pob2020$Hombres[61] # Edad 60 = Posición 61, por que las edades incian en 0
num <- sum(Pob2020$Hombres[seq(26, 61, by=5)])

# El denominador suma las edades desde 23 a 62 años
Pob2020$Hombres[24] # Edad 23 = Posición 24, por que las edades incian en 0 
Pob2020$Hombres[63] # Edad 62 = Posición 63, por que las edades incian en 0
den <- sum(Pob2020$Hombres[seq(24, 63)])

Whipple_H2020 <- (num/den) * 500

Whipple_H2020


# Índice Whipple para Mujeres:

# El numerador suma las edades avanzando 5 años desde los 25 hasta 60 años de edad
Pob2020$Mujeres[26] # Edad 25 = Posición 26, por que las edades incian en 0 
Pob2020$Mujeres[61] # Edad 60 = Posición 61, por que las edades incian en 0
num <- sum(Pob2020$Mujeres[seq(26, 61, by=5)])

# El denominador suma las edades desde 23 a 62 años
Pob2020$Mujeres[24] # Edad 23 = Posición 24, por que las edades incian en 0 
Pob2020$Mujeres[63] # Edad 62 = Posición 63, por que las edades incian en 0
den <- sum(Pob2020$Mujeres[seq(24, 63)])

Whipple_M2020 <- (num/den) * 500

Whipple_M2020

#########################################################
######## Cálculo del Índice de Myers ########

# Índice de Myers para Hombres:

# Creamos una matriz de 10 filas (una para cada dígito "j" del 0 al 9) y 1 columna
# La matriz nos dirá el valor del numerador de cada Mj
MatrizNumMj_H2020 <- matrix(NA, 10, 1) # Se llena de valores nulos (NA)

# Calculamos el valor de cada numerador de cada Mj y lo colocamos en la matriz
for (j in 0:9) {
  # Suma las edades avanzando 10 años desde los 10 hasta los 60 años de edad
  # Edad 10 = Posición 11, por que las edades incian en 0
  # Edad 60 = Posición 61, por que las edades incian en 0 
  Pj1_H2020 <- sum(Pob2020$Hombres[seq(11+j, 61+j, by=10)])
  
  # Suma las edades avanzando 10 años desde los 20 hasta los 60 años de edad
  # Edad 20 = Posición 21, por que las edades incian en 0
  # Edad 70 = Posición 71, por que las edades incian en 0 
  Pj2_H2020 <- sum(Pob2020$Hombres[seq(21+j, 71+j, by=10)])
  
  # Rellenamos la fila correspondiente, como empieza en 1 entonces hacemos referencia a ella con j+1
  MatrizNumMj_H2020[j+1] <- (j+1)*Pj1_H2020 + (9-j)*Pj2_H2020
}

MatrizNumMj_H2020

# El denominador de cada Mj es la suma de los elementos de la matriz con los numeradores de cada Mj
denMj_H2020 <- sum(MatrizNumMj_H2020)

denMj_H2020

# Creamos una matriz de 10 filas (una para cada dígito "j" del 0 al 9) y 1 columna
# La matriz nos dirá el valor de cada Mj (concentración de la población en el dígito j)
# Matriz con los valores de cada Mj con j desde 0 hasta 9
Mj_H2020 <- matrix(NA, 10, 1) # Se llena de valores nulos (NA)

# Calculamos el valor de cada Mj y lo colocamos en la matriz
for (i in 1:10) {
  Mj_H2020[i] <- (MatrizNumMj_H2020[i] / denMj_H2020) - 0.10
}
Mj_H2020 <- Mj_H2020 * 100

Mj_H2020

# Índice de Myers para Hombres Resumido
Myers_H2020 <- sum(abs(Mj_H2020))

Myers_H2020


# Índice de Myers para Mujeres:

# Creamos una matriz de 10 filas (una para cada dígito "j" del 0 al 9) y 1 columna
# La matriz nos dirá el valor del numerador de cada Mj
MatrizNumMj_M2020 <- matrix(NA, 10, 1) # Se llena de valores nulos (NA)

# Calculamos el valor de cada numerador de cada Mj y lo colocamos en la matriz
for (j in 0:9) {
  # Suma las edades avanzando 10 años desde los 10 hasta los 60 años de edad
  # Edad 10 = Posición 11, por que las edades incian en 0
  # Edad 60 = Posición 61, por que las edades incian en 0 
  Pj1_M2020 <- sum(Pob2020$Mujeres[seq(11+j, 61+j, by=10)])
  
  # Suma las edades avanzando 10 años desde los 20 hasta los 60 años de edad
  # Edad 20 = Posición 21, por que las edades incian en 0
  # Edad 70 = Posición 71, por que las edades incian en 0 
  Pj2_M2020 <- sum(Pob2020$Mujeres[seq(21+j, 71+j, by=10)])
  
  # Rellenamos la fila correspondiente, como empieza en 1 entonces hacemos referencia a ella con j+1
  MatrizNumMj_M2020[j+1] <- (j+1)*Pj1_M2020 + (9-j)*Pj2_M2020
}

MatrizNumMj_M2020

# El denominador de cada Mj es la suma de los elementos de la matriz con los numeradores de cada Mj
denMj_M2020 <- sum(MatrizNumMj_M2020)

denMj_M2020

# Creamos una matriz de 10 filas (una para cada dígito "j" del 0 al 9) y 1 columna
# La matriz nos dirá el valor de cada Mj (concentración de la población en el dígito j)
# Matriz con los valores de cada Mj con j desde 0 hasta 9
Mj_M2020 <- matrix(NA, 10, 1) # Se llena de valores nulos (NA)

# Calculamos el valor de cada Mj y lo colocamos en la matriz
for (i in 1:10) {
  Mj_M2020[i] <- (MatrizNumMj_M2020[i] / denMj_M2020) - 0.10
}
Mj_M2020 <- Mj_M2020 * 100

Mj_M2020

# Índice de Myers para Mujeres Resumido
Myers_M2020 <- sum(abs(Mj_M2020))

Myers_M2020

#########################################################
######## Cálculo del Índice de Naciones Unidas (INU) ########

# Crear dataframe vacío de 3 columnas (Edad, Hombres, Mujeres) y 15 filas (total de quinquenios)
Pob_Quinquenios2020 <- data.frame(Edad = rep(NA, 15), # repite NA (nulos) 15 veces
                                  Hombres = rep(NA, 15),
                                  Mujeres = rep(NA, 15))

# Rellenar dataframe con la población de cada quinquenio correspondiente
for(i in 1:15) {
  Pob_Quinquenios2020[i, 1] <- paste0(5*(i-1), "-", 5*i-1) # Concatenar texto, columna de Edad
  Pob_Quinquenios2020[i, 2:3] <- colSums(Pob2020[(5*i-4):(5*i), 2:3]) # Rellena la población en los Quinquenios en Hombres y Mujeres
}

# Ver dataframe en pestaña nueva
View(Pob_Quinquenios2020)

# Comprobación de que la suma sea igual en ambos dataframe
colSums(Pob_Quinquenios2020[ , 2:3]) == colSums(Pob2020[1:75, 2:3])

# Índice Hombres:
I_H2020 <- 0

for(i in 2:14){
  num <- 2 * Pob_Quinquenios2020[i, 2]
  den <- Pob_Quinquenios2020[i-1, 2] + Pob_Quinquenios2020[i+1, 2]
  I_H2020 <- I_H2020 + 100*abs(num/den -1)/13
}

I_H2020


# Índice Mujeres:
I_M2020 <- 0

for(i in 2:14){
  num <- 2 * Pob_Quinquenios2020[i, 3]
  den <- Pob_Quinquenios2020[i-1, 3] + Pob_Quinquenios2020[i+1, 3]
  I_M2020 <- I_M2020 + 100*abs(num/den -1)/13
}

I_M2020


# Índice Ambos Sexos:
I_S2020 <- 0

for(i in 2:14){
  num <- Pob_Quinquenios2020[i, 2]
  den <- Pob_Quinquenios2020[i, 3]
  frac1 <- num/den
  
  num <- Pob_Quinquenios2020[i+1, 2]
  den <- Pob_Quinquenios2020[i+1, 3]
  frac2 <- num/den
  
  I_S2020 <- I_S2020 + 100*abs(frac1 - frac2)/13
}

I_S2020


# Índice de Naciones Unidas (INU):
I_NU2020 <- I_H2020 + I_M2020 + (3 * I_S2020)

I_NU2020

#########################################################
######## Cálculo de Índice de Masculinidad (IM) ########
# Indica la razón de hombres por cada 100 mujeres en una población por cada grupo quinquenal y para el grupo de 85 y más

# Crear dataframe vacío de 3 columnas (Edad, Hombres, Mujeres) y 18 filas (total de quinquenios)
Quinquenios2020 <- data.frame(Edad = rep(NA, 18), # repite NA (nulos) 18 veces
                              Hombres = rep(NA, 18),
                              Mujeres = rep(NA, 18))

# Rellenar dataframe con la población de cada quinquenio correspondiente
for (i in 1:17) {
  Quinquenios2020[i, 1] <- paste0(5*(i-1), "-", 5*i-1) # Concatenar texto, columna de Edad
  Quinquenios2020[i, 2:3] <- colSums(Pob2020[(5*i-4):(5*i), 2:3]) # Rellena la población en los Quinquenios en Hombres y Mujeres
}
Quinquenios2020[18, 1] <- "85 y más"
Quinquenios2020[18, 2:3] <- colSums(Pob2020[86:101, 2:3]) # Población de edad 85 (posición 86, porque inciamos en edad 0) hasta edad 100 (posición 101, porque inciamos en edad 0)

# Ver dataframe en pestaña nueva
View(Quinquenios2020)

# Comprobación de que la suma sea igual en ambos dataframe
colSums(Quinquenios2020[ , 2:3]) == colSums(Pob2020[1:101, 2:3])

# Índice de Masculinidad (IM), cantidad de hombres por cada 100 mujeres por Quinquenio
IM2020 <- round(Quinquenios2020[, 2] / Quinquenios2020[, 3] * 100, 0) # Redondear el Índice de Masculinidad

# Tabla de Presentación 2020
# Junta los dataframes con la población de Hombres y Mujeres por Quinquenio (Quinquenios2020) y el Índice de Masculinidad por Quinquenio (IM2020)
T_IM2020 <- cbind(Quinquenios2020, IM2020)

# Ver dataframe en pestaña nueva
View(T_IM2020)

#########################################################
######## Cálculo de Razón de Dependencia ########
# Número de personas dependientes por cada 100 personas en edad productiva

# Razón de Dependencia en Hombres:

RD_H2020 <- round(sum(Quinquenios2020[c(1:3, 14:18), 2]) / sum(Quinquenios2020[4:13, 2]) * 100) # Redondear la Razón de Dependencia en Hombres
# sum(Quinquenios2020[c(1:3, 14,18), 2] = Población de Hombres menor de 15 años (3 primeros Quinquenios) y mayor de 64 años (Quinquenio 14 a 18)
# sum(Quinquenios2020[4:13, 2]) = Población de Hombres de 15 a 64 (Quinquenio 4 al 13)

RD_H2020


# Razón de Dependencia en Mujeres:

RD_M2020 <- round(sum(Quinquenios2020[c(1:3, 14:18), 3]) / sum(Quinquenios2020[4:13, 3]) * 100) # Redondear la Razón de Dependencia en Mujeres
# sum(Quinquenios2020[c(1:3, 14,18), 3] = Población de Mujeres menor de 15 años (3 primeros Quinquenios) y mayor de 64 años (Quinquenio 14 a 18)
# sum(Quinquenios2020[4:13, 3]) = Población de Mujeres de 15 a 64 (Quinquenio 4 al 13)

RD_M2020


# Razón de Dependencia en General (Ambos Sexos)

RD_2020 <- round(sum(Quinquenios2020[c(1:3, 14:18), 2:3]) / sum(Quinquenios2020[4:13, 2:3]) * 100) # Redondear la Razón de Dependencia en General
# sum(Quinquenios2020[c(1:3, 14,18), 2:3] = Población de General menor de 15 años (3 primeros Quinquenios) y mayor de 64 años (Quinquenio 14 a 18)
# sum(Quinquenios2020[4:13, 2:3]) = Población de General de 15 a 64 (Quinquenio 4 al 13)

RD_2020

#########################################################
######## Prorrateo ########

# Porcentaje de concentración de la población No Especificada

## Para Hombres
Pob_Total_Hombres_2020 <- sum(Pob2020$Hombres)
Pob_NE_Hombres_2020 <- Pob2020$Hombres[length(Pob2020$Edad)] # Obtiene la Pob NE de Hombres, que se encuentra en el último renglón de Pob2020
alfa_Hombres_2020 <- (Pob_NE_Hombres_2020 / (Pob_Total_Hombres_2020 - Pob_NE_Hombres_2020))
alfa_Hombres_2020

## Para Mujeres
Pob_Total_Mujeres_2020 <- sum(Pob2020$Mujeres)
Pob_NE_Mujeres_2020 <- Pob2020$Mujeres[length(Pob2020$Edad)] # Obtiene la Pob NE de Mujeres, que se encuentra en el último renglón de Pob2020
alfa_Mujeres_2020 <- (Pob_NE_Mujeres_2020 / (Pob_Total_Mujeres_2020 - Pob_NE_Mujeres_2020))
alfa_Mujeres_2020

# Creamos Matriz donde ira la población prorrateada
Pob2020_Prorrateo <- matrix(NA, length(Pob2020$Edad) - 1, 3) # 3 columnas, una fila menos que Pob2020, se llena de NA (nulos)
colnames(Pob2020_Prorrateo) <- c("Edad", "Hombres", "Mujeres") # Asignamos los nombres a las columnas
Pob2020_Prorrateo <- data.frame(Pob2020_Prorrateo) # Convertimos la matriz en dataframe
Pob2020_Prorrateo$Edad <- Pob2020$Edad[-length(Pob2020$Edad)] # Asignamos nombres a cada fila de la columna Edad, iguales a los de Pob2020 pero sin la población NE

# Prorrateamos población

## Para Hombres
if(alfa_Hombres_2020 >= 0.05) {
  # Si la población NE es mayor o igual al 5% prorrateamos
  for (i in 1:(length(Pob2020$Edad) - 1)) {
    Pob2020_Prorrateo$Hombres[i] <- Pob2020$Hombres[i] * (1 + alfa_Hombres_2020)
  }
  
} else {
  # Si la población NE es menor al 5% ignoramos la fila de población NE
  Pob2020_Prorrateo$Hombres <- Pob2020$Hombres[-length(Pob2020$Edad)]
}

## Para Mujeres
if(alfa_Mujeres_2020 >= 0.05) {
  # Si la población NE es mayor o igual al 5% prorrateamos
  for (i in 1:(length(Pob2020$Edad) - 1)) {
    Pob2020_Prorrateo$Mujeres[i] <- Pob2020$Mujeres[i] * (1 + alfa_Mujeres_2020)
  }
  
} else {
  # Si la población NE es menor al 5% ignoramos la fila de población NE
  Pob2020_Prorrateo$Mujeres <- Pob2020$Mujeres[-length(Pob2020$Edad)]
}

# Compración
sum(Pob2020_Prorrateo$Hombres) == sum(Pob2020$Hombres[1:(length(Pob2020$Edad) - 1)])
sum(Pob2020_Prorrateo$Mujeres) == sum(Pob2020$Mujeres[1:(length(Pob2020$Edad) - 1)])

# Ver dataframe en pestaña nueva
View(Pob2020_Prorrateo)

# Creamos un archivo .csv con la información de Pob2020_Prorrateo
#write.csv(Pob2020_Prorrateo, "D:\\6° Semestre\\Demografía\\Proyecto Demografía\\Pob2020_Prorrateo.csv")

#########################################################
######## Método de 1/16 ########

# Se aplica a las poblaciones por grupos quinquenales desde 10-14 hasta 70-74 años
# Las poblaciones a las que no se les aplica no sufren cambios

# Generamos un dataframe para alojar los grupos quinquenales
quinquenios2020 <- data.frame(Edad = rep(NA, 18), # repite NA (nulos) 18 veces
                              Hombres = rep(NA, 18),
                              Mujeres = rep(NA, 18))
# colnames(quinquenios2020) <- c("Edad", "Hombres", "Mujeres")

# Rellenamos las columnas 2 y 3 con la información correspondiente 
# de la población de Hombres y Mujeres para cada quinquenio respectivamente
for (i in seq(5,85,by = 5)) {
  quinquenios2020[(i/5),2:3] <- cumsum(Pob2020_Prorrateo[(i-4):i,2:3])[5,]
}
quinquenios2020[18,2:3] <- cumsum(Pob2020_Prorrateo[86:101,2:3])[16,]

# Rellenamos la columna de Edad con los nombres de cada quinquenio correspondiente
for (i in 1:17) {
  quinquenios2020[i, 1] <- paste0(5*(i-1), "-", 5*i-1) # Concatenar texto, columna de Edad
}
quinquenios2020[18, 1] <- "85 y más"
# quinquenios2020$Edad <- c("0-4", "5-9", "10-14", "15-19", "20-24", "25-29", "30-34", "35-39", "40-44", "45-49", 
#                          "50-54", "55-59", "60-64", "65-69", "70-74", "75-79", "80-84","85 y más")

# Enumeramos los renglones
rownames(quinquenios2020) <- c(seq(1:18))

# Ver dataframe en pestaña nueva
View(quinquenios2020)

Correccion2020 <- quinquenios2020 
# Método de 1/16
for (i in 3:15) {
  Correccion2020[i,2:3] <- (1/16)*(-1*quinquenios2020[i+2, 2:3]
                                   +4*quinquenios2020[i+1, 2:3]
                                   +10*quinquenios2020[i, 2:3]
                                   +4*quinquenios2020[i-1, 2:3]
                                   -1*quinquenios2020[i-2, 2:3])
  
}
Correccion2020

fac_cuadratura2020  <-  Correccion2020
fac_cuadratura2020$Hombres  <-  Correccion2020$Hombres / sum(Correccion2020$Hombres)
fac_cuadratura2020$Mujeres  <-  Correccion2020$Mujeres / sum(Correccion2020$Mujeres)

Correccion2020_cuadratura  <-  Correccion2020
Correccion2020_cuadratura$Hombres  <-  sum(Pob2020_Prorrateo$Hombres) * fac_cuadratura2020$Hombres
Correccion2020_cuadratura$Mujeres  <-  sum(Pob2020_Prorrateo$Mujeres) * fac_cuadratura2020$Mujeres
View(Correccion2020_cuadratura)

# Corroborar:
sum(Pob2020_Prorrateo$Hombres) == sum(Correccion2020_cuadratura$Hombres)
sum(Pob2020_Prorrateo$Mujeres) == sum(Correccion2020_cuadratura$Mujeres)

# Creamos un archivo .csv con la información de quinquenios2020
#write.csv(quinquenios2020, "D:\\6° Semestre\\Demografía\\Proyecto Demografía\\quinquenios2020.csv")

# Creamos un archivo .csv con la información de Correccion2020_cuadratura
#write.csv(Correccion2020_cuadratura, "D:\\6° Semestre\\Demografía\\Proyecto Demografía\\Correccion2020_cuadratura.csv")

# Redondear
Correccion2020_cuadratura_redondeo <- Correccion2020_cuadratura
Correccion2020_cuadratura_redondeo[,2:3] <- round(Correccion2020_cuadratura_redondeo[,2:3])
rownames(Correccion2020_cuadratura_redondeo) <- c(seq(1:18))
View(Correccion2020_cuadratura_redondeo)

# Creamos un archivo .csv con la información de Correccion2020_cuadratura_redondeo
#write.csv(Correccion2020_cuadratura_redondeo, "D:\\6° Semestre\\Demografía\\Proyecto Demografía\\Correccion2020_cuadratura_redondeo.csv")

# Vemos que al redondear ya no queda igual:
sum(Pob2020_Prorrateo$Hombres) == sum(Correccion2020_cuadratura_redondeo$Hombres)
sum(Pob2020_Prorrateo$Mujeres) == sum(Correccion2020_cuadratura_redondeo$Mujeres)

#########################################################
#########################################################

######## IMPRESIÓN DE RESULTADOS ########

nombresFilas <- c("Censo 2010", "Censo 2020")

# Índice Whipple:
Whipple_Hombres <- c(Whipple_H2010, Whipple_H2020) # Vector con el Índice Whipple de los Hombres de los censos 2010, 2020
Whipple_Mujeres <- c(Whipple_M2010, Whipple_M2020) # Vector con el Índice Whipple de las Mujeres de los censos 2010, 2020
Indice_Whipple <- data.frame(nombresFilas, Whipple_Hombres, Whipple_Mujeres) # Creamos un dataframe con los datos
names(Indice_Whipple) <- c("Índice Whipple", "Hombres", "Mujeres") # Asignamos nombres a las columnas
View(Indice_Whipple) # Ver dataframe en pestaña nueva

# Índice Myers:
Myers_Hombres <- c(Myers_H2010, Myers_H2020) # Vector con el Índice Myers de los Hombres de los censos 2010, 2020
Myers_Mujeres <- c(Myers_M2010, Myers_M2020) # Vector con el Índice Myers de las Mujeres de los censos 2010, 2020
Indice_Myers <- data.frame(nombresFilas, Myers_Hombres, Myers_Mujeres) # Creamos un dataframe con los datos
names(Indice_Myers) <- c("Índice Myers", "Hombres", "Mujeres") # Asignamos nombres a las columnas
View(Indice_Myers) # Ver dataframe en pestaña nueva

# Índice INU: 
I_Hombres <- c(I_H2010, I_H2020) # Vector con el Índice de los Hombres de los censos 2010, 2020
I_Mujeres <- c(I_M2010, I_M2020) # Vector con el Índice de las Mujeres de los censos 2010, 2020
I_AmbosSexos <- c(I_S2010, I_S2020) # Vector con el Índice de Ambos Sexos de los censos 2010, 2020
I_NU <- c(I_NU2010, I_NU2020) # Vector con el Índice de Naciones Unidas de los censos 2010, 2020
Indice_NacionesUnidas <- data.frame(nombresFilas, I_Hombres, I_Mujeres, I_AmbosSexos, I_NU) # Creamos un dataframe con los datos
names(Indice_NacionesUnidas) <- c("Índice Naciones Unidas", "Hombres", "Mujeres", "Ambos Sexos", "INU") # Asignamos nombres a las columnas
View(Indice_NacionesUnidas) # Ver dataframe en pestaña nueva

# Índice de Masculinidad
#     Creamos un archivo .csv con la información de los índices de masculinidad
#write.csv(T_IM2010, "D:\\6° Semestre\\Demografía\\Proyecto Demografía\\I_M2010.csv")
#write.csv(T_IM2020, "D:\\6° Semestre\\Demografía\\Proyecto Demografía\\I_M2020.csv")

# Razón de Dependencia:
RD_Hombres <- c(RD_H2010, RD_H2020) # Vector con la Razón de Dependencia de los Hombres de los censos 2010, 2020
RD_Mujeres <- c(RD_M2010, RD_M2020) # Vector con la Razón de Dependencia de las Mujeres de los censos 2010, 2020
RD_General <- c(RD_2010, RD_2020) # Vector con la Razón de Dependencia General de los censos 2010, 2020
Razon_Dependencia <- data.frame(nombresFilas, RD_Hombres, RD_Mujeres, RD_General) # Creamos un dataframe con los datos
names(Razon_Dependencia) <- c("Razón de Dependencia", "Hombres", "Mujeres", "General") # Asignamos nombres a las columnas
View(Razon_Dependencia) # Ver dataframe en pestaña nueva

# Prorrateo
alfa_Hombres <- c(alfa_Hombres_2010, alfa_Hombres_2020) # Vector con el valor de alfa de los Hombres de los censos 2010, 2020
alfa_Mujeres <- c(alfa_Mujeres_2010, alfa_Mujeres_2020) # Vector con el valor de alfa de los Mujeres de los censos 2010, 2020
alfas <- data.frame(nombresFilas, alfa_Hombres, alfa_Mujeres) # Creamos un dataframe con los datos
names(alfas) <- c("Alfas", "Hombres", "Mujeres") # Asignamos nombres a las columnas
View(alfas) # Ver dataframe en pestaña nueva
