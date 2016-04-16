if (!file.exists("household_power_consumption.txt")) {unzip(zipfile="exdata_data_household_power_consumption.zip")}

power <- read.table("household_power_consumption.txt",header=TRUE,sep=";",stringsAsFactors = FALSE)

#convert date into date class
power$Date <- as.Date(power$Date,"%d/%m/%Y")

#subset to only 2 days
powers <- subset(power,power$Date=="2007-02-01"|power$Date=="2007-02-02")

#convert global power to numeric
powers$Global_active_power <- as.numeric(powers$Global_active_power)

#create date time object
powers$newDate <- paste(powers$Date,powers$Time)
powers$newDate2 <- as.POSIXct(powers$newDate, format="%Y-%m-%d %H:%M:%S")

#create plot
png(filename = "plot2.png",width=480,height=480)
par(mfrow = c(1,1))
plot(x=powers$newDate2,y=powers$Global_active_power,type="l",ylab="Global Active Power (kilowatts)",xlab="")

dev.off()

rm(power)
rm(powers)