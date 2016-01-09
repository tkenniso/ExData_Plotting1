##### The following script uses data on household electric power consumption
##### from the UCI Machine Learning Repository. The data set is downloaded here: 
##### https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip

## The script reads the power consumption data into R, and plots four different
## time series plots of energy use over a two-day span in February 2007

plot4 <- function(directory) {
        
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
        
        # Create PNG
        png(filename="plot4.png",width=480,height=480)
        # Change default parameter to plot 2 per row, 2 per column
        par(mfrow=c(2,2))
        
                # Plot 1
                plot(data$Time,data$Global_active_power,type="l",ylab="Global Active Power", xlab="")
                # Plot 2
                plot(data$Time,data$Voltage,type="l",xlab="datetime",ylab="Voltage")
                # Plot 3
                plot(data$Time,data$Sub_metering_1,type="n",ylab="Energy sub metering", xlab="")
                points(data$Time, data$Sub_metering_1, col="black", type="l")
                points(data$Time, data$Sub_metering_2, col="red", type="l")
                points(data$Time, data$Sub_metering_3, col="blue", type="l")
                legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red","blue"),lty=1, bty="n")
                # Plot 4
                plot(data$Time,data$Global_reactive_power,type="l",ylab="Global_reactive_power",xlab="datetime")

        dev.off()       # Close PNG device 
}