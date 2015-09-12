## read whole text file
largeData <- read.table("household_power_consumption.txt", sep=";", header=TRUE, as.is = TRUE)

## subset to contain only data from the dates 2007-02-01 and 2007-02-02
power <- subset(largeData, as.Date(Date, format = "%d/%m/%Y") >= "2007-02-01" & as.Date(Date, format = "%d/%m/%Y") <= "2007-02-02")

## define missing value
power$Global_active_power[power$Global_active_power=="?"] <- NA 
transform(power, Global_active_power = as.numeric(Global_active_power))

power$Sub_metering_1[power$Sub_metering_1=="?"] <- NA 
transform(power, Sub_metering_1 = as.numeric(Sub_metering_1))

power$Sub_metering_2[power$Sub_metering_2=="?"] <- NA 
transform(power, Sub_metering_2 = as.numeric(Sub_metering_2))

power$Sub_metering_3[power$Sub_metering_3=="?"] <- NA 
transform(power, Sub_metering_3 = as.numeric(Sub_metering_3))

power$Voltage[power$Voltage=="?"] <- NA 
transform(power, Voltage = as.numeric(Voltage))

power$Voltage[power$Voltage=="?"] <- NA 
transform(power, Voltage = as.numeric(Voltage))

power$Global_reactive_power[power$Global_reactive_power=="?"] <- NA 
transform(power, Global_reactive_power = as.numeric(Global_reactive_power))

## add a new column to power
power_new <- within(power, { datetime=format(as.POSIXct(paste(as.Date(Date, format = "%d/%m/%Y"), Time)), "%Y-%m-%d %H:%M:%S") })

## change directory
setwd("ExData_Plotting1")

## create plot4.png file
png(filename = "plot4.png", width = 480, height = 480)
par(mfcol = c(2, 2))
with(power_new, {

		## draw line plot of Global_active_power over time
		plot(strptime(power_new$datetime, "%Y-%m-%d %H:%M:%S"), as.numeric(power_new$Global_active_power), type = "n", xlab = "",
			ylab = "Global Active Power (kilowatts)")
		lines(strptime(power_new$datetime, "%Y-%m-%d %H:%M:%S"), as.numeric(power_new$Global_active_power), type="l")

		## draw line plot of sub_metering_1 to sub_metering_3 over time
		plot(strptime(power_new$datetime, "%Y-%m-%d %H:%M:%S"), as.numeric(power_new$Sub_metering_1), type = "n", xlab = "",
			ylab = "Energy sub metering")
		lines(strptime(power_new$datetime, "%Y-%m-%d %H:%M:%S"), as.numeric(power_new$Sub_metering_1), type="l", col = "black")
		lines(strptime(power_new$datetime, "%Y-%m-%d %H:%M:%S"), as.numeric(power_new$Sub_metering_2), type="l", col = "red")
		lines(strptime(power_new$datetime, "%Y-%m-%d %H:%M:%S"), as.numeric(power_new$Sub_metering_3), type="l", col = "blue")

		## draw line plot of Voltage over time
		plot(strptime(power_new$datetime, "%Y-%m-%d %H:%M:%S"), as.numeric(power_new$Voltage), type = "n", xlab = "datetime",
			ylab = "Voltage")
		lines(strptime(power_new$datetime, "%Y-%m-%d %H:%M:%S"), as.numeric(power_new$Voltage), type="l")

		## draw line plot of Global_reactive_power over time
		plot(strptime(power_new$datetime, "%Y-%m-%d %H:%M:%S"), as.numeric(power_new$Global_reactive_power), type = "n", xlab = "datetime",
			ylab = "Global_reactive_power")
		lines(strptime(power_new$datetime, "%Y-%m-%d %H:%M:%S"), as.numeric(power_new$Global_reactive_power), type="l")
		})

## close the PNG file device
dev.off()

## change directory back
setwd("..")



