library(data.table)
library(ggplot2)

## Assumes the data files "summarySCC_PM25.rds" and "Source_Classification_Code.rds" are in the current working directory

NEI <- readRDS("summarySCC_PM25.rds")

DT <- data.table(NEI)

graph_data <- as.data.frame(DT[fips == "24510",sum(Emissions, na.rm=TRUE), by = list(year, type)])

png("plot3.png")

qplot(year, V1, data = graph_data, color = type, geom = "line", xlab="Year", ylab="PM2.5 Emissions", main = "PM2.5 Emmissions for Baltimore City, MD by Type")

dev.off()
