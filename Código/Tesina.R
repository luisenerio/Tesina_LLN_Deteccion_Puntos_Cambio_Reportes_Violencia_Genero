


ruta <-setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
ruta_completa <-paste("../Datos/Datos.csv",sep="")
library(fpp3)
library(tidyverse)
library(DataExplorer)
library(ggplot2)

datos <- read_csv(ruta_completa, col_names= TRUE, col_types = cols(fecha=col_date("%d/%m/%Y")))

## Llamadas Totales
datos %>% summarise(llamadas_totales= n())


# Numero de llamadas por colonia
datos %>% group_by(colonia) %>% summarise(Llamadas_colonia = n()) %>% arrange(desc(Llamadas_colonia))

#Numero distinto de colonias
n_distinct(datos$colonia)


#Numero de llamadas por tipo de llamada



datos %>% group_by(descripcion_tipo) %>% summarise(Llamadas_tipo=n()) %>% arrange(desc(descripcion_tipo))
tipo_llamada <-datos %>% group_by(descripcion_tipo) %>% summarise(Tipo_llamada=n()) %>% arrange(desc(Tipo_llamada))


  ggplot(data=tipo_llamada,aes(y=descripcion_tipo,x=Tipo_llamada,fill=descripcion_tipo))+
  geom_bar(stat="identity",color="black",position=position_dodge())+theme_minimal()+scale_fill_brewer(palette="Dark2")+
    geom_text(aes(label=Tipo_llamada), hjust=-.1, color="black",
              position = position_dodge(0.9), size=3.5)+
    labs(x="# de llamadas",y="Tipo de reporte")


  
  
  
  datos %>% group_category("descripcion_tipo",threshold=.01,update=T) %>% 
  group_by(descripcion_tipo) %>% 
  summarise(Tipo_llamada=n()) %>%
  arrange(desc(Tipo_llamada)) %>% ggplot(aes(y=descripcion_tipo,x=Tipo_llamada,fill=descripcion_tipo))+
  geom_bar(stat="identity",color="black",position=position_dodge())+theme_minimal()+scale_fill_brewer(palette="Dark2")+
  geom_text(aes(label=Tipo_llamada), hjust=-.1, color="black",
            position = position_dodge(0.9), size=3.5)+
  labs(x="# de llamadas",y="Tipo de reporte",title="Tipo de llamada")
  
n_distinct(datos$descripcion_tipo)


#N?mero de llamadas por descripci?n del cierre
datos %>% group_by(descripcion_cierre) %>% summarise(Tipo_llamada=n()) %>% arrange(desc(Tipo_llamada))

datos %>% group_category("descripcion_cierre", threshold = .00015,update=T) %>% group_by(descripcion_cierre) %>% summarise(num_llamadas = n()) %>% arrange(desc(num_llamadas)) %>% 
  ggplot(aes(y=descripcion_cierre,x=num_llamadas, fill=descripcion_cierre))+
  geom_bar(stat="identity", color ="black", position = position_dodge()) + theme_minimal() + scale_fill_brewer(palette="Dark2")+
  geom_text(aes(label = num_llamadas), hjust=.1, color ="black", 
            position = position_dodge(.9), size=3.5)+
  labs(x="# de llamadas", y ="Cierre del reporte", title ="Cierre de la llamada")

datos %>% select(fecha) %>% group_by(fecha) %>% summarise(llamada=n()) %>% as_tsibble() %>% autoplot()+labs(y="# de reportes", x="D?a",title="Serie de tiempo diaria")





datos %>% mutate(semana=yearweek(fecha)) %>% 
  select(semana) %>% 
  group_by(semana) %>% 
  summarise(llamadas=n()) %>% 
  as_tsibble() %>% 
  autoplot( colour = 'firebrick')+labs(y="# de Reportes", x="Semana",title = "Serie de tiempo de los reportes por violencia de Genero al 911(Semanal)")


datos %>% mutate(mes=yearmonth(fecha)) %>% 
  select(mes) %>% group_by(mes) %>% 
  summarise(llamadas=n()) %>% 
  as_tsibble() %>%
  autoplot() +
  labs(y="# de Reportes", x="Mes",title = "Serie de tiempo de los reportes por violencia de Genero al 911(Mensual)")


