# Inferencia Estadística
# Composición del Senado por mayoría y minoría relativa en las votaciones de 2024

# Realizado por ROM

#################################################################
#################################################################

# Borramos a las variables creadas anteriormente
rm(list=ls())

# Limpiamos la consola para tener un lugar de trabajo más limpio
cat("\14")

#Librerías de R a utilizar
library(readr) # Permite importar datos desde archivos externos como .csv en dataframes
library(data.table) # Para manejar y analizar grandes volúmenes de datos de forma muy rápida y eficiente.

# Seleccionar la ruta del directorio de trabajo
directorioTrabajo <- choose.dir()
directorioTrabajo

# Establecer la ruta del directorio como directorio de trabajo
setwd(directorioTrabajo)

# Imprime en la consola los nombres de los archivos y su extensión que existen en el directorio de trabajo establecido
list.files()

#################################################################
#################################################################

# Ruta del archivo con los datos de las votaciones del senado
# en este archivo le quitamos las comillas a "SEN_2024.csv" obtenido del INE
# usando la función de reemplazar del bloc de notas
# esto con el fin de que podamos usar "ID_ENTIDAD" como una variable de tipo int
ruta = "SEN_2024_1.csv"

# read_delim permite importar archivos delimitados como un archivo csv que esta delimitado por comas o un archivo tsv delimitado por tabs.
SENADO_2024 = read_delim (ruta, #donde se encuentra el archivo a importar
                       skip = 6, # líneas que se debe saltar, información inútil que no deja ejecutar esta función
                       delim = "|", # delimitador entre campo y campo, hay que checar el archivo en bloc de notas
                       escape_double = FALSE, 
                       col_types = cols( #especificar qué tipos de datos deben tener las columnas en su marco de datos importado
                         ID_ENTIDAD = col_integer(),
                         PAN = col_integer(),
                         PRI= col_integer(),
                         PRD= col_integer(),
                         PVEM= col_integer(),
                         PT= col_integer(),
                         MC= col_integer(),
                         MORENA= col_integer(),
                         PAN_PRI_PRD= col_integer(),
                         PAN_PRI= col_integer(),
                         PAN_PRD= col_integer(),
                         PRI_PRD= col_integer(),
                         PVEM_PT_MORENA= col_integer(),
                         PVEM_PT= col_integer(),
                         PVEM_MORENA= col_integer(),
                         PT_MORENA = col_integer(),
                         "CANDIDATO/A NO REGISTRADO/A" = col_integer(),
                         "VOTOS NULOS" = col_integer(),
                         FECHA_HORA = col_datetime(format = "%d/%m/%Y %H:%M:%S")), 
                       trim_ws = TRUE) # eliminar los espacios en blanco no deseados del principio y el final de tu string en R

# con este nos aseguramos que lo guarde como data frame
SENADO_2024 = as.data.table(SENADO_2024)

SENADO_2024


# creamos un nuevo data frame con el total de votos de cada partido por estado
PCT_ENTIDAD =  SENADO_2024 [ , .(sum(PAN),
                                  sum(PRI),
                                  sum(PRD),
                                  sum(PVEM),
                                  sum(PT),
                                  sum(MC),
                                  sum(MORENA),
                                  sum(PAN_PRI_PRD),
                                  sum(PAN_PRI),
                                  sum(PRI_PRD),
                                  sum(PAN_PRD),
                                  sum(PVEM_PT_MORENA),
                                  sum(PVEM_PT),
                                  sum(PVEM_MORENA),
                                  sum(PT_MORENA),
                                  sum(`CANDIDATO/A NO REGISTRADO/A`),
                                  sum(`VOTOS NULOS`) ),
                                  by = c("ID_ENTIDAD","ENTIDAD") ] 

PCT_ENTIDAD

