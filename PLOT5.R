library(plyr) 
library(dplyr)
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds") #getting data
SCC <- readRDS("Source_Classification_Code.rds")
df <- subset(SCC, select = c("SCC", "Short.Name"))
NEI <- merge(NEI, df, by.x="SCC", by.y="SCC", all=TRUE)

PLOT5 <- subset(NEI, fips == "24510" & type =="ON-ROAD", c("Emissions", "year","type")) # plot
PLOT5 <- aggregate(Emissions ~ year, plot5, sum)
png(file = "PLOT5.png")
plot((Emissions / 1000) ~ year, data = PLOT5, type = "l",  xlab = "Year",ylab = "Total emissions (/1000)",main = "Baltimore City PM2.5 Motor Vehicle Emissions", xaxt="n")
axis(side=1, at=c("1999", "2002", "2005", "2008"))

dev.off()
