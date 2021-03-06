# ExploratoryJHUassignment
Exploratory Analysis on pm2.5 emission levels recorded by EPA. Coursera Assignment<br><br><br>

Dataset : [Download](https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip) [~30MB]

*Individual R files in this repo can be run standalone within the dataset directory*  
*However if testing the code from here, do include the following dataset loading commands*

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
This is a good sign from an environmental perspective.

<br><br><br>

---
## `PLOT 3`

> ### Of the four types of sources indicated by the type(point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.
 
`plot3.R` can be run in the same directory as the dataset to produce `plot3.png`

![plot3.png](plot3.png)

```R
baltimore_year_type <- with(NEI[NEI$fips=="24510",],
                            tapply(Emissions,list(year,type),sum))
                            
# altering the data further, cause ggplot is too picky about the data format.
df <- as.data.frame.table(baltimore_year_type)
names(df) <-  c("year","type","Emissions")
df$year <- as.numeric(as.character(df$year))

# skeleton of the plot
gg<-ggplot(df,aes(year,Emissions,col=type))+
    geom_line()+geom_point()

# tweaking the plot
gg+xlab("Year")+ylab("Emissions  (tons)")+
    labs(title = "Year-wise Emissions of Baltimore for all types of source")+
    labs(color = "Source Types")+theme_bw()+  # changing legend label and overall theme
    scale_x_continuous(breaks = unique(df$year),
                       labels = unique(df$year))
```

Except for **POINT source type emissions**, which **had a spike in 2005** but has overall experienced a slight increase,  
while **emission** through **other sources have a decreasing trend**.  
This is a good sign from an environmental perspective.

<br><br><br>

---
## `PLOT 4`

> ### Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?
 
`plot4.R` can be run in the same directory as the dataset to produce `plot4.png`

![plot4.png](plot4.png)


```R
#filtering SCC containing coal in their Short.Name 
scc_coal <- SCC$SCC[grep("[cC][oO][aA][lL]",SCC$Short.Name)]

coal_type <- with(NEI[NEI$SCC %in% scc_coal,],
                tapply(Emissions,list(year,type),sum))

# altering the data to make it suitable to plot
df <- as.data.frame.table(coal_type)
names(df) <-  c("year","type","Emissions")
df$year <- as.numeric(as.character(df$year))

# skeleton of the plot
gg<-ggplot(df,aes(year,Emissions,col=type))+
    geom_line()+geom_point()
    
# tweaking the plot    
gg+xlab("Year")+ylab("Emissions  (tons)")+
    labs(title = "Year-wise Emissions from coal related sources")+
    labs(color = "Source Types")+theme_bw()+
    scale_x_continuous(breaks = unique(df$year),
                       labels = unique(df$year))
```

Emission through **POINT coal sources** have a **decreasing trend** whereas, emission though **NONPOINT coal sources** have **almost stayed the same**.

<br><br><br>

---
## `PLOT 5`

> ### How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
 
`plot5.R` can be run in the same directory as the dataset to produce `plot5.png`

![plot5.png](plot5.png)


```R
scc_motor_veh <- SCC$SCC[grepl("[Vv]ehicle", SCC$SCC.Level.Two)]

bNEI <- NEI[NEI$fips==24510,]

motor_type <- with(bNEI[bNEI$SCC %in% scc_motor_veh,],
                  tapply(Emissions,list(year,type),sum))

# processing data to make it plottable
df <- as.data.frame.table(motor_type)
names(df) <-  c("year","type","Emissions")
df$year <- as.numeric(as.character(df$year))

# skeleton on the plot
gg<-ggplot(df,aes(year,Emissions,col=type))+
    geom_line()+geom_point()

# tweaking the plot
gg+xlab("Year")+ylab("Emissions  (tons)")+
    labs(title = "Year-wise Emissions from motor vehicle sources")+
    labs(color = "Source Types")+theme_bw()+
    scale_x_continuous(breaks = unique(df$year),
                       labels = unique(df$year))

```

We can see that in **Baltimore**, **emission from motor vehicle sources** have a **negative trend**.

<br><br><br>

---
## `PLOT 6`

> ### Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037"). Which city has seen greater changes over time in motor vehicle emissions?

`plot6.R` can be run in the same directory as the dataset to produce `plot6.png`

![plot6.png](plot6.png)


```R
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
```

In **Baltimore**, emission from motor vehicle sources have a **negative trend**
while in **LA** the emission from motor vehicle has a **overall positive trend**.
Also **Baltimore** has see **very less changes** in emission rates from motor vehicle
sources **as compared to LA**

