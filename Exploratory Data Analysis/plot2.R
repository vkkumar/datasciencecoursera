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
plot(dfFebHPC$Global_active_power ~ dfFebHPC$dateTime,
     type = 'l',
     ylab="Global Active Power (kilowatts)",
     xlab="")

# Copy to a png file
dev.copy(png, file = "plot2.png", height = 480, width = 480)
dev.off()