# ponemos nombres a las columnas
names(PCT_ENTIDAD) = c("ID_ENTIDAD", "ENTIDAD", "PAN", "PRI", "PRD", "PVEM", "PT", "MC", "MORENA", "PAN_PRI_PRD", "PAN_PRI", "PAN_PRD", "PRI_PRD", "PVEM_PT_MORENA", "PVEM_PT", "PVEM_MORENA", "PT_MORENA", "CANDIDATO/A NO REGISTRADO/A", "VOTOS NULOS")

PCT_ENTIDAD


# ruta del archivo con los datos de los convenios entre partidos
ruta2 = "convenios_coaliciones_senadores_2024.csv"

convenios_coaliciones_senadores_2024 = read_delim (ruta2, #donde se encuentra el archivo a importar
            delim = ",", # delimitador entre campo y campo, hay que checar el archivo en bloc de notas
            escape_double = FALSE, # preguntar que hace
            col_types = cols( #especificar qué tipos de datos deben tener las columnas en su marco de datos importado
              ID_ENTIDAD = col_integer() ) )

# nos aseguramos que lo haya guardado como data frame    
convenios_coaliciones_senadores_2024 = as.data.table(convenios_coaliciones_senadores_2024)


# merge nos permite realizar "joins" entre tablas. El join es realizado sobre las columnas o sobre las filas. En el primer caso, las etiquetas de las filas son ignoradas. 
PCT_ENTIDAD = merge(PCT_ENTIDAD, convenios_coaliciones_senadores_2024, by = "ID_ENTIDAD") 

PCT_ENTIDAD

# reemplaza los NA por 0
PCT_ENTIDAD <- replace(PCT_ENTIDAD, is.na(PCT_ENTIDAD), 0)

PCT_ENTIDAD

#ROM
# Vectores que vamos a usar para saber que partido y con cuantos votos gano la mayoria relativa
nombrePrimerLugarEnt <- c("borrar") 
votosPrimerLugarEnt <- c(0)

# Vectores que vamos a usar para saber que partido y con cuantos votos gano la minoria relativa
nombreSegundoLugarEnt <- c("borrar")
votosSegundoLugarEnt <- c(0)

