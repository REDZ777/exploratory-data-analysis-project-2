library("data.table")
path <- getwd()

download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile = paste(path, "dataFiles.zip", sep = "/"))
unzip(zipfile = "dataFiles.zip")

NEI <- data.table::as.data.table(x = readRDS(file = "summarySCC_PM25.rds")) #read data 
SCC <- data.table::as.data.table(x = readRDS(file = "Source_Classification_Code.rds"))
NEI[, Emissions := lapply(.SD, as.numeric), .SDcols = c("Emissions")]
totalNEI <- NEI[fips=='24510', lapply(.SD, sum, na.rm = TRUE) , .SDcols = c("Emissions") , by = year] #summing

barplot(totalNEI[, Emissions] , names = totalNEI[, year] , xlab="years", ylab=expression('total PM'[2.5]*' emission'),main=expression('Total PM'[2.5]*' in the Baltimore City, MD emissions at various years'))#plot saving to file
dev.copy(png, file="PLOT2.png", height=640, width=960)
dev.off()
