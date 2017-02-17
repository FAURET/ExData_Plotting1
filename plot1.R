library(dplyr)
library(lubridate)


#FILE READING
file<-"household_power_consumption.txt"
data<-read.csv(file,sep=";",stringsAsFactors=FALSE, dec=".")

#FILTERING => 2 DAYS
data<-mutate(data,Date=dmy(Date))
data1<-filter(data,Date=="2007-02-01" | Date=="2007-02-02")

# TRANSFORM THE DATA CLASS
data1<-mutate(data1,Global_active_power=as.numeric(Global_active_power),
              Global_reactive_power=as.numeric(Global_reactive_power),
              Sub_metering_1=as.numeric(Sub_metering_1),
              Sub_metering_2=as.numeric(Sub_metering_2),
              Sub_metering_3=as.numeric(Sub_metering_3)
              )


#OPEN DEVICE
png(filename = "plot1.png", width = 480, height = 480, units = "px")
with(data1,hist(Global_active_power,col="red",xlab="Global Active Power (kilowatts)",main="Global Active Power"))
dev.off()
