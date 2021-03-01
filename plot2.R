## This script creates the plot2.png image file. 

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
png("plot2.png", 480, 480)

##Creates the plot which graphs Global Active Power over the datetimes during the targeted 2 days
plot(filtered_power_data$DT, filtered_power_data$Global_active_power, type = "l", main = "", ylab = "Global Active Power (kilowatts)", xlab = "")
dev.off()