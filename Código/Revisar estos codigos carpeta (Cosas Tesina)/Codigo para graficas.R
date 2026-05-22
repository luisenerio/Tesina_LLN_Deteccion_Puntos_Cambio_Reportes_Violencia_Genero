#Gráficas



ruta <- "C:/Users/User/Desktop/cosas de la tesina/todo/Tesina"
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
  autoplot( colour = 'firebrick')+labs(y="# de Reportes por semana", x="Fecha",title = "Serie de tiempo de los reportes por violencia de Genero al 911(Semanal)")

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
                              method='PELT',penalty="CROPS",pen.value = c(5,500),minseglen = 12)
cpts.full(llamadas_lag_crops.pelt)
pen.value.full(llamadas_lag_crops.pelt)
plot(llamadas_lag_crops.pelt,ncpts=6)



llamadas_lag_6=cpt.meanvar(llamadas_lag,test.stat = 'Normal', method='PELT', penalty = 'Manual',pen.value=7.7,minseglen = 12,)
medias_6 <- param.est(llamadas_lag_6)$mean
varianzas_6 <-param.est(llamadas_lag_6)$variance
desv_6 <- sqrt(varianzas_6)
plot(llamadas_lag_6)


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
DataFrame_lag <- data.frame(llamadas=llamadas[2:length(llamadas)],
                            llamadas_lag,
                            semana=serie_tiempo_semana$semana[2:length(serie_tiempo_semana$semana)],
                            segmentos)
DataFrame_lag$semanaDate <- as.Date(DataFrame_lag$semana)

ggplot(data= DataFrame_lag, aes(x=semana,y=llamadas_lag,colour=segmentos))+geom_line()


ggplot(data= DataFrame_lag, aes(x=semanaDate,y=llamadas_lag))+geom_line(colour = 'firebrick')+scale_x_date(breaks="6 months",labels = scales::label_date("%b/%y"))
ggplot(data= DataFrame_lag, aes(x=semanaDate,y=llamadas_lag,colour=segmentos))+geom_line()+scale_x_date(breaks="6 months",labels = scales::label_date("%b/%y"))


ggplot(data= DataFrame_lag, aes(x=semanaDate,y=llamadas,colour=segmentos))+geom_line()+scale_x_date(breaks="6 months",labels = scales::label_date("%b/%y"))
ggplot(data= DataFrame_lag, aes(x=semana,y=llamadas,colour=segmentos))+geom_line()


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


#############################################
########################
#############################################




library(changepoint.np)
llamadas_lag_crops_np.pelt=cpt.np(llamadas_lag,test.stat='empirical_distribution',
                                    method='PELT',penalty="CROPS",pen.value = c(5,500),minseglen = 8)

cpts.full(llamadas_lag_crops_np.pelt)
plot(llamadas_lag_crops_np.pelt,ncpts=5)

pen.value.full(llamadas_lag_crops_np.pelt)

llamadas_lag_crops_np_5.pelt=cpt.np(llamadas_lag,test.stat='empirical_distribution',
                                  method='PELT',penalty="Manual",pen.value =8.041,minseglen = 8)


segnp <- c("segmento 1", "segmento2", "segmento3","segmento4","segmento5","segmento6")
segmentos_np <- rep(segnp, seg.len(llamadas_lag_crops_np_5.pelt))
DataFrame_lag_np <- data.frame(llamadas=llamadas[2:length(llamadas)],
                            llamadas_lag,
                            semana=serie_tiempo_semana$semana[2:length(serie_tiempo_semana$semana)],
                            segmentos_np)
DataFrame_lag_np$semanaDate <- as.Date(DataFrame_lag$semana)




ggplot(datos,aes(x=t,y=llamadas,colour=Segmento_normal_changepoint ))+geom_line(lwd=1.5)

ggplot(datos,aes(x=t,y=llamadas,colour=Segmento_np ))+geom_line(lwd=1.5)























##

segmentos <- SplitAt(llamadas_lag,pos=cpts(llamadas_lag_6)+1)
s1<-segmentos[[1]]
s2<-segmentos[[2]]
s3<-segmentos[[3]]
s4<-segmentos[[4]]
s5<-segmentos[[5]]
s6<-segmentos[[6]]
s7<-segmentos[[7]]







####Resampling mehtods

install.packages("xts")
install.packages("quantmod")

library(xts)
library(quantmod)

set.seed(123)
dates <- seq(as.Date("2023-01-01"), as.Date("2023-06-30"), by = "days")
values <- rnorm(length(dates), mean = 100, sd = 10)
ts_data <- xts(values, order.by = dates)

serie_tiempo_semana$semana

serie_tiempo_sem <- xts(serie_tiempo_semana$llamadas, order.by = serie_tiempo_semana$semana)





week_strings <- c('2016 W52', '2023 W03', '2020 W20')

# Function to convert week strings to date
convert_to_date <- function(week_str) {
  year <- as.integer(substr(week_str, 1, 4))
  week_num <- as.integer(substring(week_str, 7))
  
  # Calculate the first day of the week (Monday)
  first_day_of_week <- as.Date(paste(year, '-01-01', sep = ''))
  week_start <- first_day_of_week + (week_num - 1) * 7
  
  return(week_start)
}

# Convert the strings to dates
dates <- sapply(week_strings, convert_to_date)

# Print the result
print(dates)




