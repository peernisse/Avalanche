setwd("C:/R_Projects/Avalanche")

library(tidyverse)
library(xml2)
library(lubridate)
library(XML)
library(rvest)


#Get the sample data from 
#https://utahavalanchecenter.org/avalanches/fatalities
#https://utahavalanchecenter.org/avalanches/reco-download

#Get avalanche data
if(!file.exists("./data")){dir.create("./data")}
fileURL<-"https://utahavalanchecenter.org/batch?op=start&id=10782"
download.file(fileURL,destfile = "./data/avalanches.csv",method="curl")
avs<-read.csv("./data/avalanches.csv",stringsAsFactors = F) %>% 
        as.data.frame() %>% 
        filter(Date != '',Region == 'Salt Lake')
newdates<-as.Date(avs$Date,format = "%m/%d/%Y")
avs$Date<-as.POSIXct(newdates)
avs$YEAR<-year(avs$Date)
avs$MONTH<-month(avs$Date,label=T)


# #Get avalanche fatality data
# URL<-"https://utahavalanchecenter.org/avalanches/fatalities"
# page<-read_html(URL)