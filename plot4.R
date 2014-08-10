plot4 <- function(){
        
        ## Set up the data
        setAs("character","makeDate", function(from) as.Date(from, format="%d/%m/%Y") )
        hpc <- read.table("household_power_consumption.txt", sep=";",
                          nrows=2500000, header=TRUE, stringsAsFactors=FALSE, 
                          colClasses = c("makeDate", "character", rep("numeric", 7)), 
                          na.strings = "?")
        
        ##subset to get data frame with only the two days 
        hpcSub <- subset(hpc, Date == '2007-02-01' | Date == '2007-02-02') 
        
        ##convert the Time column to date/time to make the plotting easier
        hpcSub$Time <- strptime(paste(hpcSub$Date, hpcSub$Time), "%Y-%m-%d %H:%M:%S")
        
        ## plot 4 - 4 plots 2 rows with 2 colums each
        png("plot4.png", width=480, height=480)
        par(mfrow = c(2,2))
        par(cex.axis = .75, cex.lab = .75) ##make text size smaller
        with(hpcSub, {
                plot(Time, Global_active_power, ylab = "Global Active Power", xlab = "", type = "l")
                plot(Time, Voltage, xlab = "datetime", ylab = "Voltage", type = "l")
                plot(Time, Sub_metering_1, type="l", 
                     ylab="Energy sub metering", xlab="", col = "black")
                lines(Time, Sub_metering_2, col="red")
                lines(Time, Sub_metering_3, col="blue")
                legend("topright", col = c("black", "red", "blue"), 
                       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
                       lty = c(1,1), lwd = c(2.5, 2.5, 2.5), bty = "n", cex = .5)
                plot(Time, Global_reactive_power, xlab = "datetime", ylab = "Global_reactive_power",
                     type = "l", col = "black")        
        })
        dev.off()
        
}