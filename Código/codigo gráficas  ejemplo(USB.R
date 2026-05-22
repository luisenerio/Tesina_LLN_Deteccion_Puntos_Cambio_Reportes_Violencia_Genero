##
###Gráficas ejemplo para marco teorico
#Single changepoint

## ejemplo de serie de tiempo con un punto de cambio
library(ggplot2)
library(tidyverse)
set.seed(3)
x=1:600
y=c(rnorm(250,1.5,sd=0.5),rnorm(350,0,sd=0.5))
segmentos <- c(rep('segmento 1', 250), rep('segmento 2', 350))
datos1 <- data.frame(x,y,segmentos)
ggplot(datos1,aes(x=x,y=y))+geom_line()+ geom_segment(aes(x=1,xend=250,y=1.5,yend=1.5),colour='red',lwd=1.5,linetype="dashed")+
   geom_segment(aes(x=250,xend=600,y=0,yend=0),colour='red',lwd=1.5,linetype="dashed")



# grafica cambio em media  y varianza varios segmentos

x=1:500
y=c(rnorm(100,1.5,sd=.15),rnorm(250,2,sd=.3),rnorm(50,1.3,sd=.35),rnorm(100,2.3,sd=.2))
segmentos <- c(rep("segmento1",100),rep("segmento2", 250),rep("segmento3", 50),rep("segmento4", 100))
datos <- data.frame(x,y,segmentos)

ggplot(datos,aes(x=x,y=y))+geom_line()+ labs(title="",x="",y="")  + ylim(c(.5,3))
datos %>% filter(segmentos=='segmento1') %>% ggplot(aes(x=x,y=y)) +geom_line()+ labs(title="",x="",y="")  + ylim(c(.5,3))
datos %>% filter(segmentos=='segmento2') %>% ggplot(aes(x=x,y=y)) +geom_line()+ labs(title="",x="",y="")  + ylim(c(.5,3))
datos %>% filter(segmentos=='segmento3') %>% ggplot(aes(x=x,y=y)) +geom_line()+ labs(title="",x="",y="") + ylim(c(.5,3))
datos %>% filter(segmentos=='segmento4') %>% ggplot(aes(x=x,y=y)) +geom_line()+ labs(title="",x="",y="")  + ylim(c(.5,3))

##########################
###Distintios tipos de cambios
###############################
set.seed(28)
# Change in mean example following EFK
x=1:600
y=c(rnorm(200,1,sd=0.5),rnorm(150,2,sd=0.5),rnorm(150,1.5,sd=0.5),rnorm(100,0.5,sd=0.5))
datos <- data.frame(x,y)
ggplot(datos, aes(x=x,y=y))+ geom_line()+
  geom_segment(aes(x=1,xend=200,y=1,yend=1),colour='red',lwd=1.5,linetype="dashed")+
  geom_segment(aes(x=201,xend=350,y=2,yend=2),colour='red',lwd=1.5,linetype="dashed")+
  geom_segment(aes(x=351,xend=500,y=1.5,yend=1.5),colour='red',lwd=1.5,linetype="dashed")+
  geom_segment(aes(x=501,xend=600,y=.5,yend=.5),colour='red',lwd=1.5,linetype="dashed")+labs(title="a)Serie con cambio en media")


x=1:500
y=c(rnorm(100,0,sd=0.4),rnorm(100,0,sd=0.1),rnorm(200,0,sd=.5),rnorm(100,0,sd=1))
datos <- data.frame(x,y)
ggplot(datos, aes(x=x,y = y)) + geom_line() + geom_segment(aes(x=100,xend=100,y=-3,yend=3),color='blue', linetype='dashed',lwd= 1)+
  geom_segment(aes(x=200,xend=200,y=-3,yend=3),color='blue', linetype='dashed',lwd= 1)+
  geom_segment(aes(x=400,xend=400,y=-3,yend=3),color='blue', linetype='dashed',lwd= 1)+ labs(title='b)Serie de tiempo con cambio en varianza')


x=1:700
y=c(.3+0.005*x[1:100],-1.22+0.02*x[101:150],2.082-.002*x[151:300],2.987-.005*x[301:500],-.2645+.0015*x[501:700])
y=y+rnorm(700,0,.15)
datos <- data.frame(x,y)
ggplot(datos, aes(x= x,y=y)) + geom_line() + 
  geom_segment(aes(x=1,xend=100,y=.3,yend=.8), color = 'deeppink', linetype='dashed', lwd=2)+
  geom_segment(aes(x=101,xend=150,y=.8,yend=1.78), color = 'blue', linetype='dashed', lwd=2)+
  geom_segment(aes(x=151,xend=300,y=1.78,yend=1.482), color = 'deeppink', linetype='dashed', lwd=2)+
  geom_segment(aes(x=301,xend=500,y=1.482,yend=.487), color = 'blue', linetype='dashed', lwd=2)+
  geom_segment(aes(x=501,xend=700,y=.487,yend=.8035), color = 'deeppink', linetype='dashed', lwd=2)+
  labs(title="c)Serie de tiempo con cambio en tendencia")



######
###online offline
#####
set.seed(3)

x=1:75
y=c(rnorm(60,0,.25),rnorm(15,.5,.4))
plot(x,y,type="l")
# online example
library(cpm)
cpm=detectChangePoint(y,cpmType="Student")
cpm$detectionTime
datos <- data.frame(x,y)
datos1 <- datos %>% filter(x<=cpm$detectionTime)
datos2 <- datos %>% filter(x>cpm$detectionTime)

ggplot(datos1, aes(x=x,y=y)) +geom_line() + geom_line(data=datos2,aes(x=x,y=y),lty=2) +
  geom_segment(aes(x=cpm$detectionTime,xend=cpm$detectionTime,y=-.7,yend=1),color="red")+
  geom_segment(aes(x=60,xend=60,y=-.7,yend=1),color="blue")+labs(title="Detección de punto de cambio online")


ggplot(datos, aes(x=x,y=y)) +geom_line()  +
  geom_segment(aes(x=60,xend=60,y=-.7,yend=1),color="blue")+labs(title="Detección de punto de cambio offline")

ggplot(data1, aes(x = year, y = value, color = group)) +
  geom_point() + 
  geom_line() + 
  geom_point(data=data2, aes(x = year, y = value, color = group)) + 
  geom_line(data=data2, aes(x = year, y = value, color = group), lty=2) + 
  theme_bw()
plot(x,y,type='n',xlab='',ylab='')


data1 <- datos
lines(x[1:cpm$detectionTime],y[1:cpm$detectionTime])
lines(x[(cpm$detectionTime+1):110],y[(cpm$detectionTime+1):110],lty=5,col='grey')
abline(v=cpm$changePoint)
abline(v=cpm$detectionTime,col='red')
#offline example
plot(x,y,type='l',xlab='',ylab='')
cpt=cpt.mean(y)
abline(v=cpts(cpt))


#parametrico
set.seed(4)
x=1:700
y=c(rnorm(250,1,sd=0.3),rnorm(450,.7,sd=0.3))
datos <- data.frame(x,y)

ggplot(datos, aes(x=x,y=y))+ geom_line() + 
  geom_segment(aes(x=1,xend=250,y=1,yend=1),colour='red',lwd=1.5,linetype="dashed")+
  geom_segment(aes(x=251,xend=700,y=.7,yend=.7),colour='red',lwd=1.5,linetype="dashed")+labs(title="Serie de tiempo con un cambio en media")

n=length(y)
sumy=c(0,cumsum(y))
sumy2=c(0,cumsum(y^2))
taustar=1:n
tmp=sumy2[taustar+1]-sumy[taustar+1]^2/taustar + (sumy2[n+1]-sumy2[taustar+1]) - ((sumy[n+1]-sumy[taustar+1])^2)/(n-taustar)
ts.plot(tmp,main=which.min(tmp))
abline(v=which.min(tmp),col='red')

cp <-which.min(tmp)
datos <- data.frame(x,y,tmp)
ggplot(data=datos,aes(x=x,y=tmp)) + geom_line() + geom_segment(aes(x=cp,xend=cp, y=57,yend=75),color="blue",linetype="dashed") +
  labs(y="C(t)",x="t",title="Costo de la función de maxima verosimilitud negativa")+scale_x_continuous(breaks = scales::pretty_breaks(n = 15))

library(EnvCpt)
x=arima.sim(model=list(ar=c(0.7,0.2)),n=500)+0.01*(1:500)
out=envcpt(x, penalty='Manual',pen.value=c(5,100)) # runs a subset of models (those with AR components)
           
plot(out)