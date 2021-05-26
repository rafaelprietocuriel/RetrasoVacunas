require(viridis)
DB <- read.csv("Serie vacunas 20210522.csv")
names(DB)[1] <- "fecha"

#### el archivo contiene dos series de tiempo:
#### vacunas aplicadas y vacunas recibidas

#### cálculo de fechas
#### para el cálculo, se crea un data.frame enorme, con
#### una fila para cada vacuna, con un modelo FIFO de aplicación
#### para cada vacuna, su fecha de aplicación y de recepción es registrado
#### así como su retraso = aplicación - recepción
Recibidas <- c()
Aplicadas <- c()
for(k in 1:140){ #140 días de datos
 Recibidas <- c(Recibidas, 
                rep(DB$fecha[k+1],
                    (DB$recibidas[k+1]-DB$recibidas[k])/1))
 Aplicadas <- c(Aplicadas, 
                rep(DB$fecha[k+1],
                    1.*(DB$aplicadas[k+1]-DB$aplicadas[k])/1))
}
Retraso <- Aplicadas - Recibidas[1:length(Aplicadas)]

# para entender la distribución del retraso
hist(Retraso)

# el retraso promedio
sum(Retraso)/max(DB$aplicadas)

#retraso por día
ByD <- aggregate(Retraso,
                 by = list(Aplicadas),
                 FUN = mean)

#retraso por semana
ByS <- aggregate(Retraso, #semanas
                 by = list(floor(Aplicadas/7)),
                 FUN = mean)

#retraso por mes
ByM <- aggregate(Retraso, #meses
                 by = list(floor((Aplicadas-6)/30)),
                 FUN = mean)
names(ByD)[1] <- "fecha"
names(ByS)[1] <- "fecha"
names(ByM)[1] <- "fecha"

#### figura para corroborar datos
plot(ByD$fecha,
     ByD$x,
     type = "h")
abline(h = 15)

### esquema de colores
cols <- inferno(1000, direction = -1)
cols <- mako(1000, direction = -1)
cols <- turbo(1000, 
              end = 0.7,
              begin = 0.001,
              direction = 1)

### para las gráficas, se puede utilizar también
### el número de días vacuna, que es la diferencia entre
### aplicadas y recibidas por día
### nota que para el cálculo, se necesita más precisión
DB$diasVacuna <- cumsum(DB$recibidas - DB$aplicadas)
DB$retraso <- DB$diasVacuna/DB$aplicadas

#### figura por días de vacuna
y1 <- DB$aplicadas
y2 <- DB$recibidas
y3 <- DB$retraso
cols <- inferno(1000, direction = -1)
png("Retraso.png",
    width = 1000, height = 700)
par(mar = c(.1,.1,.1,.1))
{
plot(DB$fecha, 
     y,
     ylim = c(0,16),
     xlab = "", ylab = "", 
     xaxt = "n", yaxt = "n",
     type = "h", 
     lwd = 5,
     col = NA)
for(k in 1:3){
 points(range(DB$fecha),
        0*range(DB$fecha)+k*5,
        col = "gray60",
        type = "l",
        lwd = 4,
        lty = 5)
}
points(DB$fecha, 
     y,
     ylim = c(0,16),
     xlab = "", ylab = "", 
     xaxt = "n", yaxt = "n",
     type = "h", 
     lwd = 7,
     col = cols[1+floor(999*y/max(y))])
s <- c(0,31, 28, 31, 30,21)
# for(k in cumsum(s)){
#     points(DB$fecha[1]-0.5+c(k,k),
#            c(0, 100),
#            type = "l")}
}
dev.off()

#### aplicadas recibidas
y <- DB$recibidas
y2 <- DB$aplicadas
cols <- turbo(1000, 
              end = 0.8,
              begin = 0.1,
              direction = 1)
cols2 <- rep(rgb(1,1,1,.8), 
             1000)
