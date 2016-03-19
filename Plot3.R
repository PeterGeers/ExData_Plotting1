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

## Define plot data from source
datetime <- strptime(paste(dataSet$Date, dataSet$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
globalActivePower <- as.numeric(dataSet$Global_active_power)
subMetering1 <- as.numeric(dataSet$Sub_metering_1)
subMetering2 <- as.numeric(dataSet$Sub_metering_2)
subMetering3 <- as.numeric(dataSet$Sub_metering_3)

## Start plot
par(mfrow = c(1, 1))
png("./data/plot3.png", width=480, height=480)
plot(datetime, subMetering1, type="l", ylab="Energy Submetering", xlab="")
lines(datetime, subMetering2, type="l", col="red")
lines(datetime, subMetering3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))
dev.off()
