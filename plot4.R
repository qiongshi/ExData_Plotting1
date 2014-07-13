data = read.table("household_power_consumption.txt", sep=";", header=T, na.strings="?")

subset = data$Date %in% c("1/2/2007","2/2/2007")
Subdata = data[subset,]

Time.THU = sapply(strsplit(as.character(Subdata[Subdata$Date=="1/2/2007",2]), split=":"), 
	function(x)
	{
		x = as.numeric(x)
		x[1]+x[2]/60+x[3]/3600
	}
)

Time.FRI = sapply(strsplit(as.character(Subdata[Subdata$Date=="2/2/2007",2]), split=":"), 
	function(x)
	{
		x = as.numeric(x)
		x[1]+x[2]/60+x[3]/3600+24
	}
)

Time = c(Time.THU, Time.FRI)


###  Plot4  ###

par(mfrow=c(2,2))
plot(Time, Subdata$Global_active_power, type="l", xlab="", ylab="Global Active Power", xaxt="n")
axis(1, at=c(0,24,48), labels=c("Thu","Fri","Sat"))

plot(Time, Subdata$Voltage, type="l", xlab="datetime", ylab="Voltage", xaxt="n")
axis(1, at=c(0,24,48), labels=c("Thu","Fri","Sat"))

plot(Time, Subdata$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering", xaxt="n")
lines(Time, Subdata$Sub_metering_2, col="red")
lines(Time, Subdata$Sub_metering_3, col="blue")
axis(1, at=c(0,24,48), labels=c("Thu","Fri","Sat"))
legend("topright",lty=1, col=c("black","red","blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

plot(Time, Subdata$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reacitive_power", xaxt="n")
axis(1, at=c(0,24,48), labels=c("Thu","Fri","Sat"))

dev.copy(png, file="plot4.png")
dev.off()
