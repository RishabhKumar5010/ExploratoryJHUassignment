# ExploratoryJHUassignment
Exploratory Analysis on pm2.5 emission levels recorded by EPA. Coursera Assignment<br><br><br>

Load the dataset as : 

```R
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
```


-----
## `PLOT 1`

> ### Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

`plot1.R` can be run in the same directory as the dataset to produce `plot1.png`

![plot1.png](plot1.png)

```R
yearemm <- tapply(NEI$Emissions,NEI$year,sum)

plot(x = names(yearemm),y = yearemm,type="l",col='red',xlab = "years",
     ylab = "Yealy Emissions",main="Year-wise Emission Trends",
     ylim = c(2e+06,8e+06),xlim = c(1999,2008),xaxt = 'n')
     
axis(side = 1, at = seq(1999,2008,3))
points(x = names(yearemm),y = yearemm,pch = 20,cex = 2)
```

We can see a **negative trend** in emission levels of pm2.5 across years 1999 - 2008.  
This is a good sign from an environmental perspective.

<br><br><br>

---
## `PLOT 2`

> ### Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? Use the base plotting system to make a plot answering this question.

`plot2.R` can be run in the same directory as the dataset to produce `plot2.png`

![plot2.png](plot2.png)

```R
yearemm <- with(NEI[NEI$fips=="24510",],tapply(Emissions,year,sum))

plot(x = names(yearemm),y = yearemm,type="l",col='red',xlab = "years",
     ylab = "Yealy Emissions   (tons)",main="Year-wise Emission Trends for Baltimore",
     xlim = c(1999,2008),xaxt = 'n')

axis(side = 1, at = seq(1999,2008,3))
points(x = names(yearemm),y = yearemm,pch = 20,cex = 2)
```

Except for a **rise in Emission levels in 2002-2005 period**, Baltimore shows an **overall negative trend** in Emission levels from years 1999 to 2008.  
This is a good sign from Environmental perspective.