datos %>% mutate(mes=yearmonth(Fecha)) %>% select(mes) %>% group_by(mes) %>% summarise(llamadas=n())






datos %>% select(fecha) %>% group_by(fecha) %>% summarise(llamadas = n()) %>% as_tsibble() %>% autoplot()+labs(y="# de reportes", x="D?a",title="Serie de tiempo diaria")


datos %>% mutate(semana=yearweek(fecha)) %>% 
  select(semana) %>% 
  group_by(semana) %>% 
  summarise(llamadas=n()) %>% 
  as_tsibble() %>% 
  autoplot( colour = 'firebrick')+labs(y="# de Reportes", x="Semana",title = "Serie de tiempo de los reportes por violencia de Genero al 911(Semanal)")


datos %>% mutate(mes=yearmonth(fecha)) %>% 
  select(mes) %>% group_by(mes) %>% 
  summarise(llamadas=n()) %>% 
  as_tsibble() %>%
  autoplot() +
  labs(y="# de Reportes", x="Mes",title = "Serie de tiempo de los reportes por violencia de Genero al 911(Mensual)")


serie_tiempo_dias <- datos %>% select(fecha) %>% group_by(fecha) %>% summarise(llamadas=n()) %>% as_tsibble()


serie_tiempo_semana <- datos %>% mutate(semana=yearweek(fecha)) %>% 
  select(semana) %>% 
  group_by(semana) %>% 
  summarise(llamadas=n()) %>% 
  as_tsibble() 

serie_tiempo_semana_2017<- serie_tiempo_semana %>% mutate(year=year(semana)) %>% filter(year<=2017) %>% select(semana,llamadas)

serie_tiempo_semana_2017 %>% gg_tsdisplay(llamadas) + labs(title="Serie de tiempo # de llamadas por semana año 2017")

#series de tiempo con lag
serie_tiempo_semana_2017 %>% gg_tsdisplay(difference(llamadas)) + labs(title="Serie de tiempo # de llamadas por semana a?o 2017")

shapiro.test(difference(serie_tiempo_semana_2017$llamadas))


hist((difference(serie_tiempo_semana_2017$llamadas)))




serie_tiempo_semana %>% gg_tsdisplay(llamadas) %>% labs(title="Serie de tiempo # de llamadas por semana 2017-2022")
serie_tiempo_semana %>% gg_tsdisplay(difference(llamadas),plot_type = "partial") %>% labs(title="Serie de tiempo # de llamadas por semana(lag 1)")

serie_tiempo_dias %>% gg_tsdisplay(llamadas) %>% labs(title="Serie de tiempo # de llamadas por d?a 2017-2022")

shapiro.test(difference(serie_tiempo_semana$llamadas))
hist((difference(serie_tiempo_semana$llamadas)))



## changepoint
library(changepoint)
llamadas <-serie_tiempo_semana$llamadas
llamadas_diarias <- serie_tiempo_dias$llamadas

llamadas_lag <- difference(llamadas)
llamadas_lag <- llamadas_lag[!is.na(llamadas_lag)]

llamadas.pelt=cpt.meanvar(llamadas,test.stat='Normal',
                     method='PELT',Q=10,penalty="SIC")

cpts(llamadas.pelt)
plot(llamadas.pelt,cpt.width=3,cpt.col='blue')



llamadas_lag.pelt=cpt.meanvar(llamadas_lag,test.stat='Normal',
                          method='PELT',Q=5,penalty="SIC")
cpts(llamadas_lag.pelt)
plot(llamadas_lag.pelt,cpt.width=3,cpt.col='blue')




#####
llamdas_lag.pelt.crops <-cpt.meanvar(llamadas_lag, method="PELT", penalty="CROPS",
                                     pen.value=c(5,500),minseglen=12)


cpts.full(llamdas_lag.pelt.crops)
plot(llamdas_lag.pelt.crops,ncpts=1,cpt.width=3,cpt.col='blue')
plot(llamdas_lag.pelt.crops,ncpts=2,cpt.width=3,cpt.col='blue')
plot(llamdas_lag.pelt.crops,ncpts=4,cpt.width=3,cpt.col='blue')
plot(llamdas_lag.pelt.crops,diagnostic=TRUE)




