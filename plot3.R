plot3 <- function() {
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
    png(filename = "Plot3.png", width = 480, height = 480 )
    plot(powerdatatbl$NewTime, powerdatatbl$Sub_metering_1, type = "l", ylab = "Energy sub metering" , xlab = "")
    lines(powerdatatbl$NewTime, powerdatatbl$Sub_metering_2, type = "l", col = "red")
    lines(powerdatatbl$NewTime, powerdatatbl$Sub_metering_3, type = "l", col = "blue")
    legend(x = "topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1,1),
           lwd=c(2.5, 2.5), col = c("black", "red", "blue"))
    graphics.off()
    #summary(powerdatatbl)
    
    #hist(powerdatatbl$Global_active_power, freq=TRUE , col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)" )
}
