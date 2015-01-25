require("sqldf")
require("ggplot2")

setwd("~/Documents/Coursera/ExData_Plotting2")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## subset SCC to get only vehicle related sources
## looks in the SCC.Level.2 column for "Vehicle"

VehicleSCC <- SCC[grep("Vehicle", SCC$SCC.Level.Two, ignore.case=TRUE),]

##join to filter, and summarise by year and type

NEI2 <- sqldf('select sum(Emissions) as TotalEmissions,year from NEI inner join VehicleSCC on VehicleSCC.SCC = NEI.SCC where NEI.fips = 24510 group by year')

##plot total emissions by year for motor vehicle sources

png("Plot5.png",
    width=480,
    height=480)

attach(NEI2)
qplot(year,
      TotalEmissions,
      geom=c("point","smooth"),
      xlab="Year",
      ylab="Total Emissions",
      main="Total Emissions from Vehicles in Baltimore by Year (1999-2008)")

dev.off()