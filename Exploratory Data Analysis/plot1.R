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

# Convert from string to numeric
dfFebHPC$Global_active_power = as.numeric(dfFebHPC$Global_active_power)

# Reset mfrow settings (to remove any prior settings)
par(mfrow = c(1,1))

# Plot the histogram
hist(dfFebHPC$Global_active_power,
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)",
     ylab = "Frequency",
     col = "red")

# Copy to a png file
dev.copy(png, file = "plot1.png", height = 480, width = 480)
dev.off()
