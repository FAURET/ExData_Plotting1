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
              Sub_metering_3=as.numeric(Sub_metering_3),
              Voltage=as.numeric(Voltage)
              )
# ADDING OF VARIABLE = DAY+HOURS
Date1<-strptime(paste(data1$Date,data1$Time,sep=" "),"%Y-%m-%d %H:%M:%S")
data1<-cbind(data1,Date1)

#OPEN DEVICE
png(filename = "plot4.png", width = 480, height = 480, units = "px")

par(mfcol=c(2,2),mar=c(4,4,2,1))
with(data1,{
  plot(Date1,Global_active_power,type="l",xlab="", ylab="Global Active Power")
  
  plot(Date1,Sub_metering_1,type="l",xlab="", ylab="Energy sub Metering")
  lines(Date1,Sub_metering_2,type="l",col="red")
  lines(Date1,Sub_metering_3,type="l",col="blue")
  legend("topright",lwd=1,col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
  
  plot(Date1,Voltage,type="l",xlab="datetime", ylab="Voltage")
  plot(Date1,Global_reactive_power,type="l",xlab="datetime", ylab="Global_reactive_power")
})

#DEVICE CLOSE
dev.off()