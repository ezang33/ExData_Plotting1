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

png("plot3.png", 480, 480)

## Creates the plot graphing sub metering 1 over the datetimes. Colored as black line
plot(filtered_power_data$DT, filtered_power_data$Sub_metering_1, type = "l", main = "", ylab = "Energy sub metering", xlab = "")

## Adds line graphing sub metering 2 over the datetimes. Colored as red line

lines(filtered_power_data$DT, filtered_power_data$Sub_metering_2, type = "l",col = 'red')

## Adds line graphing sub metering 3 over the datetimes. Colored as blue line

lines(filtered_power_data$DT, filtered_power_data$Sub_metering_3, type = "l",col = 'blue')

## Creates legend in top right corner of plot detailing the 3 lines that were graphed

legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),col = c("black", "red", "blue"), lwd = 2 )
dev.off()