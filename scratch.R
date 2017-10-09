deaths<-read.csv('KoreanConflict.csv',header=TRUE,stringsAsFactors=FALSE)

# to see the amount of mistakes you can throw this in the console
## sum(str_detect(deaths$INCIDENT_DATE,"\\d{8}")) and then do a dimension search of how many actual death
# numbers there are within that column... so dim(deaths) and then subtract and that will show you all the
## entries that don't have 8 digits.

sum(str_detect(deaths$INCIDENT_DATE,"\\d{8}"))

for(i in 1:36574){
  incident<-str_detect(deaths$INCIDENT_DATE[i],"\\d{8}")
  fatality<-str_detect(deaths$FATALITY[i],"\\d{8}")
  if(incident==FALSE & fatality==TRUE){
    deaths$INCIDENT_DATE[i]<-deaths$FATALITY[i]
  }
  print(i)
}

#only worried about the incident date header... filter, is filtering out to show only the incident dates 
#that have the 8 digits... and then summarize is showing the number of deaths that occured on each date
df<-deaths%>%
  filter(str_detect(INCIDENT_DATE,"\\d{8}")==TRUE)%>%
  group_by(INCIDENT_DATE)%>%
  summarize(num_deaths=n())%>%
  mutate(Date = ymd(INCIDENT_DATE))%>%
  filter(Date<="1953-07-27")%>%
  select(INCIDENT_DATE,num_deaths,Date)

#ctrl, enter above and then head(df) in console... shows three columns, even if that error message comes uo

ggplot()+
  geom_line(data=df,aes(x=Date,y=num_deaths))+
  scale_x_date(date_breaks='3 months',date_labels="%b %y")
