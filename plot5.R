# read files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

scc_motor_veh <- SCC$SCC[grepl("[Vv]ehicle", SCC$SCC.Level.Two)]
bNEI <- NEI[NEI$fips==24510,]
motor_type <- with(bNEI[bNEI$SCC %in% scc_motor_veh,],
                  tapply(Emissions,list(year,type),sum))


df <- as.data.frame.table(motor_type)
names(df) <-  c("year","type","Emissions")
df$year <- as.numeric(as.character(df$year))

gg<-ggplot(df,aes(year,Emissions,col=type))+
    geom_line()+geom_point()
gg+xlab("Year")+ylab("Emissions  (tons)")+
    labs(title = "Year-wise Emissions from motor vehicle sources")+
    labs(color = "Source Types")+theme_bw()+
    scale_x_continuous(breaks = unique(df$year),
                       labels = unique(df$year))

# in Baltimore, emission from motor vehicle sources have a negative trend

# generating png
dev.copy(png,"plot5.png")
dev.off()
