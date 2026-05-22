#Gráficas


ruta <- "F:/todo/Tesina"
ruta_completa <-paste(ruta,"/Datos/Datos.csv",sep="")
library(fpp3)
library(tidyverse)
library(DataExplorer)
library(ggplot2)
library(DescTools)

datos <- readr::read_delim(ruta_completa, 
                           delim=",",
                           col_types = cols(fecha=col_date("%d/%m/%Y")))



###Gráficas series de tiempo en semanas y días
datos %>% mutate(semana=yearweek(fecha)) %>% 
  select(semana) %>% 
  group_by(semana) %>% 
  summarise(llamadas=n()) %>% 
  as_tsibble() %>% 
  autoplot( colour = 'firebrick')+labs(y="# de Reportes por semana", x="Fecha",title = "Serie de tiempo de los reportes por violencia de Genero al 911(Semanal)")+
  +scale_x_date(breaks="6 months",labels = scales::label_date("%b/%y"))


datos %>% 
  select(fecha) %>% 
  group_by(fecha) %>%
  summarise(llamadas=n()) %>%
  as_tsibble() %>%
  autoplot( colour = 'firebrick')+labs(y="# de Reportes por semana", x="Fecha",title = "Serie de tiempo de los reportes por violencia de Genero al 911(Semanal)")



###
serie_tiempo_dias <- datos %>% select(fecha) %>% group_by(fecha) %>% summarise(llamadas=n()) %>% as_tsibble()

serie_tiempo_semana <- datos %>% mutate(semana=yearweek(fecha)) %>% 
  select(semana) %>% 
  group_by(semana) %>% 
  summarise(llamadas=n()) %>% 
  as_tsibble() 


serie_tiempo_semana %>% gg_tsdisplay(llamadas) %>% labs(title="Serie de tiempo # de llamadas por semana 2017-2022")
serie_tiempo_semana %>% gg_tsdisplay(difference(llamadas),plot_type = "partial") %>% labs(title="Serie de tiempo # de llamadas por semana(lag 1)")
serie_tiempo_dias %>% gg_tsdisplay(llamadas) %>% labs(title="Serie de tiempo # de llamadas por día 2017-2022")



Denuncias <- read_csv(paste(ruta,"/Datos/Denuncias.csv",sep=""))
Denuncias %>% ggplot(aes(x=Year,y=Denuncias))+geom_bar(stat='identity',fill='firebrick')+  geom_text(aes(label=Denuncias), vjust=1.6, color="white", size=3.5)+
  theme_minimal()+labs(x="Año",title="DENUNCIAS PRESENTADAS ANTE AGENCIAS DEL MINISTERIO PÚBLICO POR DELITOS DE GÉNERO")+scale_x_continuous(breaks = scales::pretty_breaks(n = 10))
  


#############################################
########################
#############################################

library(changepoint)
llamadas <-serie_tiempo_semana$llamadas
fechas <- serie_tiempo_semana
write_csv(as.data.frame(serie_tiempo_semana),path="llamadas_semanales.csv")
llamadas_diarias <- serie_tiempo_dias$llamadas
llamadas_lag <- difference(llamadas)
llamadas_lag <- llamadas_lag[!is.na(llamadas_lag)]


datos <- read_csv("llamadas_semanales.csv")


###detección de punto de cambio sobre la serie de tiempo de las llamadas diarias, esto no es correcto ya que hay autocorrelación en los datos
llamadas.pelt=cpt.meanvar(llamadas,test.stat='Normal',
                          method='PELT',Q=10,penalty="MBIC")
cpts(llamadas.pelt)
plot(llamadas.pelt,cpt.width=3,cpt.col='blue')




llamadas_lag.pelt=cpt.meanvar(llamadas_lag,test.stat='Normal',
                              method='PELT',Q=5,penalty="MBIC")
cpts(llamadas_lag.pelt)
plot(llamadas_lag.pelt,cpt.width=3,cpt.col='blue')





llamadas_lag_crops.pelt=cpt.meanvar(llamadas_lag,test.stat='Normal',
                              method='PELT',penalty="CROPS",pen.value = c(5,500),minseglen = 20)
cpts.full(llamadas_lag_crops.pelt)
pen.value.full(llamadas_lag_crops.pelt)
plot(llamadas_lag_crops.pelt,ncpts=6)
plot(llamadas_lag_crops.pelt,ncpts=5)


llamadas_lag_6=cpt.meanvar(llamadas_lag,test.stat = 'Normal', method='PELT', penalty = 'Manual',pen.value=7.7,minseglen = 12,)
medias_6 <- param.est(llamadas_lag_6)$mean
varianzas_6 <-param.est(llamadas_lag_6)$variance
desv_6 <- sqrt(varianzas_6)
plot(llamadas_lag_6)


llamadas_lag_4=cpt.meanvar(llamadas_lag,test.stat = 'Normal', method='PELT', penalty = 'Manual',pen.value=4,minseglen = 20,)

