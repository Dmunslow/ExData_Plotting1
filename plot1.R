#################
####  Plot 1  ###
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
power.data <- read.table("./Project 1/household_power_consumption.txt", sep = ";", header = TRUE, na.strings = "?")

# convert Date variable to date format for subsetting
power.data$Date <- as.Date(power.data$Date, format = "%d/%m/%Y")

# subset data for feb 1st and 2nd into feb.data data frame
feb.data <- power.data[power.data$Date == "2007-02-01" | power.data$Date == "2007-02-02",]

# remove power.data data frame from memory
rm(power.data)

############################ Plot 1 ##########################################

# open .png device with correct demensions
png("./Project 1/plot1.png", width = 480, height = 480)

# write plot1 to png device
with(feb.data,hist(Global_active_power, col = "red", 
                   main = "Global Active Power", 
                   xlab = "Global Active Power (kilowatts)"))

# Close .png device
dev.off()



