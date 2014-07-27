library(data.table)
library(ggplot2)

## Assumes the data files "summarySCC_PM25.rds" and "Source_Classification_Code.rds" are in the current working directory

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

filter1 <- grep("Combustion", SCC$SCC.Level.One)
filter2 <- grep("Coal", SCC$EI.Sector)
filter3 <- intersect(filter1, filter2)

scc_list = SCC[filter3,]

DT <- data.table(NEI)

answer <- match(DT$SCC, scc_list$SCC)

DT <- cbind(DT, answer)

graph_data <- as.data.frame(DT[answer != "NA",sum(Emissions, na.rm=TRUE), by = list(year)])

png("plot4.png")

qplot(year, V1, data = graph_data, geom = "line", xlab="Year", ylab="PM2.5 Emissions", main = "PM2.5 Emmissions in the US from Coal Combustion related Sources")

dev.off()
