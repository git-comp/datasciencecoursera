# Read data to powerDT
powerDT <- data.table::fread(input = "household_power_consumption.txt", na.strings="?")

# Adjust date format
powerDT[, Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]

# Restrict to period of 2007-02-01 and 2007-02-02
powerDT <- powerDT[(Date >= "2007-02-01") & (Date <= "2007-02-02")]

# Add merged date and time 
powerDT[, dateTime := as.POSIXct(paste(Date, Time), format = "%Y-%m-%d %H:%M:%S")]

png("plot3.png", width=480, height=480)

# Plot
plot(powerDT[,dateTime], powerDT[,Sub_metering_1], type="l", xlab="", ylab="Energy sub metering")
lines(powerDT[,dateTime], powerDT[,Sub_metering_2],col="red")
lines(powerDT[,dateTime], powerDT[,Sub_metering_3],col="blue")
legend("topright", col=c("black","red","blue"), c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"),lty=c(1,1), lwd=c(1,1))
     
# Close png after writing 
dev.off()