library(data.table)

## Assumes the data files "summarySCC_PM25.rds" and "Source_Classification_Code.rds" are in the current working directory

NEI <- readRDS("summarySCC_PM25.rds")

DT <- data.table(NEI)

graph_data <- as.data.frame(DT[fips == "24510",sum(Emissions, na.rm=TRUE), by = year])

png("plot2.png")

plot(graph_data$year, graph_data$V1, type = "l", main = "PM2.5 Emmissions for Baltimore City, MD", xlab = "Year", ylab = "PM2.5 Emissions")

dev.off()