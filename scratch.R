deaths <- read.csv('KoreanConflict.csv',header=TRUE,stringsAsFactors = FALSE)

sum(str_detect(deaths$INCIDENT_DATE,"\\d{8}"))

# to see the amount of mistakes you can throw this in the console
## sum(str_detect(deaths$INCIDENT_DATE,"\\d{8}")) and then do a dimension search of how many actual death
# numbers there are within that column... so dim(deaths) and then subtract and that will show you all the
## entries that don't have 8 digits.

for(i in 1:36574){
  incident<-str_detect(deaths$INCIDENT_DATE[i],"\\d{8}")
  fatality<-str_detect(deaths$FATALITY[i],"\\d{8}")
  if(incident==FALSE & fatality == TRUE){
    deaths$INCIDENT_DATE[i]<-deaths$FATALITY[i]
  }
    print(i)
  }