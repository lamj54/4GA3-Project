
rm(list = ls())
library(isdas)
library(spatstat)
library(tidyverse)
library(ggplot2)
library(rgdal)
library(sf)


getwd()
CSD <- st_read("/Users/piercebourgeois/Documents/School/YEAR FOUR/4GA3/WD/Neighbourhoods/Neighbourhoods.shp")
st_drivers()

ggplot() + 
  geom_sf(data = CSD, size = 1, color = "black", fill = "cyan1") + 
  ggtitle("Neighbourhoods") + 
  coord_sf()

