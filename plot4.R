## This script creates the plot1.png image file. 

## Reads the data table with knowledge that the data entries are separated by ";"
## and the missing data entries are "?" when removing the NA rows.

power_data <- read.table("household_power_consumption.txt", sep = ';', header = TRUE, na.strings = '?')
power_data <- na.omit(power_data)

## Filters the data set by the two desired dates

filtered_power_data <- power_data[(power_data$Date == '2/2/2007' | power_data$Date == '1/2/2007' ),]

## Change the date column to be date type objects instead of chars

filtered_power_data$Date <- as.Date(filtered_power_data$Date, format = '%e/%m/%Y')

## Merge the Date and Time columns together and use strptime to create DataTime objects

filtered_power_data$DT <- strptime(paste(filtered_power_data$Date, filtered_power_data$Time), format = "%Y-%m-%d %H:%M:%S" )

## Creates the png file with size 480x480

png("plot4.png", 480, 480)

#Sets the Plots to appear as 2 rows 2 columns
par(mfrow = c(2,2))

##Creates 4 plots where:
## Top Left Plot is graphing Global Active Power over datetime
## Top Right Plot is graphing Voltage over datetime
## Bottom Left Plot is graphing the 3 Sub metering over datetime
## Bottom Right Plot is graphing Global Reactive Power over datetime


with(filtered_power_data, {
    plot(filtered_power_data$DT, filtered_power_data$Global_active_power, type = "l", main = "", ylab = "Global Active Power", xlab = "")
    plot(filtered_power_data$DT, filtered_power_data$Voltage, type = "l", main = "", ylab = "Voltage", xlab = "datetime")
    plot(filtered_power_data$DT, filtered_power_data$Sub_metering_1, type = "l", main = "", ylab = "Energy sub metering", xlab = "")
    lines(filtered_power_data$DT, filtered_power_data$Sub_metering_2, type = "l",col = 'red')
    lines(filtered_power_data$DT, filtered_power_data$Sub_metering_3, type = "l",col = 'blue')
    legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),col = c("black", "red", "blue"), lwd = 2, bty = "n" )
    plot(filtered_power_data$DT, filtered_power_data$Global_reactive_power, type = "l", main = "", ylab = "Global_reactive_power", xlab = "datetime")
})
dev.off()