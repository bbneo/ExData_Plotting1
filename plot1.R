# 
# Exploratory Data Analsysis
# Project 1
# 
# Brad Banko
#

require("dplyr")
require("lubridate")

if (!file.exists("household_power_consumption.txt")) {
  download.file("https://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip")
  unzip("household_power_consumption.zip")
}

household <- read.table( "household_power_consumption.txt", header=T,
                         sep=";", dec=".",
                         na.strings = c("NA","?"),
                         colClasses = c(rep("character",2),rep("numeric",7)))

household2 <- household %>% mutate( Date = dmy(Date) )

household2 <- household2 %>%
  filter( Date %in% c(mdy("2/1/2007"),mdy("2/2/2007") )
  )

# create plot image file

png("plot1.png", width=480, height=480)

hist(household2$Global_active_power, col="red", main="Global Active Power",
ylab = "Frequency", xlab = "Global Active Power (kilowatts)",
xlim = range(0:6,2), ylim = c(0,1200))

dev.off()
