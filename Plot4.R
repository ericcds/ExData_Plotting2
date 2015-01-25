require("sqldf")
require("ggplot2")

setwd("~/Documents/Coursera/ExData_Plotting2")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## subset SCC to get only coal-related combustion sources
## based on discussions in the class forums on defining coal combustion sources
## looks in the Short.Name column for "Comb" and "Coal" or "Lignite"

CoalSCC <- SCC[grep("comb.+(coal|lignite)", SCC$Short.Name, ignore.case=TRUE),]

##join to filter, and summarise by year and type

NEI2 <- sqldf('select sum(Emissions) as TotalEmissions,year from NEI inner join CoalSCC on CoalSCC.SCC = NEI.SCC group by year')

##plot total emissions by year for Coal-related combustion sources

png("Plot4.png",
    width=480,
    height=480)

attach(NEI2)
qplot(year,
      TotalEmissions,
      geom=c("point","smooth"),
      xlab="Year",
      ylab="Total Emissions",
      main="Total Emissions from Coal Combustion by Year (1999-2008)")

dev.off()