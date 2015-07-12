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

# convert global reactive power to numeric
power_consumption_feb_filtered$Global_reactive_power_numeric <- as.numeric(power_consumption_feb_filtered$Global_reactive_power)

# open png file
png(filename = "plot4.png",
    width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white")

# set up multiple base plots
par(mfrow = c(2,2))

# plot global active power vs. DateTime
plot(power_consumption_feb_filtered$DateTime, power_consumption_feb_filtered$Global_active_power_numeric, type="l", xlab="", ylab="Global Active Power (Kilowatts)")

# plot voltage vs. DateTime
plot(power_consumption_feb_filtered$DateTime, power_consumption_feb_filtered$Voltage, type="l", xlab="datetime", ylab="Voltage")


# set up plot device
with(power_consumption_feb_filtered, plot(DateTime, Sub_metering_1, type="n", xlab="", ylab="Energy sub metering"))

# plot global active power vs. Sub_metering_1
with(power_consumption_feb_filtered, lines(DateTime, Sub_metering_1))

# plot global active power vs. Sub_metering_2
with(power_consumption_feb_filtered, lines(DateTime, Sub_metering_2, col="red"))

# plot global active power vs. Sub_metering_3
with(power_consumption_feb_filtered, lines(DateTime, Sub_metering_3, col="blue"))

legend("topright", pch = "_", col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# plot global reactive power vs. DateTime
plot(power_consumption_feb_filtered$DateTime, power_consumption_feb_filtered$Global_reactive_power_numeric, type="l", xlab="datetime", ylab="Global_reactive_power")

# close plot
dev.off()