# for-sito para saber quien quedo en primer y segundo lugar, y con cuantos votos, en las votaciones
for (x in 1:32) {
  numeroEstado = as.integer(x)
  
  # votos Movimiento Ciudadano en el estado número x
  votosMC <- as.integer(PCT_ENTIDAD[x, 8]) 
  
  # votos por cantidato no registrado en el estado número x
  votosCandNoReg <- as.integer(PCT_ENTIDAD[x, 18])
  
  # votos nulos en el estado número x
  votosNulos <- as.integer(PCT_ENTIDAD[x, 19])
  
  # Si hay TODAS las coaliciones
  if ( (PCT_ENTIDAD[x, 21] != 0) & (PCT_ENTIDAD[x, 23] != 0)) {
    # Coalición 1: PAN - PRI - PRD = Fuerza y corazón por México (FCM)
    votosC1_FCM <- as.integer(sum(PCT_ENTIDAD[x, 3:5]) + sum(PCT_ENTIDAD[x, 10:13]))
    
    # Coalición 2: MORENA - PT - PV = 4T
    votosC2_4T <- as.integer(sum(PCT_ENTIDAD[x, 6:7]) + (PCT_ENTIDAD[x, 9]) + sum(PCT_ENTIDAD[x, 14:17])) 
    
    # cantidad de votos por partidos
    votosPartidosEst <- c(votosC1_FCM, votosC2_4T, votosMC, votosCandNoReg, votosNulos)
    
    # nombre de los partidos
    nombresPartidosEst <- c("PAN_PRI_PRD", "PVEM_PT_MORENA", "MC", "CANDIDATO/A NO REGISTRADO/A", "VOTOS NULOS")
    
    # data frame con el nombre y los votos por partido
    votosEnt <- data.frame(nombresPartidosEst, votosPartidosEst)
    
    # ordenamos votosEnt de mayor a menor según la coumna de votos
    votosEnt <- votosEnt[order(votosEnt$votosPartidosEst, decreasing = TRUE),]
    
    partidoPrimerLugar <- as.character(votosEnt[1, 1])
    nombrePrimerLugarEnt <- c(nombrePrimerLugarEnt, partidoPrimerLugar)
    
    partidoSegundoLugar <- as.character(votosEnt[2, 1])
    nombreSegundoLugarEnt <- c(nombreSegundoLugarEnt, partidoSegundoLugar)
    
    votosPrimerLugar <- as.integer(votosEnt[1, 2])
    votosPrimerLugarEnt <- c(votosPrimerLugarEnt, votosPrimerLugar)
    
    votosSegundoLugar <- as.integer(votosEnt[2, 2])
    votosSegundoLugarEnt <- c(votosSegundoLugarEnt, votosSegundoLugar)
    
  } else {
    #Si falta alguna coalición
    
    #Si se cumple la coalición 1, pero no la coalición 2 (4T)
    if (PCT_ENTIDAD[x, 21] != 0) {
      # Coalición 1: PAN - PRI - PRD = Fuerza y corazón por México (FCM)
      votosC1_FCM <- as.integer(sum(PCT_ENTIDAD[x, 3:5]) + sum(PCT_ENTIDAD[x, 10:13]))
      
      votosPVEM <- as.integer(PCT_ENTIDAD[x, 6])
      
      votosPT <- as.integer(PCT_ENTIDAD[x, 7])
      
      votosMORENA <- as.integer(PCT_ENTIDAD[x, 9])
      
      votosPartidosEst <- c(votosC1_FCM, votosPVEM, votosPT, votosMORENA, votosMC, votosCandNoReg, votosNulos)
      
      # nombre de los partidos
      nombresPartidosEst <- c("PAN_PRI_PRD", "PVEM", "PT", "MORENA", "MC", "CANDIDATO/A NO REGISTRADO/A", "VOTOS NULOS") 
      
      # data frame con el nombre y los votos por partido
      votosEnt <- data.frame(nombresPartidosEst, votosPartidosEst)
      
      # ordenamos votosEnt de mayor a menor según la coumna de votos
      votosEnt <- votosEnt[order(votosEnt$votosPartidosEst, decreasing = TRUE),]
      
      partidoPrimerLugar <- as.character(votosEnt[1, 1])
      nombrePrimerLugarEnt <- c(nombrePrimerLugarEnt, partidoPrimerLugar)
      
      partidoSegundoLugar <- as.character(votosEnt[2, 1])
      nombreSegundoLugarEnt <- c(nombreSegundoLugarEnt, partidoSegundoLugar)
      
      votosPrimerLugar <- as.integer(votosEnt[1, 2])
      votosPrimerLugarEnt <- c(votosPrimerLugarEnt, votosPrimerLugar)
      
      votosSegundoLugar <- as.integer(votosEnt[2, 2])
      votosSegundoLugarEnt <- c(votosSegundoLugarEnt, votosSegundoLugar)
      
      
    } else {
      #Si se cumple la coalición 2, pero no la coalición 1 (FCM)
      if (PCT_ENTIDAD[x, 23] != 0) {
        # Coalición 2: MORENA - PT - PV = 4T
        votosC2_4T <- as.integer(sum(PCT_ENTIDAD[x, 6:7]) + (PCT_ENTIDAD[x, 9]) + sum(PCT_ENTIDAD[x, 14:17])) 
        
        votosPAN <- as.integer(PCT_ENTIDAD[x, 3])
        
        votosPRI <- as.integer(PCT_ENTIDAD[x, 4])
        
        votosPRD <- as.integer(PCT_ENTIDAD[x, 5])
        
        votosPartidosEst <- c(votosPAN, votosPRI, votosPRD, votosC2_4T, votosMC, votosCandNoReg, votosNulos)
        
        # nombre de los partidos
        nombresPartidosEst <- c("PAN", "PRI", "PRD", "PVEM_PT_MORENA", "MC", "CANDIDATO/A NO REGISTRADO/A", "VOTOS NULOS") 
        
        # data frame con el nombre y los votos por partido
        votosEnt <- data.frame(nombresPartidosEst, votosPartidosEst)
        
        # ordenamos votosEnt de mayor a menor según la coumna de votos
        votosEnt <- votosEnt[order(votosEnt$votosPartidosEst, decreasing = TRUE),]
        
        partidoPrimerLugar <- as.character(votosEnt[1, 1])
        nombrePrimerLugarEnt <- c(nombrePrimerLugarEnt, partidoPrimerLugar)
        
        partidoSegundoLugar <- as.character(votosEnt[2, 1])
        nombreSegundoLugarEnt <- c(nombreSegundoLugarEnt, partidoSegundoLugar)
        
        votosPrimerLugar <- as.integer(votosEnt[1, 2])
        votosPrimerLugarEnt <- c(votosPrimerLugarEnt, votosPrimerLugar)
        
        votosSegundoLugar <- as.integer(votosEnt[2, 2])
        votosSegundoLugarEnt <- c(votosSegundoLugarEnt, votosSegundoLugar)
        
        
      } else {
        # Si no hubo coaliciones
        votosPAN <- as.integer(PCT_ENTIDAD[x, 3])
        
        votosPRI <- as.integer(PCT_ENTIDAD[x, 4])
        
        votosPRD <- as.integer(PCT_ENTIDAD[x, 5])
        
        votosPVEM <- as.integer(PCT_ENTIDAD[x, 6])
        
        votosPT <- as.integer(PCT_ENTIDAD[x, 7])
        
        votosMORENA <- as.integer(PCT_ENTIDAD[x, 9])
        
        votosPartidosEst <- c(votosPAN, votosPRI, votosPRD, votosPVEM, votosPT, votosMORENA, votosMC, votosCandNoReg, votosNulos)
        
        # nombre de los partidos
        nombresPartidosEst <- c("PAN", "PRI", "PRD", "PVEM", "PT", "MORENA", "MC", "CANDIDATO/A NO REGISTRADO/A", "VOTOS NULOS") 
        
        # data frame con el nombre y los votos por partido
        votosEnt <- data.frame(nombresPartidosEst, votosPartidosEst)
        
        # ordenamos votosEnt de mayor a menor según la coumna de votos
        votosEnt <- votosEnt[order(votosEnt$votosPartidosEst, decreasing = TRUE),]
        
        partidoPrimerLugar <- as.character(votosEnt[1, 1])
        nombrePrimerLugarEnt <- c(nombrePrimerLugarEnt, partidoPrimerLugar)
        
        partidoSegundoLugar <- as.character(votosEnt[2, 1])
        nombreSegundoLugarEnt <- c(nombreSegundoLugarEnt, partidoSegundoLugar)
        
        votosPrimerLugar <- as.integer(votosEnt[1, 2])
        votosPrimerLugarEnt <- c(votosPrimerLugarEnt, votosPrimerLugar)
        
        votosSegundoLugar <- as.integer(votosEnt[2, 2])
        votosSegundoLugarEnt <- c(votosSegundoLugarEnt, votosSegundoLugar)
        
        
      } #cierra tercer if (coalición2)
      
    } #cierra el segundo if (coalicion1)
  
  } #cierra el primer if (dos coaliciones)
  
} #cierra el for