llamadas_lag_6_resid <- (llamadas_lag-rep(medias_6,seg.len(llamadas_lag_6)))/rep(desv_6,seg.len(llamadas_lag_6))
#residuales
shapiro.test(llamadas_lag_6_resid)
#Ho distribución normal
#Ha distribución no normal
hist(llamadas_lag_6_resid,main='Histograma residuales',xlab='')
qqnorm(llamadas_lag_6_resid)
qqline(llamadas_lag_6_resid)
acf(llamadas_lag_6_resid)




seg <- c("segmento1", "segmento2", "segmento3","segmento4","segmento5","segmento6","segmento7")
segmentos <- rep(seg, seg.len(llamadas_lag_6))
seg2 <-c("segmento1", "segmento2", "segmento3","segmento4","segmento5","segmento6","segmento7")
segmentos2 <- rep(seg2, seg.len(llamadas_lag_4))

DataFrame_lag <- data.frame(llamadas=llamadas[2:length(llamadas)],
                            llamadas_lag,
                            semana=serie_tiempo_semana$semana[2:length(serie_tiempo_semana$semana)],
                            segmentos,segmentos2)
DataFrame_lag$semanaDate <- as.Date(DataFrame_lag$semana)

ggplot(data= DataFrame_lag, aes(x=semana,y=llamadas_lag,colour=segmentos))+geom_line()


ggplot(data= DataFrame_lag, aes(x=semanaDate,y=llamadas_lag))+geom_line(colour = 'firebrick')+scale_x_date(breaks="6 months",labels = scales::label_date("%b %y"))
ggplot(data= DataFrame_lag, aes(x=semanaDate,y=llamadas_lag,colour=segmentos))+geom_line()+  scale_color_manual(values = my_pal)+scale_x_date(breaks="6 months",labels = scales::label_date("%b %y"))


ggplot(data= DataFrame_lag, aes(x=semanaDate,y=llamadas,colour=segmentos))+geom_line()+  scale_color_manual(values = my_pal)+scale_x_date(breaks="6 months",labels = scales::label_date("%b %y"))
ggplot(data= DataFrame_lag, aes(x=semana,y=llamadas,colour=segmentos))+geom_line()+  scale_color_manual(values = my_pal)




ggplot(data= DataFrame_lag, aes(x=semanaDate,y=llamadas_lag))+geom_line(colour = 'firebrick')+scale_x_date(breaks="6 months",labels = scales::label_date("%b %y"))
ggplot(data= DataFrame_lag, aes(x=semanaDate,y=llamadas_lag,colour=segmentos2))+geom_line()+
  scale_color_manual(values = my_pal)+scale_x_date(breaks="6 months",labels = scales::label_date("%b %y")) + theme(legend.position = "none")+
  labs(x="Fecha",y="",title="Serie de tiempo de primeras diferencias")

ggplot(data= DataFrame_lag, aes(x=semanaDate,y=llamadas,colour=segmentos2))+geom_line()+
  scale_color_manual(values = my_pal)+scale_x_date(breaks="6 months",labels = scales::label_date("%b %y"))+
   theme(legend.position = "none")+
  labs(x="Fecha",y="",title="Serie de tiempo de reportes")
  
ggplot(data= DataFrame_lag, aes(x=semana,y=llamadas,colour=segmentos2))+geom_line()+  scale_color_manual(values = my_pal)



###1 y 2
S1_2 <- DataFrame_lag %>% filter( segmentos=='segmento1' |segmentos=='segmento2' )
S2_3 <- DataFrame_lag %>% filter( segmentos=='segmento2' |segmentos=='segmento3' )
S3_4 <- DataFrame_lag %>% filter( segmentos=='segmento3' |segmentos=='segmento4' )
S4_5 <- DataFrame_lag %>% filter( segmentos=='segmento4' |segmentos=='segmento5' )
S5_6 <- DataFrame_lag %>% filter( segmentos=='segmento5' |segmentos=='segmento6' )
S6_7 <- DataFrame_lag %>% filter( segmentos=='segmento6' |segmentos=='segmento7' )


library(stats)
var.test(llamadas_lag ~ segmentos, data = S1_2)
var.test(llamadas_lag ~ segmentos, data = S2_3)
var.test(llamadas_lag ~ segmentos, data = S3_4)
var.test(llamadas_lag ~ segmentos, data = S4_5)
var.test(llamadas_lag ~ segmentos, data = S5_6)
var.test(llamadas_lag ~ segmentos, data = S6_7)

fligner.test(llamadas_lag ~ segmentos, data = S1_2)
fligner.test(llamadas_lag ~ segmentos, data = S2_3)
fligner.test(llamadas_lag ~ segmentos, data = S3_4)
fligner.test(llamadas_lag ~ segmentos, data = S4_5)
fligner.test(llamadas_lag ~ segmentos, data = S5_6)
fligner.test(llamadas_lag ~ segmentos, data = S6_7)




ggplot(data = DataFrame_lag, mapping = aes(x = segmentos, y = llamadas_lag, colour = segmentos)) +
  geom_boxplot() +
  theme_bw() +
  theme(legend.position = "none")

