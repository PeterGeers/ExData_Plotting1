## load libraries
library(data.table)
## Dataset can be found here
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
dataSet <- NULL
zipFile <-"./data/household_power_consumption.zip"
if(!file.exists(zipFile))
{download.file(fileUrl, destfile = zipFile)}

## if file not unzipped, unzip zipFile
## fileToLoad <- list.files(path="./data", pattern = "consumption.txt$", full.names = TRUE, recursive = TRUE)
fileToLoad <- "./data/household_power_consumption.txt"
if(!file.exists(fileToLoad))
{ unzip(zipFile, exdir = "./data/.") }
## If files are not loaded then read files in tables
if (is.null(dataSet)) {dataSet <- read.table(fileToLoad, header = TRUE, sep = ";") }
dataSet <- data.table(dataSet)
## Keep only the 2 relevant dates
dataSet <- dataSet[dataSet$Date %in% c("1/2/2007","2/2/2007") ,]

## get data to plot
datetime <- strptime(paste(dataSet$Date, dataSet$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
globalActivePower <- as.numeric(dataSet$Global_active_power)
globalReactivePower <- as.numeric(dataSet$Global_reactive_power)
voltage <- as.numeric(dataSet$Voltage)
subMetering1 <- as.numeric(dataSet$Sub_metering_1)
subMetering2 <- as.numeric(dataSet$Sub_metering_2)
subMetering3 <- as.numeric(dataSet$Sub_metering_3)

## start the plot
png("./data/plot4.png", width=480, height=480)
par(mfrow = c(2, 2))
plot(datetime, globalActivePower, type="l", xlab="", ylab="Global Active Power", cex=0.2)

plot(datetime, voltage, type="l", xlab="datetime", ylab="Voltage")

plot(datetime, subMetering1, type="l", ylab="Energy Submetering", xlab="")
lines(datetime, subMetering2, type="l", col="red")
lines(datetime, subMetering3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=, lwd=2.5, col=c("black", "red", "blue"), bty="o")

plot(datetime, globalReactivePower, type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()
