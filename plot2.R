#Importing data
data <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, stringsAsFactors = FALSE)

#Creating a full day/time column and converting it to POSIXct object
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
data$full_date_time <- paste0(data$Date, " " , data$Time)
data$full_date_time <- as_datetime(data$full_date_time)

#Filtering data
selected_dataset <- data[data$Date %in% as.Date(c("2007-02-01", "2007-02-02")),]

#Changing the column "Global Active Power" to numeric
selected_dataset$Global_active_power <- as.numeric(selected_dataset$Global_active_power)

#Creating a line plot of Global Active Power vs. full_date_time
png(filename="plot2.png", width=480, height = 480 )

with(selected_dataset, plot(Global_active_power~full_date_time, type='l',
                            xlab = "", ylab="Global Active Power (kilowatts)" ))

dev.off()