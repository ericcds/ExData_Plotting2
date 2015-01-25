require("sqldf")
require("ggplot2")

setwd("~/Documents/Coursera/ExData_Plotting2")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## subset SCC to get only vehicle related sources
## looks in the SCC.Level.2 column for "Vehicle"

VehicleSCC <- SCC[grep("Vehicle", SCC$SCC.Level.Two, ignore.case=TRUE),]

##join to filter, and summarise by year and type

NEI2 <- sqldf('select
                  sum(Emissions) as TotalEmissions,
                  year,
                  case when fips="24510" then "Baltimore City"
                       when fips="06037" then "LA County"
                       else "NA"
                  end as Location
               from NEI
               inner join VehicleSCC on VehicleSCC.SCC = NEI.SCC
               where NEI.fips = "24510"
                  or NEI.fips = "06037"
               group by year, Location')

##plot total emissions by year for motor vehicle sources in Baltimore City vs. LA County

png("Plot6.png",
    width=640,
    height=480)

attach(NEI2)
qplot(year,
      TotalEmissions,
      geom=c("point","smooth"),
      color=Location,
      shape=Location,
      xlab="Year",
      ylab="Total Emissions",
      main="Total Emissions from Vehicles by Year (1999-2008)")

dev.off()