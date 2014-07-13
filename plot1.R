data = read.table("household_power_consumption.txt", sep=";", header=T, na.strings="?")

subset = data$Date %in% c("1/2/2007","2/2/2007")
Subdata = data[subset,]



###  Plot1  ###

hist(Subdata$Global_active_power, main="Global Active Power", col="red", xlab="Global Active Power (kilowatts)")
dev.copy(png, file="plot1.png")
dev.off()

