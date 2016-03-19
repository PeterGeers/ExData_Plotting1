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
## Posix format of Date en Time
datetime <- strptime(paste(dataSet$Date, dataSet$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
globalActivePower <- as.numeric(dataSet$Global_active_power)
## Set target file
par(mfrow = c(1, 1))
png("./data/plot2.png", width=480, height=480)
plot(datetime, globalActivePower, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()
## Show on screen
plot(datetime, globalActivePower, type="l", xlab="", ylab="Global Active Power (kilowatts)")
