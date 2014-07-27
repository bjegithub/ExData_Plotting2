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
la_test <- DT[,]$fips == "06037"

balt_DT <- DT[balt_test,]
la_DT <- DT[la_test,]

balt_graph_data <- as.data.frame(balt_DT[answer != "NA", sum(Emissions, na.rm=TRUE), by = list(year)])
la_graph_data <- as.data.frame(la_DT[answer != "NA", sum(Emissions, na.rm=TRUE), by = list(year)])

balt_graph_data$City <- "Baltimore"
la_graph_data$City <- "Los Angeles County"

full_graph_data <- rbind(balt_graph_data, la_graph_data)

png("plot6.png")

##qplot(year, V1, data = balt_graph_data, geom = "line", xlab="Year", ylab="PM2.5 Emissions", main = "PM2.5 Emmissions from Motor Vehicles") + geom_line(col = "blue", data = la_graph_data)
qplot(year, V1, data = full_graph_data, color = City, geom = "line", xlab="Year", ylab="PM2.5 Emissions", main = "PM2.5 Emmissions from Motor Vehicles") + geom_line(col = "blue", data = la_graph_data)
 
dev.off()