png("RecibidasAplicadas.png",
    width = 1000, height = 700)
par(mar = c(.1,.1,.1,.1))
{
    plot(DB$fecha, 
         y,
         ylim = c(0,33000000),
         xlab = "", ylab = "", 
         xaxt = "n", yaxt = "n",
         type = "h", 
         lwd = 5,
         col = NA)
    for(k in 1:3){
        points(range(DB$fecha),
               0*range(DB$fecha)+k*10000000
               ,
               col = "gray60",
               type = "l",
               lwd = 4,
               lty = 5)
    }
    points(DB$fecha, 
           y,
           ylim = c(0,16),
           xlab = "", ylab = "", 
           xaxt = "n", yaxt = "n",
           type = "h", 
           lwd = 7,
           col = cols[1+floor(999*y/max(y))])
    

   polygon(c(DB$fecha, rev(DB$fecha)),
            c(y2, 0*y2-10000000),
            border =NA,
            col = rgb(1,1,1,.7))
    s <- c(0,31, 28, 31, 30,21)
    # for(k in cumsum(s)){
    #     points(DB$fecha[1]-0.5+c(k,k),
    #            c(0, 100),
    #            type = "l")}
    
    points(DB$fecha, y,
           type = "l",  
           lwd = 15, col = "tomato")
    points(DB$fecha, y2,
           type = "l",  
           lwd = 15, col = "navy")
}
dev.off()

#### aplicadas - recibidas
y <- DB$recibidas
y2 <- DB$aplicadas
y1 <- y - y2
cols <- turbo(1000, 
              end = 0.9,
              begin = 0.1,
              direction = 1)
cols2 <- rep(rgb(1,1,1,.8), 
             1000)
png("RecibidasAplicadas2.png",
    width = 1000, height = 700)
par(mar = c(.1,.1,.1,.1))
{
    plot(DB$fecha, 
         y,
         ylim = c(0,33000000),
         xlab = "", ylab = "", 
         xaxt = "n", yaxt = "n",
         type = "h", 
         lwd = 5,
         col = NA)
    for(k in 1:3){
        points(range(DB$fecha),
               0*range(DB$fecha)+k*10000000
               ,
               col = "gray60",
               type = "l",
               lwd = 4,
               lty = 5)
    }
    points(DB$fecha, 
           y,
           ylim = c(0,16),
           xlab = "", ylab = "", 
           xaxt = "n", yaxt = "n",
           type = "h", 
           lwd = 7,
           col = cols[1+floor(999*y1/max(y1))])
    
    
    polygon(c(DB$fecha, rev(DB$fecha)),
            c(y2, 0*y2-10000000),
            border =NA,
            col = rgb(1,1,1,.7))
    s <- c(0,31, 28, 31, 30,21)
    points(DB$fecha, y,
           type = "l",  
           lwd = 15, col = "tomato")
    points(DB$fecha, y2,
           type = "l",  
           lwd = 15, col = "navy")
}
dev.off()


#### retraso por dia
y <- c(0, ByD$x)
cols <- viridis(1000, direction = -1)
png("RetrasoPorDia.png",
    width = 1000, height = 700)
par(mar = c(.1,.1,.1,.1))
{
    plot(DB$fecha, 
         y,
         ylim = c(0,26),
         xlab = "", ylab = "", 
         xaxt = "n", yaxt = "n",
         type = "h", 
         lwd = 5,
         col = NA)
    for(k in 1:5){
        points(range(DB$fecha),
               0*range(DB$fecha)+k*5,
               col = "gray60",
               type = "l",
               lwd = 4,
               lty = 5)
    }
    points(DB$fecha, 
           y,
           ylim = c(0,16),
           xlab = "", ylab = "", 
           xaxt = "n", yaxt = "n",
           type = "h", 
           lwd = 7,
           col = cols[1+floor(999*y/max(y))])
    s <- c(0,31, 28, 31, 30,21)
}
dev.off()