if (!file.exists("household_power_consumption.txt")) {unzip(zipfile="exdata_data_household_power_consumption.zip")}

power <- read.table("household_power_consumption.txt",header=TRUE,sep=";",stringsAsFactors = FALSE)

#convert date into date class
power$Date <- as.Date(power$Date,"%d/%m/%Y")

#subset to only 2 days
powers <- subset(power,power$Date=="2007-02-01"|power$Date=="2007-02-02")

#convert global power to numeric
powers$Global_active_power <- as.numeric(as.character(powers$Global_active_power))

#create date time object
powers$newDate <- paste(powers$Date,powers$Time)
powers$newDate2 <- as.POSIXct(powers$newDate, format="%Y-%m-%d %H:%M:%S")

#open png and set parameters
png(filename = "plot4.png",width=480,height=480)
par(mfrow = c(2,2), mar = c(4,4,1,1))

#create first plot
plot(x=powers$newDate2,y=powers$Global_active_power,type="l",ylab="Global Active Power",xlab="")

#get voltage and create 2nd plot
voltn <- as.numeric(powers$Voltage)
plot(x=powers$newDate2,y=voltn,type="l",ylab="Voltage",xlab="datetime")

#get numeric metering data
sub1 <- as.numeric(powers$Sub_metering_1)
sub2 <- as.numeric(powers$Sub_metering_2)
sub3 <- as.numeric(powers$Sub_metering_3)

#create third plot
plot(x=powers$newDate2,y=sub1,type="l",col="black",ylab="Energy sub metering", xlab="")
lines(x=powers$newDate2,y=sub2,type="l",col="red")
lines(x=powers$newDate2,y=sub3,type="l",col="blue")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=1,lwd=1.5, 
       col = c("black","red","blue"), bty="n" )

#get global reactive power and create 4th plot
grp <- as.numeric(powers$Global_reactive_power)
plot(x=powers$newDate2,y=grp,type="l",ylab="Global_reactive_power",xlab="datetime")


dev.off()

rm(power)
rm(powers)








