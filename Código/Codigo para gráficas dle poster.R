

ruta <- "C:\Users\User\Desktop\USB\todo\Tesina\Codigo"
ruta_completa <-paste(ruta,"/Datos/Datos.csv",sep="")

library(fpp3)
library(tidyverse)
library(DataExplorer)
library(ggplot2)
library(DescTools)
library(ggthemes)
library(scales)



Denuncias <- read_csv(paste(ruta,"/Datos/Denuncias.csv",sep=""))
D <- Denuncias %>% ggplot(aes(x=Year,y=Denuncias))+geom_bar(stat='identity',fill='#108F67')+  
 # geom_text(aes(label=scales::comma(Denuncias)), vjust=1.6, color="white", size=3.5)+
  theme_minimal()+labs(x="",title="",y="")+
  scale_x_continuous(breaks = scales::pretty_breaks(n = 10))+
  scale_y_continuous(label=comma,breaks = scales::pretty_breaks(n = 7))+theme_hc()+
  theme(axis.text.x = element_text(angle = 50, vjust = 1, hjust = 1, size = 14),
        axis.text.y = element_text( size = 14),
        plot.title = element_text(face = "bold",margin = margin(10, 0, 10, 0),size = 20) ) 

ggsave("F:/todo/Tesina/Imagenes/denuncias.png",plot=D, width = 26.5, height = 12.50, units = "cm")




#####
datos <- readr::read_delim(ruta_completa, 
                           delim=",",
                           col_types = cols(fecha=col_date("%d/%m/%Y")))


serie_tiempo_semana <- datos %>% mutate(semana=yearweek(fecha)) %>% 
  select(semana) %>% 
  group_by(semana) %>% 
  summarise(llamadas=n()) %>% 
  as_tsibble() 



library(changepoint)
llamadas <-serie_tiempo_semana$llamadas
fechas <- serie_tiempo_semana
write_csv(as.data.frame(serie_tiempo_semana),path="llamadas_semanales.csv")
llamadas_diarias <- serie_tiempo_dias$llamadas
llamadas_lag <- difference(llamadas)
llamadas_lag <- llamadas_lag[!is.na(llamadas_lag)]

################Parametrico
###Se calculan los punto
llamadas_lag_crops.pelt=cpt.meanvar(llamadas_lag,test.stat='Normal',
                                    method='PELT',penalty="CROPS",pen.value = c(5,500),minseglen = 20)
cpts.full(llamadas_lag_crops.pelt)
pen.value.full(llamadas_lag_crops.pelt)

###Llamadas
llamadas_lag_Parametrico_6CP=cpt.meanvar(llamadas_lag,test.stat = 'Normal', method='PELT', penalty = 'Manual',pen.value=4,minseglen = 20,)
seg <-c("segmento1", "segmento2", "segmento3","segmento4","segmento5","segmento6","segmento7")
segmentos_p <- rep(seg2, seg.len(llamadas_lag_Parametrico_6CP))




###No paraMetrico
library(changepoint.np)
llamadas_lag_crops_np.pelt=cpt.np(llamadas_lag,test.stat='empirical_distribution',
                                  method='PELT',penalty="CROPS",pen.value = c(5,500),minseglen = 20)

cpts.full(llamadas_lag_crops_np.pelt)

llamadas_lag_NP_8CP.pelt=cpt.np(llamadas_lag,test.stat='empirical_distribution',
                                    method='PELT',penalty="Manual",pen.value =5.1,minseglen = 20)


segnp <- c("segmento 1", "segmento2", "segmento3","segmento4","segmento5","segmento6","segmento7","segmento8","segmento9")
segmentos_np <- rep(segnp, seg.len(llamadas_lag_NP_8CP.pelt))



DataFrame_lag <- data.frame(llamadas=llamadas[2:length(llamadas)],
                            llamadas_lag,
                            semana=serie_tiempo_semana$semana[2:length(serie_tiempo_semana$semana)],
                            segmentos,segmentos_np)
DataFrame_lag$semanaDate <- as.Date(DataFrame_lag$semana)




my_pal <- c("#108F67", "firebrick", "#108F67", "firebrick","#108F67", "firebrick","#108F67", "firebrick","#108F67", "firebrick"                         # R color names, 
)   # RGB values 


Primeras_diferencias_unicolor <-ggplot(data= DataFrame_lag, aes(x=semanaDate,y=llamadas_lag))+geom_line(colour = '#108F67')+
  theme_hc()+
  labs(x="",title="",y="")+
  scale_x_date(breaks="6 months",labels = scales::label_date("%b %y"))+
  scale_y_continuous(label=comma,breaks = scales::pretty_breaks(n = 7))+
  theme(axis.text.x = element_text(angle = 50, vjust = 1, hjust = 1, size = 14),
        axis.text.y = element_text( size = 14),
        plot.title = element_text(face = "bold",margin = margin(10, 0, 10, 0),size = 20) ) 

