plot2<-
function() {
  ## plot2.R - R script to household electricity consumption
  ## on 1/2/2007 and 2/2/2007 at 1 minute intervals.
  
  if(!exists("electric_analysis"))
  {
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                  destfile="electric.zip")
    unzip("electric.zip")
    electric_analysis<-fread("household_power_consumption.txt",
                             colClasses=c("character",
                                          "character",
                                          "numeric","numeric",
                                          "numeric","numeric",
                                          "numeric","numeric",
                                          "numeric"), sep=";", 
                             sep2=":",
                             header=TRUE,
                             na.strings=c("?",""),
                             skip=grep("31/1/2007;23:59.00",readLines("household_power_consumption.txt")),
                             nrow=2880)
    electric_names<-c("Date","Time",
                      "Global_active_power",
                      "Global_reactive_power",
                      "Voltage","Global_intensity",
                      "Sub_metering_1",
                      "Sub_metering_2",
                      "Sub_metering_3")
    names(electric_analysis)<-electric_names
  }
  datetime<-strptime(paste(electric_analysis$Date,electric_analysis$Time),
                     format="%d/%m/%Y %H:%M:%S")
  electro_analysis<-cbind(electric_analysis,datetime)
  with(electro_analysis,plot(Global_active_power ~ datetime,
                             col="green",type="l",
                             ylab="Global Active Power (kilowatts)"))  
  dev.copy(png,file="plot2.png")
  dev.off()
}