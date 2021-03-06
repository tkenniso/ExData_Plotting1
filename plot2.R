##### The following script uses data on household electric power consumption
##### from the UCI Machine Learning Repository. The data set is downloaded here: 
##### https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip

## The script reads the power consumption data into R, and plots a scatterplot of global active power
## over a two-day span in February 2007

plot2 <- function(directory) {
        
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
        
        # Create Scatterplot of household global active power over 2-day span
        png(filename="plot2.png",width=480,height=480)
        plot(data$Time,data$Global_active_power,type="l",ylab="Global Active Power (kilowatts)", xlab="")
        dev.off()                       # Close PNG device    
        
}

