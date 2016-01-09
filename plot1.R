##### The following script uses data on household electric power consumption
##### from the UCI Machine Learning Repository. The data set is downloaded here: 
##### https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip

## The script reads the power consumption data into R, and constructs a Histogram of household global active power

plot1 <- function(directory) {
        
        # Set directory, load libraries
        setwd(directory)
        library(dplyr)
        
        # Download UCI data
        fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        temp <- tempfile()              # create temporary file
        download.file(fileUrl,temp)     # download zip file
        # unzip, save to dataframe
        data <- read.table(unz(temp,"household_power_consumption.txt"), sep=";", header=TRUE, na.strings="?")
        
        # Convert Date and Time variables to Date/Time class
        data$Time <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")
        data$Date <- as.Date(data$Date, "%d/%m/%Y")

        # Keep obs from (Feb 1st-2nd, 2007)
        data <- subset(data, Date == as.Date("2007-02-01", "%Y-%m-%d")| Date == as.Date("2007-02-02", "%Y-%m-%d"))
        
        # Create Histogram of household global active power
        png(filename="plot1.png",width=480,height=480)
        hist(data$Global_active_power, col="red", xlab="Global Active Power (kilowatts)",main="Global Active Power")
        dev.off()                       # Close PNG device    
}


