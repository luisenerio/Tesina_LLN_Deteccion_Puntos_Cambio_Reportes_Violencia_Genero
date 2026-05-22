


#install.packages(c("cowplot", "googleway", "ggplot2", "ggrepel", 
     #              "ggspatial", "libwgeom", "sf", "rnaturalearth", "rnaturalearthdata"))



library("ggplot2")
theme_set(theme_bw())
library("sf")



library("rnaturalearth")
library("rnaturalearthdata")
library("tidyverse")

world <- ne_countries(scale='medium',returnclass = 'sf')
class(world)


ruta <- "F:/todo/Tesina"
ruta_completa <-paste(ruta,"/Datos/Datos.csv",sep="")


datos <- readr::read_delim(ruta_completa, 
                           delim=",",
                           col_types = cols(fecha=col_date("%d/%m/%Y")))
sites <- datos %>% select(latitud,longitud)



ggplot(data = world) +
  geom_sf() +
  geom_point(data = sites, aes(x = longitud, y = latitud), size = 4, 
             shape = 23, fill = "darkred")+coord_sf(ylim = c(25, 26), xlim = c(-101, -100), expand = T)




ggplot(data = world) +
  geom_sf(data = states, fill = NA) 
  geom_sf() +coord_sf(ylim = c(25, 26), xlim = c(-101, -100), expand = T)

  
  
  