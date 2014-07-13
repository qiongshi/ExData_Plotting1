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


###  Plot3  ###

plot(Time, Subdata$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering", xaxt="n")
lines(Time, Subdata$Sub_metering_2, col="red")
lines(Time, Subdata$Sub_metering_3, col="blue")
axis(1, at=c(0,24,48), labels=c("Thu","Fri","Sat"))
legend("topright",lty=1, col=c("black","red","blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.copy(png, file="plot3.png")
dev.off()
