plot1<-function() {
  ## plot_oildollar1.R - R script to plot frequency of 
  ## various values of the NZ dollar expressed in US cents.
  
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
  
  hist(electric_analysis$Global_reactive_power,col="red",
       main="Global Active Power", 
       xlab="Global Active Power (kilowatts)")
  dev.copy(png,file="plot1.png")
  dev.off()
}