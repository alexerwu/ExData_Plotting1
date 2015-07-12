# set working directory
setwd("~/Documents/courses/data_science/ExData_Plotting1")

# read text file into R
power_consumption <- read.csv("household_power_consumption.txt", header = TRUE, sep = ";", quote = "\"")

# convert Date column to character using strptime() and as.Date()
power_consumption_date_converted <- strptime(power_consumption$Date, "%d/%m/%Y", tz="")

# subset file for 2007-02-01 and 2007-02-01 and rbind to combine into single object
power_consumption_feb1 <- power_consumption[strptime(power_consumption$Date, "%d/%m/%Y", tz="") == "2007-02-01 EST",]
power_consumption_feb2 <- power_consumption[strptime(power_consumption$Date, "%d/%m/%Y", tz="") == "2007-02-02 EST",]
power_consumption_feb <- rbind(power_consumption_feb1, power_consumption_feb2)

# filter "?" from power_consumption_feb$Global_active_power
power_consumption_feb_filtered <- power_consumption_feb[power_consumption_feb$Global_active_power != "?",]

# combine Date, Time columnes into DateTime
power_consumption_feb_filtered$DateTime <- paste(power_consumption_feb_filtered$Date, power_consumption_feb_filtered$Time, sep=" ")

# transform Datetime into POSIXlt format using strptime()
power_consumption_feb_filtered$DateTime <- strptime(power_consumption_feb_filtered$DateTime, "%d/%m/%Y %H:%M:%S", tz="")

# add column for day of week corresponding to Date column
power_consumption_feb_filtered$day <- weekdays(as.Date(power_consumption_feb_filtered$Date))

# convert global active power to numeric and kilowatt
power_consumption_feb_filtered$Global_active_power_numeric <- as.numeric(power_consumption_feb_filtered$Global_active_power)/1000

# open png file
png(filename = "plot2.png",
    width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white")

# plot global active power vs. day of week
plot(power_consumption_feb_filtered$DateTime, power_consumption_feb_filtered$Global_active_power_numeric, type="l", xlab="", ylab="Global Active Power (Kilowatts)")

# close plot
dev.off()