# Elimina el primer elementos de los vectores, que solo pusimos para crear un vector 
nombrePrimerLugarEnt <- nombrePrimerLugarEnt[-c(1)]
votosPrimerLugarEnt <- votosPrimerLugarEnt[-c(1)]
nombreSegundoLugarEnt <- nombreSegundoLugarEnt[-c(1)]
votosSegundoLugarEnt <- votosSegundoLugarEnt[-c(1)]

#Creamos un data frame con la información de los vectores por estado
resultadosEst <- data.frame(1:32, nombrePrimerLugarEnt, votosPrimerLugarEnt, nombreSegundoLugarEnt, votosSegundoLugarEnt)

#Ponemos nombre a las columnas del data frame
names(resultadosEst) <- c("ID_ENTIDAD", "Partido_Primer_Lugar", "Votos_Primer_Lugar", "Partido_Segundo_Lugar", "Votos_Segundo_Lugar")

resultadosEst

#Unimos con PCT 
PCT_ENTIDAD = merge(PCT_ENTIDAD, resultadosEst, by ="ID_ENTIDAD")

PCT_ENTIDAD


# Vectores que vamos a usar para saber como va a estar constituida la mayoria relativa
mayoriaRelativaOp1 <- c("borrar")
mayoriaRelativaOp2 <- c("borrar")

