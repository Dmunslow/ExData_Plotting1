#################
####  Plot 4  ###
#################

# Check if project directory exists, create one in current working directory if not
if(!file.exists("Project 1")){
  dir.create("./Project 1")
}

# Store file URL for data set
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

# Check if file has been downloaded into project directory, download file if not
if(!file.exists("./Project 1/proj1.zip")){
  download.file(fileURL, "./Project 1/proj1.zip")
  unzip("./Project 1/proj1.zip", exdir = "./Project 1")
}

#Read all data into power.data data frame
power.data <- read.table("./Project 1/household_power_consumption.txt", 
                         sep = ";", header = TRUE, na.strings = "?")

# convert Date variable to date format for subsetting
power.data$Date <- as.Date(power.data$Date, format = "%d/%m/%Y")

# subset data for feb 1st and 2nd into feb.data data frame
feb.data <- power.data[power.data$Date == "2007-02-01" | power.data$Date == "2007-02-02",]

# remove power.data data frame from memory
rm(power.data)

# Create datetime variable by combining "Date" and "Time" columns 
# and coverting resulting column into a Time/Date format
feb.data$datetime <-  as.POSIXct(paste(feb.data$Date, feb.data$Time))

############################ Plot 4 ##########################################

png("./Project 1/plot4.png", width = 480, height = 480)

# Set plot to allow for 4 plots in 1
par(mfrow = c(2,2))

#First plot
with(feb.data, plot(datetime, Global_active_power, type = "l",
                    ylab = "Global Active Power", xlab=""))

# Second Plot
with(feb.data, plot(datetime, Voltage, type = "l"))


# Third Plot
with(feb.data, plot(datetime, Sub_metering_1, type ="l",
                    ylab = "Energy sub metering", xlab=""))
with(feb.data, lines(datetime, Sub_metering_2, type = "l", col = "red"))
with(feb.data, lines(datetime, Sub_metering_3, type = "l", col = "blue"))

legend("topright", col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"),
       lty = 1, bty ="n" )

# fourth plot
with(feb.data, plot(datetime, Global_reactive_power, type = "l"))

# Turn off plot4.png
dev.off()
