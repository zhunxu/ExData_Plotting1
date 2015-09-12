## read whole text file
largeData <- read.table("household_power_consumption.txt", sep=";", header=TRUE, as.is = TRUE)

## subset to contain only data from the dates 2007-02-01 and 2007-02-02
power <- subset(largeData, as.Date(Date, format = "%d/%m/%Y") >= "2007-02-01" & as.Date(Date, format = "%d/%m/%Y") <= "2007-02-02")

## define missing value
power$Global_active_power[power$Global_active_power=="?"] <- NA 

## change directory
setwd("ExData_Plotting1")

## create plot1.png file
png(filename = "plot1.png", width = 480, height = 480)
    
## draw histgram of Global_active_power
hist(as.numeric(power$Global_active_power), col = 'red', xlab = "Global Active Power (kilowatts)",
     main = "Global Active Power")

## close the PNG file device
dev.off()

## change directory back
setwd("..")
