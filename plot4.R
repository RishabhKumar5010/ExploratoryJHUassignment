# read files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# summing emissions across years
scc_coal <- SCC$SCC[grep("[cC][oO][aA][lL]",SCC$Short.Name)]
coal_type <- with(NEI[NEI$SCC %in% scc_coal,],
                tapply(Emissions,list(year,type),sum))

df <- as.data.frame.table(coal_type)
names(df) <-  c("year","type","Emissions")
df$year <- as.numeric(as.character(df$year))

gg<-ggplot(df,aes(year,Emissions,col=type))+
    geom_line()+geom_point()
gg+xlab("Year")+ylab("Emissions  (tons)")+
    labs(title = "Year-wise Emissions from coal related sources")+
    labs(color = "Source Types")+theme_bw()+
    scale_x_continuous(breaks = unique(df$year),
                       labels = unique(df$year))

# emission through POINT coal sources have a decreasing trend whereas, 
# emission though NONPOINT coal sources have almost stayed the same

# generating png
dev.copy(png,"plot4.png")
dev.off()