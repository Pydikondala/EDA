#Read HPC Full Dataset
library(data.table)
hpcdata <- fread("household_power_consumption.txt",na.strings = "?")
hpcdata$Date <- as.Date(hpcdata$Date, format="%d/%m/%Y")

#Gather Subsetted data
hpcsubdata <- subset(hpcdata,subset = (Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(hpcdata)

## Converting dates
datetime <- paste(as.Date(hpcsubdata$Date), hpcsubdata$Time)
hpcsubdata$Datetime <- as.POSIXct(datetime)

#str(hpcsubdata)
str(hpcsubdata)

#Plot onscreen for verificaiton
with(hpcsubdata, {
  plot(Sub_metering_1~Datetime, type="l",
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~Datetime,col='Red')
  lines(Sub_metering_3~Datetime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#Save to File
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()