# for-sito para saber como quedo la Mayoria Relativa
for (y in 1:32) {
  ganador <- as.character(PCT_ENTIDAD[y, 27])
  
  #Si gano el PAN_PRI_PRD
  if(ganador == "PAN_PRI_PRD") {
    op1 <- as.character(PCT_ENTIDAD[y, 21])
    op2 <- as.character(PCT_ENTIDAD[y, 22])
    
  } else {
    #Si gano el PVEM_PT_MORENA
    if (ganador == "PVEM_PT_MORENA") {
      op1 <- as.character(PCT_ENTIDAD[y, 23])
      op2 <- as.character(PCT_ENTIDAD[y, 24])
      
    } else {
      # si es un solo partido y no coalición
      op1 <- as.character(PCT_ENTIDAD[y, 27])
      op2 <- as.character(PCT_ENTIDAD[y, 27])
      
    } # fin if coalicion 2
  } # fin if coalicion 1
  
  mayoriaRelativaOp1 <- c(mayoriaRelativaOp1, op1)
  mayoriaRelativaOp2 <- c(mayoriaRelativaOp2, op2)
} # fin 2o for-sito

# Elimina el primer elementos de los vectores, que solo pusimos para crear un vector 
mayoriaRelativaOp1 <- mayoriaRelativaOp1[-c(1)]
mayoriaRelativaOp2 <- mayoriaRelativaOp2[-c(1)]

#Convierte a data frame los vectores
mayoriaRelativa <- data.frame(1:32, mayoriaRelativaOp1, mayoriaRelativaOp2)
mayoriaRelativa

#Ponemos nombre a las columnas del data frame
names(mayoriaRelativa) <- c("ID_ENTIDAD", "Mayoria_Relativa_Op1", "Mayoria_Relativa_Op2")
mayoriaRelativa

#Unimos con PCT 
PCT_ENTIDAD = merge(PCT_ENTIDAD, mayoriaRelativa, by ="ID_ENTIDAD")

PCT_ENTIDAD


# Vectores que vamos a usar para saber como va a estar consituida la minoria relativa
minoriaRelativaOp <- c("borrar")

# for-sito para saber como quedo la Minoria Relativa
for (z in 1:32) {
  semiGanador <- as.character(PCT_ENTIDAD[z, 29])
  #Si gano el PAN_PRI_PRD
  if(semiGanador == "PAN_PRI_PRD") {
    op <- as.character(PCT_ENTIDAD[z, 21])
    
  } else {
    #Si gano el PVEM_PT_MORENA
    if (semiGanador == "PVEM_PT_MORENA") {
      op <- as.character(PCT_ENTIDAD[z, 23])
      
    } else {
      # si es un solo partido z no coalición
      op <- as.character(PCT_ENTIDAD[z, 29])
      
    } # fin if coalicion 2
  } # fin if coalicion 1
  
  minoriaRelativaOp <- c(minoriaRelativaOp, op)
} # fin 3o for-sito

# Elimina el primer elementos de los vectores, que solo pusimos para crear un vector 
minoriaRelativaOp <- minoriaRelativaOp[-c(1)]

#Convierte a data frame los vectores
minoriaRelativa <- data.frame(1:32, minoriaRelativaOp)
minoriaRelativa

#Ponemos nombre a las columnas del data frame
names(minoriaRelativa) <- c("ID_ENTIDAD", "Minoria_Relativa_Op")
minoriaRelativa

