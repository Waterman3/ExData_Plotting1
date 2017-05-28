plot4<-function() {
  ## plot4.R - R script to plot for a 
  ##household from 1/2/2007 to 2/2/2007:
  ##1. Global active power consumption;
  ##2. Voltage;
  ##3. Elecricity consumption at various parts of the
  ##   household; and
  ##4. Global reactive power.
  ## The household is one whose electricity consumption
  ## data over a period of four years is stored in the University of California Irvine Machine 
  ## Learning Repository.
  
  ## Author: Warwick Taylor
  ## Date 9 November 2015
  ## Updated 28 May 2015 (Warwick) - altered comments and added library(data.table).
  
  library(data.table)
  
  ## Set up plot of 2 rows by 2 columns of graphs.
  
  par(mfrow=c(2,2))
  
  ## Download file.
  
  if(!exists("electric_analysis"))
  {
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                  destfile="electric.zip")
    
    ## Unzip file and read data into a data table.
    
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
 ## Plot Global active power
 
  with(electro_analysis,plot(Global_active_power ~ datetime,
                             type="l",
                             xlab=" ",
                             ylab="Global Active Power"))
  ## Plot Voltage.
  
 with(electro_analysis,plot(Voltage ~ datetime,
                            type="l",
                            xlab=" ",
                            ylab="Voltage"))
  # Now plot electricity consumption in various parts
  # of the household.
 
 with(electro_analysis,plot(Sub_metering_1 ~ datetime
                            ,type="l", 
                            xlab=" ", 
                            ylab="Energy sub metering"))
 with(electro_analysis,lines(Sub_metering_2 ~ datetime, col="red"))                  
 with(electro_analysis,lines(Sub_metering_3 ~ datetime,col="blue"))
 legend("topright",legend=c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"),
        fill=c("black","red","blue"),cex=0.5)
 ## Plot Global reactive power
 
 with(electro_analysis,plot(Global_reactive_power ~ datetime,
                            ,type="l",
                            xlab=" ",
                            ylab="Global Reactive Power"))
 
  dev.copy(png,"plot4.png")
  dev.off()
}