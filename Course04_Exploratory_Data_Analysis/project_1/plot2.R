# Read data to powerDT
powerDT <- data.table::fread(input = "household_power_consumption.txt", na.strings="?")

# Adjust date format
powerDT[, Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]

# Restrict to period of 2007-02-01 and 2007-02-02
powerDT <- powerDT[(Date >= "2007-02-01") & (Date <= "2007-02-02")]

# Add merged date and time 
powerDT[, dateTime := as.POSIXct(paste(Date, Time), format = "%Y-%m-%d %H:%M:%S")]

# 
png("plot2.png", width=480, height=480)

# Plot
plot(x=powerDT[,dateTime], y=powerDT[,Global_active_power], type="l", xlab="", ylab="Global Active Power (kW)")

# Close png after writing 
dev.off()