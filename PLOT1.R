library("data.table")
path <- getwd()
download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile = paste(path, "dataFiles.zip", sep = "/"))

unzip(zipfile = "dataFiles.zip")

NEI <- data.table::as.data.table(x = readRDS(file = "summarySCC_PM25.rds")) #read data
NEI[, Emissions := lapply(.SD, as.numeric), .SDcols = c("Emissions")]
SCC <- data.table::as.data.table(x = readRDS(file = "Source_Classification_Code.rds"))

totalNEI <- NEI[, lapply(.SD, sum, na.rm = TRUE), .SDcols = c("Emissions"), by = year] # summing 

barplot(totalNEI[, Emissions], names = totalNEI[, year], xlab = "Years", ylab = "total PM'[2.5]*' emission", main = "Total PM'[2.5]*' emissions at various years") #plot
dev.copy(png, file="PLOT1.png", height=640, width=640)
dev.off()





