library(plyr)
library(ggplot2)
library(data.table)
library(grid)
library(scales)
library(httr)

setwd("~/Desktop/ExploratoryDataAnalysis/Project 02")

if (!file.exists("./data/NEI_data")) {unzip("./data/NEI_data.zip", exdir = "./data/NEI_data") #loading nei scc data frames
}
if (!"NEI" %in% ls()) {NEI <- readRDS("./data/NEI_data/summarySCC_PM25.rds")
}
if (!"SCC" %in% ls()) {SCC <- readRDS("./data/NEI_data/Source_Classification_Code.rds")
}
if (!"BaltimoreData" %in% ls()) {BaltimoreData <- NEI[NEI$fips == "24510", ]
}
if (!"BData" %in% ls()) {
  BData <- ddply(BaltimoreData, .(type, year), summarize, TotalEmissions = sum(Emissions))
}

png(filename = "PLOT3.png", width = 500, height = 480, units = "px") #plot
ggplot(BData, aes(year, TotalEmissions, colour = type)) + geom_line() + geom_point() + labs(title = expression('Total PM'[2.5]*" Emissions in Baltimore City, Maryland from 1999 to 2008"), x = "Year", y = expression('Total PM'[2.5]*" Emission (in tons)"))

dev.off()
