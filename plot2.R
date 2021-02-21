# read files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# summing emissions across years for Baltimore fips = "24510"

yearemm <- with(NEI[NEI$fips=="24510",],tapply(Emissions,year,sum))
plot(x = names(yearemm),y = yearemm,type="l",col='red',xlab = "years",
     ylab = "Yealy Emissions   (tons)",main="Year-wise Emission Trends for Baltimore",
     xlim = c(1999,2008),xaxt = 'n')
axis(side = 1, at = seq(1999,2008,3))
points(x = names(yearemm),y = yearemm,pch = 20,cex = 2)

# Except for a rise in Emission levels in 2002-2005 period,
# Baltimore shows an overall negative trend in Emission levels 
# from years 1999 to 2008

# generating png

dev.copy(png,"plot2.png")
dev.off()
