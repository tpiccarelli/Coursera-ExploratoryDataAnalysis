# EXPLORATORY DATA ANALYSIS
# Course Project 1


# STEP 1: structuring data

    # Load needed package:
    require(dplyr)
    require(data.table)
    
    # Set working directory:
    setwd("C:/Users")
    
    # Read data file:
    download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "exdata_data_household_power_consumption")
    unzip("./household_power_consumption.zip")
    courseproject1_data <- read.csv(file = "./household_power_consumption.txt", header = T, sep = ";", na.strings = "?")
    
    # Filter desired dates (2007-02-01 and 2007-02-02):
    cp1_df <- filter(courseproject1_data, Date=="1/2/2007" | Date=="2/2/2007")
    
    # Convert 1st and 2nd columns' elements to date and time:
    date <- paste(cp1_df[,1], cp1_df[,2]) %>%
        strptime(format = "%d/%m/%Y %H:%M:%S")
    
    # Bind col1 and col2 with cp1_df:
    cp1 <- cbind(cp1_df, date)
    # Re-set data frame structure and columns' headers:
    cp1 <- select(cp1, date, Global_active_power:Sub_metering_3)
    setnames(x = cp1, old=names(cp1), new = c("Date", names(cp1_df[,3:9])))
    
    cp1_df <- cp1
    
    # Remove unused objects:
    rm("courseproject1_data", "cp1", "date")
    
# STEP 2: plotting graphics
    
    # Plot1:
    png(filename = "plot1.png", width = 480, height = 480, units = "px")
    hist(x = cp1_df$Global_active_power, 
                  freq = 1:1200, 
                  col = "red", 
                  main = "Global Active Power", 
                  xlab = "Global Active Power (kilowatts)", 
                  ylim = c(0,1200))
    dev.off()
