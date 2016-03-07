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
par(mfrow = c(1,1))

# Plot the data!
with(dfFebHPC, plot(Sub_metering_1 ~ dateTime, type = 'l', ylab = "Global Active Power (kilowatts)", xlab = "" ))
with(dfFebHPC, lines(Sub_metering_2 ~ dateTime, col = 'red'))
with(dfFebHPC, lines(Sub_metering_3 ~ dateTime, col = 'Blue'))

legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Copy to a png file
dev.copy(png, file = "plot3.png", height = 480, width = 480)
dev.off()
