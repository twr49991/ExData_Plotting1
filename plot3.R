plot3 <- function(){
  
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
  
  ## plot 3 - sub-metering plotted by type
  png("plot3.png", width=480, height=480)
  plot(hpcSub$Time, hpcSub$Sub_metering_1, type="l", 
       ylab="Energy sub metering", xlab="", col = "black")
  lines(hpcSub$Time, hpcSub$Sub_metering_2, col="red")
  lines(hpcSub$Time, hpcSub$Sub_metering_3, col="blue")
  legend("topright", col = c("black", "red", "blue"), 
         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
         lty = c(1,1), lwd = c(2.5, 2.5, 2.5))
  dev.off()  
  
}