########


llamdas_lag.pelt.crops_var <-cpt.var(llamadas_lag, method="PELT", penalty="CROPS",
                                     pen.value=c(5,500),minseglen=12)
cpts.full(llamdas_lag.pelt.crops_var)
plot(llamdas_lag.pelt.crops_var,ncpts=1,cpt.width=3,cpt.col='blue')
plot(llamdas_lag.pelt.crops_var,ncpts=6,cpt.width=3,cpt.col='blue')
plot(llamdas_lag.pelt.crops_var,diagnostic=TRUE)



#####Media


llamdas_lag.pelt.crops_media <-cpt.mean(llamadas_lag, method="PELT",test.stat='Normal', penalty="CROPS",
                                     pen.value=c(5,500),minseglen=16)

cpts.full(llamdas_lag.pelt.crops_media)
plot(llamdas_lag.pelt.crops_media,ncpts=15,cpt.width=3,cpt.col='blue')
plot(llamdas_lag.pelt.crops_media,ncpts=13,cpt.width=3,cpt.col='blue')






#### env
library(EnvCpt)
resultado <- EnvCpt::envcpt(llamadas)
plot(resultado)
plot(resultado, type='bic')

resultado_diario<-EnvCpt::envcpt(llamadas_diarias)
plot(resultado_diario)

plot(resultado_diario, type='bic')



###np
library(changepoint.np)
resultado2 =cpt.np(llamadas,method='PELT',minseglen=2,nquantiles=4*log(length(llamadas)))


###np

resultado3 =cpt.np(llamadas_lag,method='PELT',minseglen=2,nquantiles=4*log(length(llamadas)))
plot(resultado3)



###############
library(prophet)
serie <- data.frame(ds=serie_tiempo_dias$fecha,y=serie_tiempo_dias$llamadas)
m<- prophet(serie)
future <- make_future_dataframe(m, periods = 365)
tail(future)
forecast <- predict(m, future)
tail(forecast[c('ds', 'yhat', 'yhat_lower', 'yhat_upper')])
plot(m, forecast)
plot(m, forecast)
prophet_plot_components(m, forecast)
plot(m, forecast) + add_changepoints_to_plot(m)


##############

serie_tiempo_semana %>% gg_tsdisplay(llamadas) %>% labs(title="Serie de tiempo # de llamadas por semana 2017-2022")
serie_tiempo_semana %>% gg_tsdisplay(difference(llamadas),plot_type = "partial") %>% labs(title="Serie de tiempo # de llamadas por semana(lag 1)")
serie_tiempo_dias %>% gg_tsdisplay(llamadas) %>% labs(title="Serie de tiempo # de llamadas por d?a 2017-2022")




####
llamadas <-serie_tiempo_semana$llamadas
llamadas_diarias <- serie_tiempo_dias$llamadas
llamadas_lag <- difference(llamadas)
llamadas_lag <- llamadas_lag[!is.na(llamadas_lag)]

######################llamadas semanales sin primeras diferencias
llamadas.pelt=cpt.meanvar(llamadas,test.stat='Normal',
                          method='PELT',minseglen=12,penalty="MBIC")
cpts(llamadas.pelt)
plot(llamadas.pelt,cpt.width=3,cpt.col='blue')


########################Llamadas semanales primeras diferencias
llamadas_lag.pelt=cpt.var(llamadas_lag,test.stat='Normal',
                              method='PELT',minseglen=3,penalty="MBIC")
cpts(llamadas_lag.pelt)
plot(llamadas_lag.pelt,cpt.width=3,cpt.col='blue')


####no parametrico


#######
Semanal_NP =cpt.np(llamadas,method='PELT',minseglen=2,nquantiles=4*log(length(llamadas)))
plot(Semanal_NP)

Lag_NP =cpt.np(llamadas_lag,method='PELT',minseglen=2,nquantiles=4*log(length(llamadas)))
plot(Lag_NP)


resultado_diario<-EnvCpt::envcpt(llamadas_diarias)
plot(resultado_diario)
plot(resultado_diario, type='bic')
plot(resultado_diario$trendar2cpt)
abline(v=cpts(resultado_diario$trendar2cpt),col='blue')







