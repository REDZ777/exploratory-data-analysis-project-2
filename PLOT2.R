library(plyr) 
library(dplyr)
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

df <- subset(SCC, select = c("SCC", "Short.Name")) # data chart
NEI <- merge(NEI, df, by.x="SCC", by.y="SCC", all=TRUE)

PLOT2 <- subset(NEI, fips == "24510", c("Emissions", "year","type")) #plot chart
PLOT2 <- aggregate(Emissions ~ year, PLOT2, sum)
png(file = "PLOT2.png")
plot((Emissions / 1000) ~ year, data = PLOT2, type = "l", 
     xlab = "Year",
     ylab = "Total emissions (/1000)",
     main = "Baltimore City PM2.5 Emissions", xaxt="n")
axis(side=1, at=c("1999", "2002", "2005", "2008"))

dev.off()