#Unimos con PCT 
PCT_ENTIDAD = merge(PCT_ENTIDAD, minoriaRelativa, by ="ID_ENTIDAD")

PCT_ENTIDAD


# Para saber cuantos senadores tiene cada partido
sen_PAN <- 0
sen_PRI <- 0
sen_PRD <- 0
sen_PVEM <- 0
sen_PT <- 0
sen_MC <- 0
sen_MORENA <- 0

sen_Partidos <- c(sen_PAN, sen_PRI, sen_PRD, sen_PVEM, sen_PT, sen_MC, sen_MORENA)
names(sen_Partidos) <- c("total_Sen_PAN", "total_Sen_PRI", "total_Sen_PRD", "total_Sen_PVEM", "total_Sen_PT", "total_Sen_MC", "total_Sen_MORENA")
sen_Partidos

# Checa cuantos senadores hay de cada partido en Mayoria_Relativa_Op1
for (x in 1:32) {
  partido_MR_Op1 <- as.character(PCT_ENTIDAD[x, 31])
  if(partido_MR_Op1 == "PAN") {
    sen_PAN <- sen_PAN + 1
  } else {
    if(partido_MR_Op1 == "PRI") {
      sen_PRI <- sen_PRI + 1
    } else {
      if(partido_MR_Op1 == "PRD") {
        sen_PRD <- sen_PRD + 1
      } else {
        if(partido_MR_Op1 == "PVEM") {
          sen_PVEM <- sen_PVEM + 1
        } else {
          if(partido_MR_Op1 == "PT") {
            sen_PT <- sen_PT + 1
          } else {
            if(partido_MR_Op1 == "MC") {
              sen_MC <- sen_MC + 1
            } else {
              # if(partido_MR_Op1 == "MORENA")
              sen_MORENA <- sen_MORENA + 1
            }
          }
        }
      }
    }
  }
  
} # fin 4o for-sito

# Checa cuantos senadores hay de cada partido en Mayoria_Relativa_Op2
for (y in 1:32) {
  partido_MR_Op2 <- as.character(PCT_ENTIDAD[y, 32])
  if(partido_MR_Op2 == "PAN") {
    sen_PAN <- sen_PAN + 1
  } else {
    if(partido_MR_Op2 == "PRI") {
      sen_PRI <- sen_PRI + 1
    } else {
      if(partido_MR_Op2 == "PRD") {
        sen_PRD <- sen_PRD + 1
      } else {
        if(partido_MR_Op2 == "PVEM") {
          sen_PVEM <- sen_PVEM + 1
        } else {
          if(partido_MR_Op2 == "PT") {
            sen_PT <- sen_PT + 1
          } else {
            if(partido_MR_Op2 == "MC") {
              sen_MC <- sen_MC + 1
            } else {
              # if(partido_MR_Op2 == "MORENA")
              sen_MORENA <- sen_MORENA + 1
            }
          }
        }
      }
    }
  }
  
} # fin 5o for-sito

# Numero de Senadores de cada partido elegidos por Mayoria Relativa
sen_MR_Partidos <- c(sen_PAN, sen_PRI, sen_PRD, sen_PVEM, sen_PT, sen_MC, sen_MORENA)
totales_Sen_MR_Partidos <- sum(sen_MR_Partidos)
names(sen_MR_Partidos) <- c("total_Sen_PAN_MR", "total_Sen_PRI_MR", "total_Sen_PRD_MR", "total_Sen_PVEM_MR", "total_Sen_PT_MR", "total_Sen_MC_MR", "total_Sen_MORENA_MR")
sen_MR_Partidos


