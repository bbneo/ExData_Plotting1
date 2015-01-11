# 
# Exploratory Data Analsysis
# Plot 4
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

household2 <- household %>% mutate( Date2 = dmy_hms(paste(Date,Time)),
                                    Date = dmy(Date)) %>%   select(-Time)

household2 <- household2 %>%
  filter( Date %in% c(mdy("2/1/2007"),mdy("2/2/2007") )
  )

household2 <- household2 %>% mutate(Wkday=wday(Date2,label=T))

# create plot image file

png("plot4.png", width=480, height=480)

par(mfcol=c(2,2), cex = 0.6)

with(household2, plot( Date2, Global_active_power, type="l",
                       xlab="", ylab="Global Active Power (kilowatts)"))


with(household2, plot( Date2, Sub_metering_1, type="n",
                       xlab="", ylab="Energy sub metering"))

with(household2, lines( Date2, Sub_metering_1, type="l",col="black"))
with(household2, lines( Date2, Sub_metering_2, type="l",col="red"))
with(household2, lines( Date2, Sub_metering_3, type="l",col="blue"))

legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
       , lty=1, col=c("black","red","blue"), bty="n", )

with(household2, plot( Date2, Voltage, type="l",
                       xlab="datetime", ylab="Voltage"))

with(household2, plot( Date2, Global_reactive_power, type="l") )

dev.off()
