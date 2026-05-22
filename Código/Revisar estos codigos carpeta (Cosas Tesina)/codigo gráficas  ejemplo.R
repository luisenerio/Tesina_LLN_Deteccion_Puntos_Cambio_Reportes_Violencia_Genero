##
###Gráficas ejemplo para marco teorico
#Single changepoint

## ejemplo de serie de tiempo con un punto de cambio
library(ggplot2)
set.seed(3)
x=1:600
y=c(rnorm(250,1.5,sd=0.5),rnorm(350,0,sd=0.5))
segmentos <- c(rep('segmento 1', 250), rep('segmento 2', 350))
datos1 <- data.frame(x,y,segmentos)
ggplot(datos1,aes(x=x,y=y))+geom_line()+ geom_segment(aes(x=1,xend=250,y=1.5,yend=1.5),colour='red',lwd=1.5,linetype="dashed")+
   geom_segment(aes(x=250,xend=600,y=0,yend=0),colour='red',lwd=1.5,linetype="dashed")



library(EnvCpt)
x=arima.sim(model=list(ar=c(0.7,0.2)),n=500)+0.01*(1:500)
out=envcpt(x, penalty='Manual',pen.value=c(5,100)) # runs a subset of models (those with AR components)
           
plot(out)