# Checa cuantos senadores hay de cada partido en Minoria_Relativa_Op
for (z in 1:32) {
  partido_mR_Op <- as.character(PCT_ENTIDAD[z, 33])
  if(partido_mR_Op == "PAN") {
    sen_PAN <- sen_PAN + 1
  } else {
    if(partido_mR_Op == "PRI") {
      sen_PRI <- sen_PRI + 1
    } else {
      if(partido_mR_Op == "PRD") {
        sen_PRD <- sen_PRD + 1
      } else {
        if(partido_mR_Op == "PVEM") {
          sen_PVEM <- sen_PVEM + 1
        } else {
          if(partido_mR_Op == "PT") {
            sen_PT <- sen_PT + 1
          } else {
            if(partido_mR_Op == "MC") {
              sen_MC <- sen_MC + 1
            } else {
              # if(partido_mR_Op == "MORENA")
              sen_MORENA <- sen_MORENA + 1
            }
          }
        }
      }
    }
  }
  
} # fin 6o for-sito

# actualizamos sen_Partidos, que ahora nos da el total de senadores por Partidos elegidos por Mayoria y Minoria Relativa
sen_Partidos <- c(sen_PAN, sen_PRI, sen_PRD, sen_PVEM, sen_PT, sen_MC, sen_MORENA)
totales_Sen_Partidos <- sum(sen_Partidos)
names(sen_Partidos) <- c("total_Sen_PAN", "total_Sen_PRI", "total_Sen_PRD", "total_Sen_PVEM", "total_Sen_PT", "total_Sen_MC", "total_Sen_MORENA")
sen_Partidos


# Numero de Senadores de cada partido elegidos por Minoria Relativa
sen_mR_Partidos <- sen_Partidos - sen_MR_Partidos
totales_Sen_mR_Partidos <- sum(sen_mR_Partidos)
names(sen_mR_Partidos) <- c("total_Sen_PAN_mR", "total_Sen_PRI_mR", "total_Sen_PRD_mR", "total_Sen_PVEM_mR", "total_Sen_PT_mR", "total_Sen_MC_mR", "total_Sen_MORENA_mR")
sen_mR_Partidos


# convertimos a data frame los resultados de mayoria, minoria y totales
nombresPartidos <- c("PAN", "PRI", "PRD", "PVEM", "PT", "MC", "MORENA")
nombresPartidos

sen_MR_Partidos <- data.frame(nombresPartidos, sen_MR_Partidos)
names(sen_MR_Partidos) <- c("Partido", "Senadores_Mayoria_Relativa")
sen_MR_Partidos

sen_mR_Partidos <- data.frame(nombresPartidos, sen_mR_Partidos)
names(sen_mR_Partidos) <- c("Partido", "Senadores_Minoria_Relativa")
sen_mR_Partidos

sen_Partidos <- data.frame(nombresPartidos, sen_Partidos)
names(sen_Partidos) <- c("Partido", "Total_Senadores")
sen_Partidos

# data frame con los resultados de las votaciones, 
#dice cuantos senadores por cada partido fueron elegidos por mayoria y minoria relativa, 
# además de dar el total de senadores elegidos de esa forma
resultados_Votaciones_Senadores <- merge(sen_MR_Partidos, sen_mR_Partidos, by="Partido")
resultados_Votaciones_Senadores
resultados_Votaciones_Senadores <- merge(resultados_Votaciones_Senadores, sen_Partidos, by="Partido")
resultados_Votaciones_Senadores

names(resultados_Votaciones_Senadores) <- c("Partido", "Senadores_Mayoria_Relativa", "Senadores_Minoria_Relativa", "Total_Senadores")
resultados_Votaciones_Senadores

# ordenamos de mayor a menor segun el total de senadores obtenidos
resultados_Votaciones_Senadores <- resultados_Votaciones_Senadores[order(resultados_Votaciones_Senadores$Total_Senadores, decreasing = TRUE),]
resultados_Votaciones_Senadores

#Agregamos una fila al final con los datos del total obtenidos en Mayoria y Minoria Relativa, además del total de senadores elegidos de esta forma
totales <- c("TOTALES", totales_Sen_MR_Partidos, totales_Sen_mR_Partidos, totales_Sen_Partidos)
resultados_Votaciones_Senadores <- rbind(resultados_Votaciones_Senadores, totales)
resultados_Votaciones_Senadores
View(resultados_Votaciones_Senadores)

#FIN