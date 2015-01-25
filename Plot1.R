require("sqldf")

setwd("~/Documents/Coursera/ExData_Plotting2")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##summarise by year

NEI1 <- sqldf('select sum(Emissions) as TotalEmissions,year from NEI group by year')

##plot total emissions over year

png("Plot1.png",
    width=480,
    height=480)

plot(NEI1$year,
     NEI1$TotalEmissions / 1000,
     type="l",
     col="black",
     lwd=2,
     xlab="Year",
     ylab="Total Emissions (thousands)",
     main="Total PM2.5 Emissions by Year (1999-2008)")

dev.off()