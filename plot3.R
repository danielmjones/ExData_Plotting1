#Plot3.R file used to create plot 3.
##Assumes that the script can be run as a standalone script and therefore needs to download, unzip and load file.
##NOTE: This is done on a Windows platform and therefore CURL does not need to be used as part of the download arguement

#clear environment
rm(list = ls())

fileloc<-"./data/exdata%2Fdata%2Fhousehold_power_consumption.zip"

if (!file.exists(fileloc)){
        fileURL<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(fileURL, fileloc)
        unzip(fileloc, exdir = "./data")
}
filename<-"./data/household_power_consumption.txt"

#Load file into R and format Date variable
dat<-read.table(filename, header = TRUE, sep = ";", dec = ".", stringsAsFactors = FALSE, na.strings = "?")
dat$Date<-as.Date(dat$Date, format = "%d/%m/%Y")

#subset the data on dates 1/2/2007 and 2/2/2007
datsub <- subset(dat, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
#remove the full data set from R
rm(dat)

# Converting dates and times
datetime <- paste(as.Date(datsub$Date), datsub$Time)
datsub$Datetime <- as.POSIXct(datetime)

# Code for Plot 3 - png plot created, line graphs written to plot and then device turned off.
png("plot3.png", width=480, height=480)
plot(datsub$Datetime,datsub$Sub_metering_1, type = "l", xlab="", ylab="Energy Sub Metering")
lines(datsub$Datetime,datsub$Sub_metering_2, type = "l", col="red")
lines(datsub$Datetime,datsub$Sub_metering_3, type = "l", col="blue")
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=1, lwd=2, col = c("black","red","blue"))
dev.off()