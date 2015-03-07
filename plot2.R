plot2 <- function() {
    require(dplyr)
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "power_data.zip")
    unzip("power_data.zip")
    dataheading <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", nrows = 1)
    powerdata <- read.table("household_power_consumption.txt", 
                            header = FALSE, sep = ";", col.names = dataheading, 
                            na.strings = c("?"), nrows = 10000, skip = 66000, 
                            check.names = TRUE)
    names(powerdata)<- names(dataheading)
    powerdatatbl <- tbl_df(powerdata)
    powerdatatbl$Date <- as.Date(powerdatatbl$Date, format = "%d/%m/%Y")
    powerdatatbl$NewTime <- as.POSIXct(paste(powerdatatbl$Date, powerdatatbl$Time),
                                       format = "%Y-%m-%d %H:%M:%S")
    
    powerdatatbl <- powerdatatbl %>% filter(Date =="2007-02-01" | Date =="2007-02-02")
    powerdatatbl$Weekday <- weekdays(powerdatatbl$Date, abbreviate = TRUE)
    png(filename = "Plot2.png", width = 480, height = 480, bg = "transparent")
    plot(powerdatatbl$NewTime, powerdatatbl$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)" , xlab = "")
    graphics.off()
    
    #hist(powerdatatbl$Global_active_power, freq=TRUE , col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)" )
}
