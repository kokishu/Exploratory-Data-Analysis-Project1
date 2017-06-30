library(dplyr)

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

# code for png file
png(filename = "plot4.png", width = 480,height = 480)
par(mfrow = c(2,2))

plot(E$DateTime, E$Global_active_power, type = "l", 
     ylab ="Global Active Power(kilowatts",
     xlab = "")
plot(E$DateTime, E$Voltage, type = "l", 
     ylab ="Voltage",
     xlab = "Datetime")

plot(E$DateTime, E$Sub_metering_1, 
     type = "l", 
     ylab ="Energy sub metering",
     xlab ="")
lines(E$DateTime, E$Sub_metering_2, col = "red")
lines(E$DateTime, E$Sub_metering_3, col = "blue")
legend("topright", c("sub_metering_1","sub_metering_2","sub_metering_3"),
       lty=1,
       
       col = c("black", "red", "blue"))
plot(E$DateTime, E$Global_reactive_power, type = "l", 
     ylab ="Global Active Power",
     xlab = "Datetime")

dev.off()