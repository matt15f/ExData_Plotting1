#read dataset
if (!file.exists("household_power_consumption.txt")) {unzip(zipfile="exdata_data_household_power_consumption.zip")}

power <- read.table("household_power_consumption.txt",header=TRUE,sep=";",stringsAsFactors = FALSE)

#convert date into date class
power$Date <- as.Date(power$Date,"%d/%m/%Y")

#subset to only 2 days
powers <- subset(power,power$Date=="2007-02-01"|power$Date=="2007-02-02")

#convert global power to numeric
powers$Global_active_power <- as.numeric(powers$Global_active_power)

#create histogram 
png(filename = "plot1.png",width=480,height=480)
par(mfrow = c(1,1))
hist(powers$Global_active_power,col=10,main ="Global Active Power",xlab = "Global Active Power (in kilowatts)")

dev.off()

rm(power)
rm(powers)