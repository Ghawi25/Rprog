#Importing data
data <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, stringsAsFactors = FALSE)

#Creating a full day/time column and converting it to POSIXct object
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
data$full_date_time <- paste0(data$Date, " " , data$Time)
data$full_date_time <- as_datetime(data$full_date_time)

#Filtering data
selected_dataset <- data[data$Date %in% as.Date(c("2007-02-01", "2007-02-02")),]

#Changing columns with energy submetering to numeric
energy_columns <- grepl("Sub_metering", colnames(selected_dataset), fixed=F)
selected_dataset[,energy_columns] <- lapply(selected_dataset[,energy_columns], function(x) {as.numeric(x)})

#Changing columns "Global Active Power", "Global Reactive Power", "Voltage" to numeric
power_columns <- c("Global_active_power", "Global_reactive_power")
selected_dataset[,power_columns] <- lapply(selected_dataset[,power_columns], function(x) {as.numeric(x)})
selected_dataset$Voltage <- as.numeric(selected_dataset$Voltage)

#Plotting
png(filename="plot4.png", width=480, height = 480 )

change par to accomodate 4 plots in 2 rows and 2 columns
par(mfrow=c(2,2))

#1) Global Active power vs. Weekday-Time
with(selected_dataset, plot(Global_active_power~full_date_time, type='l',
                            xlab = "", ylab="Global Active Power (kilowatts)" ))

#2) Voltage vs. Weekday-Time
with(selected_dataset, plot(Voltage~full_date_time, type='l',
                            xlab = "datetime"))

#3) Energy submetering vs. Weekday-time
with(selected_dataset, plot(Sub_metering_1~full_date_time, type='l',
                            col = "black",
                            xlab = "", ylab="Energy sub metering" ))

with(selected_dataset, lines(Sub_metering_2~full_date_time,
                             col = "red",
                             xlab = "", ylab="Energy sub metering" ))

with(selected_dataset, lines(Sub_metering_3~full_date_time,
                             col = "blue",
                             xlab = "", ylab="Energy sub metering" ))

#adding legend in the right top corner
legend("topright", legend=c(colnames(selected_dataset[,energy_columns])),
       bty= "n",
       col= c("black", "red", "blue"), lwd = 1, cex=0.8)

#4) Global re-ctive power vs. Weekday-Time
with(selected_dataset, plot(Global_reactive_power~full_date_time, type='l',
                            xlab = "datetime"))

dev.off()