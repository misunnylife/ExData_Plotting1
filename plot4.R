# Script name: plot4.R
# Description: 1. Load data zip file from "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip".
#              2. Extract the file "household_power_consumption.txt".
#              3. Read data subsets from 01/02/2007 to 02/02/2007.
#              4. Plot the weekly Global Active Power distributions.
#              5. Plot the weekly Energy sub meterings distribution.
#              6. Plot the weekly Voltage distribution.
#              7. Plot the weekly Global reactive power distribution.
#              8. Output the plot in the file "plot4.png"

# Specifiy the ZIP file name
dlfile <- "exdata-data-household_power_consumption.zip"

# Specify the data file name
datafile <- "household_power_consumption.txt"

# Check for the existence of the data file
# NOTE: If this script is run multiple times within the same working directory,
#         checking here will avoid redundant creation of the same data set.
if (!file.exists(datafile))
{
    # Check for the existence of the zip file
    if (!file.exists(dlfile))
    {
      # Sip file does not exist, download it from web site
      fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
      download.file(fileUrl,destfile=dlfile)
    }
    
    # Extract the data file from the xip file
    unzip(dlfile)
}

# Read data into memory
data <- read.table(datafile, header = TRUE, sep = ";", stringsAsFactors = FALSE, dec = ".", na.strings = "?")

# Create subset of data for the period 01/02/2007 to 02/02/2007
dataset <- data[data$Date %in% c("1/2/2007","2/2/2007"),]

# Paste date and time data into one string
datetime <- strptime(paste(dataset$Date,dataset$Time, sep = " "), "%d/%m/%Y %H:%M:%S")

# Open device file for plotting
png("plot4.png", width = 480, height = 480)

# Setup 2x2 grid plot
par(mfrow=c(2,2))

with(dataset, {

    # Plot the first data set
  plot(datetime, as.numeric(Global_active_power), type="l",xlab= "",ylab = "Global Active Power")
  
  # Plot the second data set
  plot(datetime,as.numeric(Voltage), type = "l", xlab = "datetime", ylab = "Voltage")
  
  #Plot the third data set with 3 plots
  plot(datetime, as.numeric(Sub_metering_1), type="l",xlab= "",ylab = "Energy sub metering")
  lines(datetime,as.numeric(Sub_metering_2), col = "red")
  lines(datetime,as.numeric(Sub_metering_3), col = "blue")
  
  # Add legends to the plot #3
  legend("topright", col=c("black","red","blue"), lty = 1, lwd = 2,
         legend=c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))  
  
  # Plot the fourth data set
  plot(datetime,as.numeric(Global_reactive_power), type = "l", xlab = "datetime", ylab = "Global_reactive_power")
})



# Close the device file
dev.off()

# End of script file
