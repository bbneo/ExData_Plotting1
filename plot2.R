# 
# Exploratory Data Analsysis
# Plot 2
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

png("plot2.png", width=480, height=480)

with(household2, plot( Date2, Global_active_power, type="l",
xlab="", ylab="Global Active Power (kilowatts)"))

dev.off()
