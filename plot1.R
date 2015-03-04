plot1 <- function() {
    require(dplyr)
    require(xts)
    dataheading <- read.table("exdata-data-household_power_consumption/household_power_consumption.txt", header = TRUE, sep = ";", nrows = 1)
    powerdata <- read.table("exdata-data-household_power_consumption/household_power_consumption.txt", 
                            header = FALSE, sep = ";", col.names = dataheading, 
                            na.strings = c("?"), nrows = 10000, skip = 66000, 
                            check.names = TRUE)
    names(powerdata)<- names(dataheading)
    powerdatatbl <- tbl_df(powerdata)
    powerdatatbl$Date <- as.Date(powerdatatbl$Date, format = "%d/%m/%Y")
    powerdatatbl$NewTime <- as.POSIXct(paste(powerdatatbl$Date, powerdatatbl$Time),
                                       format = "%Y-%m-%d %H:%M:%S")
    
    powerdatatbl <- powerdatatbl %>% filter(Date =="2007-02-01" | Date =="2007-02-02")
    hist(powerdatatbl$Global_active_power, freq=TRUE , col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)" )
}
