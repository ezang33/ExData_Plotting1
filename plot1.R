## This script creates the plot1.png image file. 

## Reads the data table with knowledge that the data entries are separated by ";"
## and the missing data entries are "?" when removing the NA rows.

power_data <- read.table("household_power_consumption.txt", sep = ';', header = TRUE, na.strings = '?')
power_data <- na.omit(power_data)

## Filters the data set by the two desired dates
filtered_power_data <- power_data[(power_data$Date == '2/2/2007' | power_data$Date == '1/2/2007' ),]

## Creates the png file with size 480x480
png("plot1.png", 480, 480)

##Creates the plot graphing frequency of Global Active Power
hist(filtered_power_data$Global_active_power, col = 'red', xlab = 'Global Active Power (kilowatts)', main = 'Global Active Power')
dev.off()