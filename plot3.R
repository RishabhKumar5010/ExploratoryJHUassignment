# read files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# summing emissions across years for Baltimore fips = "24510"
baltimore_year_type <- with(NEI[NEI$fips=="24510",],
                            tapply(Emissions,list(year,type),sum))
df <- as.data.frame.table(baltimore_year_type)
names(df) <-  c("year","type","Emissions")
df$year <- as.numeric(as.character(df$year))

gg<-ggplot(df,aes(year,Emissions,col=type))+
    geom_line()+geom_point()
gg+xlab("Year")+ylab("Emissions  (tons)")+
    labs(title = "Year-wise Emissions of Baltimore for all types of source")+
    labs(color = "Source Types")+theme_bw()+
    scale_x_continuous(breaks = unique(df$year),
                       labels = unique(df$year))

# except for POINT source type emissions, which had a spike in 2005
# but has overall stayed the same, emission through other sources have
# a decreasing trend.

# generating png
dev.copy(png,"plot3.png")
dev.off()
