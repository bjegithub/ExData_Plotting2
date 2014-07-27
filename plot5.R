library(data.table)
library(ggplot2)

## Assumes the data files "summarySCC_PM25.rds" and "Source_Classification_Code.rds" are in the current working directory

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

filter1 <- grep("Highway Vehicles", SCC$SCC.Level.Two)

scc_list = SCC[filter1,]

DT <- data.table(NEI)

answer <- match(DT$SCC, scc_list$SCC)

DT <- cbind(DT, answer)

balt_test <- DT[,]$fips == "24510"
DT <- DT[balt_test,]

graph_data <- as.data.frame(DT[answer != "NA", sum(Emissions, na.rm=TRUE), by = list(year)])

png("plot5.png")

qplot(year, V1, data = graph_data, geom = "line", xlab="Year", ylab="PM2.5 Emissions", main = "PM2.5 Emmissions in Baltimore, MD from Motor Vehicles")

dev.off()
