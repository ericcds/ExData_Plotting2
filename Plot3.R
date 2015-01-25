require("sqldf")
require("ggplot2")

setwd("~/Documents/Coursera/ExData_Plotting2")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##summarise by year and type

NEI2 <- sqldf('select sum(Emissions) as TotalEmissions,year,type as Source from NEI where fips = 24510 group by year,type')

##plot total emissions by year for each collection point

png("Plot3.png",
    width=640,
    height=480)

attach(NEI2)
qplot(year,
      TotalEmissions,
      geom=c("point","smooth"),
      shape=Source,
      color=Source,
      xlab="Year",
      ylab="Total Emissions",
      main="Total Emissions by Year (1999-2008)")

dev.off()