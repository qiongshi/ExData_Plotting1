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

###  Plot2  ###

plot(Time, Subdata$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)", xaxt="n")
axis(1, at=c(0,24,48), labels=c("Thu","Fri","Sat"))
dev.copy(png, file="plot2.png")
dev.off()