ggsave("F:/todo/Tesina/Imagenes/primeras_dif_uni.png",plot=Primeras_diferencias_unicolor, width = 26.5, height = 12.50, units = "cm")


Semanales_unicolor <- ggplot(data= DataFrame_lag, aes(x=semanaDate,y=llamadas))+geom_line(colour = '#108F67')+
  theme_minimal()+
  theme_hc()+
  labs(x="",title="",y="")+  
  scale_x_date(breaks="6 months",labels = scales::label_date("%b %y"))+
  scale_y_continuous(label=comma,breaks = scales::pretty_breaks(n = 7))+
  theme(axis.text.x = element_text(angle = 50, vjust = 1, hjust = 1, size = 14),
        axis.text.y = element_text( size = 14),
        plot.title = element_text(face = "bold",margin = margin(10, 0, 10, 0),size = 20) )

ggsave("F:/todo/Tesina/Imagenes/Semanales_unicolor.png",plot=Semanales_unicolor, width = 26.5, height = 12.50, units = "cm")



#Parametrico
p_pd <- ggplot(data= DataFrame_lag, aes(x=semanaDate,y=llamadas_lag,colour=segmentos))+
  geom_line()+  
  scale_color_manual(values = my_pal)+
  scale_x_date(breaks="6 months",labels = scales::label_date("%b %y"))+
  theme_minimal()+
  theme_hc()+
  labs(x="",title="",y="")+  
  scale_x_date(breaks="6 months",labels = scales::label_date("%b %y"))+
  scale_y_continuous(label=comma,breaks = scales::pretty_breaks(n = 7))+
  theme(axis.text.x = element_text(angle = 50, vjust = 1, hjust = 1, size = 14),
        axis.text.y = element_text( size = 14),
        plot.title = element_text(face = "bold",margin = margin(10, 0, 10, 0),size = 20),
        legend.position = "none")

ggsave("F:/todo/Tesina/Imagenes/p_primeras diferencias.png",plot=p_pd, width = 26.5, height = 12.50, units = "cm")




p_s <- ggplot(data= DataFrame_lag, aes(x=semanaDate,y=llamadas,colour=segmentos))+
  geom_line()+
  scale_color_manual(values = my_pal)+scale_x_date(breaks="6 months",labels = scales::label_date("%b %y"))+
  scale_x_date(breaks="6 months",labels = scales::label_date("%b %y"))+
  theme_minimal()+
  theme_hc()+
  labs(x="",title="",y="")+  
  scale_x_date(breaks="6 months",labels = scales::label_date("%b %y"))+
  scale_y_continuous(label=comma,breaks = scales::pretty_breaks(n = 7))+
  theme(axis.text.x = element_text(angle = 50, vjust = 1, hjust = 1, size = 14),
        axis.text.y = element_text( size = 14),
        plot.title = element_text(face = "bold",margin = margin(10, 0, 10, 0),size = 20),
        legend.position = "none")

ggsave("F:/todo/Tesina/Imagenes/p_serie.png",plot=p_s, width = 26.5, height = 12.50, units = "cm")




#No parametricc 
np_pd <- ggplot(data= DataFrame_lag, aes(x=semanaDate,y=llamadas_lag,colour=segmentos_np))+
  geom_line()+  
  scale_color_manual(values = my_pal)+
  scale_x_date(breaks="6 months",labels = scales::label_date("%b %y"))+
  theme_minimal()+
  theme_hc()+
  labs(x="",title="",y="")+  
  scale_x_date(breaks="6 months",labels = scales::label_date("%b %y"))+
  scale_y_continuous(label=comma,breaks = scales::pretty_breaks(n = 7))+
  theme(axis.text.x = element_text(angle = 50, vjust = 1, hjust = 1, size = 14),
        axis.text.y = element_text( size = 14),
        plot.title = element_text(face = "bold",margin = margin(10, 0, 10, 0),size = 20),
        legend.position = "none")
ggsave("F:/todo/Tesina/Imagenes/np_pd.png",plot=np_pd, width = 26.5, height = 12.50, units = "cm")



np_s<-ggplot(data= DataFrame_lag, aes(x=semanaDate,y=llamadas,colour=segmentos_np))+
  geom_line()+  
  scale_color_manual(values = my_pal)+
  scale_x_date(breaks="6 months",labels = scales::label_date("%b %y"))+
  theme_minimal()+
  theme_hc()+
  labs(x="",title="",y="")+  
  scale_x_date(breaks="6 months",labels = scales::label_date("%b %y"))+
  scale_y_continuous(label=comma,breaks = scales::pretty_breaks(n = 7))+
  theme(axis.text.x = element_text(angle = 50, vjust = 1, hjust = 1, size = 14),
        axis.text.y = element_text( size = 14),
        plot.title = element_text(face = "bold",margin = margin(10, 0, 10, 0),size = 20),
        legend.position = "none")

ggsave("F:/todo/Tesina/Imagenes/np_s.png",plot=np_s, width = 26.5, height = 12.50, units = "cm")



