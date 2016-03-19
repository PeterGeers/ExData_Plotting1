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
if (is.null(dataSet)) {dataSet <- read.table(fileToLoad) }
## Keep only the 2 relevant dates
dataSet <- dataSet[dataSet$Date %in% c("1/2/2007","2/2/2007") ,]
## Retrieve data to plot

globalActivePower <- as.numeric(dataSet$Global_active_power)
par(mfrow = c(1, 1))
png("./data/plot1.png", width=480, height=480)
hist(globalActivePower, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()
