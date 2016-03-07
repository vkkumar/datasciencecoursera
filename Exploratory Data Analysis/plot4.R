# Load the dataset
dfHPC = read.table("~/Dropbox/Coursera/Exploratory Data Analysis/household_power_consumption.txt",
                   sep=";", stringsAsFactors=FALSE,
                   header = TRUE)
head(dfHPC)

# Convert the Date string to class Date
dfHPC$Date = as.Date(dfHPC$Date, format = "%d/%m/%Y")
range(dfHPC$Date)

# Create a criterion for subsetting
febDates = dfHPC$Date >= "2007-02-01" & dfHPC$Date <= "2007-02-02"
dfHPC$febDates = febDates

# Subset the dateframe
dfFebHPC = subset(dfHPC, febDates == TRUE)
head(dfFebHPC)

# Combime Date and Time to create a datetime class 
dateTime = paste(dfFebHPC$Date, dfFebHPC$Time)
dfFebHPC$dateTime = as.POSIXct(dateTime)

# Reset mfrow settings (to remove any prior settings)
par(mfrow = c(2,2))

# Plot the top left data!
plot(dfFebHPC$Global_active_power ~ dfFebHPC$dateTime,
     type = 'l',
     ylab="Global Active Power",
     xlab="")

# Plot the top right data!
plot(dfFebHPC$Voltage ~ dfFebHPC$dateTime,
     type = 'l',
     ylab="Voltage",
     xlab="datetime")

# Plot the bottom left data!
with(dfFebHPC, plot(Sub_metering_1 ~ dateTime, type = 'l', ylab = "Energy sub metering", xlab = "" ))
with(dfFebHPC, lines(Sub_metering_2 ~ dateTime, col = 'red'))
with(dfFebHPC, lines(Sub_metering_3 ~ dateTime, col = 'Blue'))

legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = "n")

# Plot the bottom right data!
plot(dfFebHPC$Global_reactive_power ~ dfFebHPC$dateTime,
     type = 'l',
     ylab = 'Global_reactive_power',
     xlab="datetime")

# Copy to a png file
dev.copy(png, file = "plot4.png", height = 480, width = 480)
dev.off()
