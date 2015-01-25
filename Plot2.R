require("sqldf")

setwd("~/Documents/Coursera/ExData_Plotting2")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##summarise by year

NEI1 <- sqldf('select sum(Emissions) as TotalEmissions,year from NEI where fips = 24510 group by year')

##plot total emissions for Baltimore City over year

png("Plot2.png",
    width=480,
    height=480)

plot(NEI1$year,
     NEI1$TotalEmissions,
     type="l",
     col="black",
     lwd=2,
     xlab="Year",
     ylab="Total Emissions",
     main="Total PM2.5 Emissions in Baltimore by Year (1999-2008)")

dev.off()