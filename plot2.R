# Script name: plot2.R
# Description: 1. Load data zip file from "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip".
#              2. Extract the file "household_power_consumption.txt".
#              3. Read data subsets from 01/02/2007 to 02/02/2007.
#              4. Plot the weekly Global Active Power distribution.
#              5. Output the plot in the file "plot2.png"

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

# Open device file for plotting
png("plot2.png", width = 480, height = 480)

# Paste date and time data into one string
datetime <- strptime(paste(dataset$Date,dataset$Time, sep = " "), "%d/%m/%Y %H:%M:%S")

# Plot the data with required labels and features 
plot(datetime, as.numeric(dataset$Global_active_power), type="l",xlab= "",ylab = "Global Active Power (kilowatts)")

# Close the device file
dev.off()

# End of script file
