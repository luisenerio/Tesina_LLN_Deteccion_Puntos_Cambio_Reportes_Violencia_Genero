


x <- c("ggmap", "rgdal", "rgeos", "maptools", "dplyr", "tidyr", "tmap","sf")
x


lapply(x, library, character.only = TRUE) # load the required packages