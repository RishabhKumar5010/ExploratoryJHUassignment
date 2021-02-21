# read files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# summing emissions across years

yearemm <- tapply(NEI$Emissions,NEI$year,sum)
plot(x = names(yearemm),y = yearemm,type="l",col='red',xlab = "years",
     ylab = "Yealy Emissions   (tons)",main="Year-wise Emission Trends",
     ylim = c(2e+06,8e+06),xlim = c(1999,2008),xaxt = 'n')
axis(side = 1, at = seq(1999,2008,3))
points(x = names(yearemm),y = yearemm,pch = 20,cex = 2)

# We see a negative trend in Emission levels from years 1999 to 2008

# generating png

dev.copy(png,"plot1.png")
dev.off()
