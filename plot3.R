## read whole text file
largeData <- read.table("household_power_consumption.txt", sep=";", header=TRUE, as.is = TRUE)

## subset to contain only data from the dates 2007-02-01 and 2007-02-02
power <- subset(largeData, as.Date(Date, format = "%d/%m/%Y") >= "2007-02-01" & as.Date(Date, format = "%d/%m/%Y") <= "2007-02-02")

## define missing value
power$Sub_metering_1[power$Sub_metering_1=="?"] <- NA 
transform(power, Sub_metering_1 = as.numeric(Sub_metering_1))

power$Sub_metering_2[power$Sub_metering_2=="?"] <- NA 
transform(power, Sub_metering_2 = as.numeric(Sub_metering_2))

power$Sub_metering_3[power$Sub_metering_3=="?"] <- NA 
transform(power, Sub_metering_3 = as.numeric(Sub_metering_3))

## add a new column to power
power_new <- within(power, { datetime=format(as.POSIXct(paste(as.Date(Date, format = "%d/%m/%Y"), Time)), "%Y-%m-%d %H:%M:%S") })

## change directory
setwd("ExData_Plotting1")

## create plot3.png file
png(filename = "plot3.png", width = 480, height = 480)

## draw line plot of sub_metering_1 to sub_metering_3 over time
plot(strptime(power_new$datetime, "%Y-%m-%d %H:%M:%S"), as.numeric(power_new$Sub_metering_1), type = "n", xlab = "",
	ylab = "Energy sub metering")
lines(strptime(power_new$datetime, "%Y-%m-%d %H:%M:%S"), as.numeric(power_new$Sub_metering_1), type="l", col = "black")
lines(strptime(power_new$datetime, "%Y-%m-%d %H:%M:%S"), as.numeric(power_new$Sub_metering_2), type="l", col = "red")
lines(strptime(power_new$datetime, "%Y-%m-%d %H:%M:%S"), as.numeric(power_new$Sub_metering_3), type="l", col = "blue")

legend("topright", col = c("black", "red", "blue"), lty=c(1,1,1),
	legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## close the PNG file device
dev.off()

## change directory back
setwd("..")
