# read files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

scc_motor_veh <- SCC$SCC[grepl("[Vv]ehicle", SCC$SCC.Level.Two)]
b_laNEI <- NEI[NEI$fips=="24510" | NEI$fips=="06037",]
motor_fips <- with(b_laNEI[b_laNEI$SCC %in% scc_motor_veh,],
                   tapply(Emissions,list(year,fips),sum))


df <- as.data.frame.table(motor_fips)
names(df) <-  c("year","type","Emissions")
df$year <- as.numeric(as.character(df$year))

gg<-ggplot(df,aes(year,Emissions,col=type))+
    geom_line()+geom_point()
gg+xlab("Year")+ylab("Emissions  (tons)")+
    labs(title = paste("Year-wise Emissions from motor vehicle sources",
                     "(LA vs Baltimore)"))+
    labs(color = "Source Types")+theme_bw()+
    scale_x_continuous(breaks = unique(df$year),
                       labels = unique(df$year))+
    scale_color_discrete(labels = c("LA","Baltimore"))

# in Baltimore, emission from motor vehicle sources have a negative trend
# while in LA the emission from motor vehicle has a overall positive trend.
# Also Baltimore has see very less changes in emission rates from motor vehicle
# sources as compared to LA

# generating png
dev.copy(png,"plot6.png")
dev.off()
