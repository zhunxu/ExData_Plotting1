## read whole text file
largeData <- read.table("household_power_consumption.txt", sep=";", header=TRUE, as.is = TRUE)

## subset to contain only data from the dates 2007-02-01 and 2007-02-02
power <- subset(largeData, as.Date(Date, format = "%d/%m/%Y") >= "2007-02-01" & as.Date(Date, format = "%d/%m/%Y") <= "2007-02-02")

## define missing value
power$Global_active_power[power$Global_active_power=="?"] <- NA 
transform(power, Global_active_power = as.numeric(Global_active_power))

## add a new column to power
power_new <- within(power, { datetime=format(as.POSIXct(paste(as.Date(Date, format = "%d/%m/%Y"), Time)), "%Y-%m-%d %H:%M:%S") })

## change directory
setwd("ExData_Plotting1")

## create plot2.png file
png(filename = "plot2.png", width = 480, height = 480)

## draw line plot of Global_active_power over time
plot(strptime(power_new$datetime, "%Y-%m-%d %H:%M:%S"), as.numeric(power_new$Global_active_power), type = "n", xlab = "",
	ylab = "Global Active Power (kilowatts)")
lines(strptime(power_new$datetime, "%Y-%m-%d %H:%M:%S"), as.numeric(power_new$Global_active_power), type="l")

## close the PNG file device
dev.off()

## change directory back
setwd("..")
