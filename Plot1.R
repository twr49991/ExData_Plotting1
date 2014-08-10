plot1 <- function(){
        
        ## Set up the data
        setAs("character","makeDate", function(from) as.Date(from, format="%d/%m/%Y") )
        hpc <- read.table("household_power_consumption.txt", sep=";",
                          nrows=2500000, header=TRUE, stringsAsFactors=FALSE, 
                          colClasses = c("makeDate", "character", rep("numeric", 7)), 
                          na.strings = "?")
        
        ##subset to get rows for the two days 
        hpcSub <- subset(hpc, Date == '2007-02-01' | Date == '2007-02-02') 
        
        ##Combine date and time, convert to date/time value, 
        ## and replace Time column in data frame to make plotting easier
        hpcSub$Time <- strptime(paste(hpcSub$Date, hpcSub$Time), "%Y-%m-%d %H:%M:%S")
        
        ## create plot 1 - histogram - and save as png
        png("plot1.png", width=480, height=480)
        hist(hpcSub$Global_active_power, main="Global Active Power", col = "red",
             xlab = "Global Active Power (kilowatts)", ylab = "Frequency")
        dev.off()  
}