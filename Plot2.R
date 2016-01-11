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
plot(hpcsubdata$Global_active_power~hpcsubdata$Datetime, type="l",
     ylab="Global Active Power (kilowatts)", xlab="")

#Save to File
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()