S1<-DataFrame_lag %>% filter(segmentos=='segmento1')
S1<-S1$llamadas_lag
S2<-DataFrame_lag %>% filter(segmentos=='segmento2')
S2<- S2$llamadas_lag
S3<-DataFrame_lag %>% filter(segmentos=='segmento3')
S3<- S3$llamadas_lag
S4<-DataFrame_lag %>% filter(segmentos=='segmento4')
S4<- S4$llamadas_lag
S5<-DataFrame_lag %>% filter(segmentos=='segmento5')
S5<- S5$llamadas_lag
S6<-DataFrame_lag %>% filter(segmentos=='segmento6')
S6<- S6$llamadas_lag
S7<-DataFrame_lag %>% filter(segmentos=='segmento7')
S7<- S7$llamadas_lag
ks.test(S1,S2)
ks.test(S2,S3)
ks.test(S3,S4)
ks.test(S4,S5)
ks.test(S5,S6)
ks.test(S6,S7)


install.packages("twosamples")
library(twosamples)


out=ad_test(S1,S2)
out
summary(out)
plot(out)

out=ad_test(S2,S3)
out
summary(out)
plot(out)


out=ad_test(S3,S4)
out
summary(out)
plot(out)

out=ad_test(S4,S5)
out
summary(out)
plot(out)

out=ad_test(S5,S6)
out
summary(out)
plot(out)

out=ad_test(S6,S7)
out
summary(out)
plot(out)


set.seed(314159)
vec1 = rnorm(20)
vec2 = rnorm(20,0.5)
out = ad_test(vec1,vec2)
out
summary(out)
plot(out)
#############################################
########################
#############################################




library(changepoint.np)
llamadas_lag_crops_np.pelt=cpt.np(llamadas_lag,test.stat='empirical_distribution',
                                    method='PELT',penalty="CROPS",pen.value = c(5,500),minseglen = 20)

cpts.full(llamadas_lag_crops_np.pelt)
plot(llamadas_lag_crops_np.pelt,ncpts=5)

pen.value.full(llamadas_lag_crops_np.pelt)

llamadas_lag_crops_np_5.pelt=cpt.np(llamadas_lag,test.stat='empirical_distribution',
                                  method='PELT',penalty="Manual",pen.value =5.1,minseglen = 20)


segnp <- c("segmento 1", "segmento2", "segmento3","segmento4","segmento5","segmento6","segmento7","segmento8","segmento9")
segmentos_np <- rep(segnp, seg.len(llamadas_lag_crops_np_5.pelt))
DataFrame_lag_np <- data.frame(llamadas=llamadas[2:length(llamadas)],
                            llamadas_lag,
                            semana=serie_tiempo_semana$semana[2:length(serie_tiempo_semana$semana)],
                            segmentos_np)
DataFrame_lag_np$semanaDate <- as.Date(DataFrame_lag$semana)




ggplot(datos,aes(x=t,y=llamadas,colour=Segmento_normal_changepoint ))+geom_line(lwd=1.5)

ggplot(datos,aes(x=t,y=llamadas,colour=Segmento_np ))+geom_line(lwd=1.5)




my_pal <- c("steelblue", "firebrick", "steelblue", "firebrick","steelblue", "firebrick","steelblue", "firebrick","steelblue", "firebrick"                         # R color names, 
          )   # RGB values 

ggplot(data= DataFrame_lag_np, aes(x=semanaDate,y=llamadas_lag))+geom_line(colour = 'firebrick')+scale_x_date(breaks="6 months",labels = scales::label_date("%b %y"))
ggplot(data= DataFrame_lag_np, aes(x=semanaDate,y=llamadas_lag,colour=segmentos_np))+
  geom_line()+  scale_color_manual(values = my_pal) +scale_x_date(breaks="6 months",labels = scales::label_date("%b %y"))+
  theme(legend.position = "none")+
  labs(x="Fecha",y="",title="Serie de tiempo primeras diferencias")



ggplot(data= DataFrame_lag_np, aes(x=semanaDate,y=llamadas,colour=segmentos_np))+geom_line()+
  scale_color_manual(values = my_pal)+scale_x_date(breaks="6 months",labels = scales::label_date("%b/%y"))+
  theme(legend.position = "none")+
  labs(x="Fecha",y="",title="Serie de tiempo de reportes")


ggplot(data= DataFrame_lag_np, aes(x=semanaDate,y=llamadas,colour=segmentos_np))+geom_line()+
  scale_color_manual(values = my_pal)+scale_x_date(breaks="2 months",labels = scales::label_date("%b/%y"))+
  theme(legend.position = "none")+
  labs(x="Fecha",y="",title="Serie de tiempo de reportes")

ggplot(data= DataFrame_lag_np, aes(x=semana,y=llamadas,colour=segmentos_np))+  scale_color_manual(values = my_pal)+geom_line()


















##

segmentos <- SplitAt(llamadas_lag,pos=cpts(llamadas_lag_6)+1)
s1<-segmentos[[1]]
s2<-segmentos[[2]]
s3<-segmentos[[3]]
s4<-segmentos[[4]]
s5<-segmentos[[5]]
s6<-segmentos[[6]]
s7<-segmentos[[7]]

