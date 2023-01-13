#Importing data
data <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, stringsAsFactors = FALSE)

#Converting the 'Date' column to a date object
data$Date <- as.Date(data$Date, format="%d/%m/%Y")

#Filtering data 
selected_dataset <- data[data$Date %in% as.Date(c("2007-02-01", "2007-02-02")),]

#Changing the column "Global Active Power" to numeric
selected_dataset$Global_active_power <- as.numeric(selected_dataset$Global_active_power)

#Creating a histogram of the frequencies of Global Active Power
png(filename="plot1.png", width=480, height = 480 )

#change parameter for axis labels to horizontal to the axis
par(las=1)

hist(selected_dataset$Global_active_power, xlab = "Global Active Power (kilowatts)",
     ylab = "Frequency", main = "Global Active Power", col = "red")
dev.off()