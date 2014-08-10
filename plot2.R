plot2 <- function(){
  
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
  
  ## plot 2 - plot of usage by time of day
  png("plot2.png", width=480, height=480)
  plot(hpcSub$Time, hpcSub$Global_active_power, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  dev.off()  

}