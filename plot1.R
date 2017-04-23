#Plot1.R file used to create plot 1.

##Download zip file and unzip. 
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

# Code for Plot 1 - png plot created, histogram written to plot and then device turned off.
png("plot1.png", width=480, height=480)
hist(datsub$Global_active_power, xlab="Global Active Power (kilowatts)", ylab="Frequency", main="Global Active Power", col = "red")
dev.off()