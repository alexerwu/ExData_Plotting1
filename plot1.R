# set working directory
setwd("~/Documents/courses/data_science/ExData_Plotting1")

# read text file into R
power_consumption <- read.csv("household_power_consumption.txt", header = TRUE, sep = ";", quote = "\"")

# converte Date column to character using strptime() and as.Date()
power_consumption_date_converted <- strptime(power_consumption$Date, "%d/%m/%Y", tz="")

# subset file for 2007-02-01 and 2007-02-01 and rbind to combine into single object
power_consumption_feb1 <- power_consumption[strptime(power_consumption$Date, "%d/%m/%Y", tz="") == "2007-02-01 EST",]
power_consumption_feb2 <- power_consumption[strptime(power_consumption$Date, "%d/%m/%Y", tz="") == "2007-02-02 EST",]
power_consumption_feb <- rbind(power_consumption_feb1, power_consumption_feb2)

# filter "?" from power_consumption_feb$Global_active_power
power_consumption_feb_filtered <- power_consumption_feb[power_consumption_feb$Global_active_power != "?",]

# open png file
png(filename = "plot1.png",
    width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white")

# convert power_consumption_feb_filtered$Global_active_power to numeric
# divide that number by 1000 to get Kilowatt
#and plot histogram of Global_active_power vs. Frequency
hist(as.numeric(power_consumption_feb_filtered$Global_active_power)/1000, 
     col="red", breaks=15, freq=TRUE, main = "Global Active Power", 
     xlab = "Global Active Power (Kilowatts)", ylab = "Frequency")

# close plot
dev.off()
