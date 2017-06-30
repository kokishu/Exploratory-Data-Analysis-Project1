library(dplyr)
library(ggplot2)


#Read Data in from 1/2/2007 to 2/2/2007
E <-read.table("household_power_consumption.txt",
               skip = grep("1/2/2007",readLines("household_power_consumption.txt")),
               nrows = 2880,sep = ";",header = FALSE,
               col.names = c("Date","Time","Global_active_power","Global_reactive_power","Voltage",
                             "Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3"),
               stringsAsFactors = FALSE,quote = "\"'",na.string = "?")

# format Date and Time column 
e6 <-paste(as.Date(E$Date, "%d/%m/%Y"),E$Time)

#combine Date/Times into one vector

DateTime <- strptime(e6, format = "%Y-%m-%d %H:%M:%S")

# combine DateTime Vector to E dataframe
E <-cbind(DateTime, E)

#draw plot code
plot(E$DateTime, E$Global_active_power, type = "l", 
     ylab ="Global Active Power(kilowatts)",
     xlab = "")

#code for png file
png(filename = "plot2.png", width = 480,height = 480)
plot(E$DateTime, E$Global_active_power, type = "l", 
     ylab ="Global Active Power(kilowatts)",
     xlab = "")

dev.off()
     
     
     
     
     