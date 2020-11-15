#### Question 1 ####

download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv'
              , 'Week 3/ACS.csv', method='curl' )

# Read data into data.frame
ACS <- read.csv('Week 3/ACS.csv')

agricultureLogical <- ACS$ACR == 3 & ACS$AGS == 6
head(which(agricultureLogical), 3)

#### Question 2 ####

# install.packages('jpeg')
library(jpeg)

download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg'
              ,'Week 3/jeff.jpg' , mode='wb' )

# Read the JPEG image
picture <- jpeg::readJPEG('Week 3/jeff.jpg', native=TRUE)

# Get Sample Quantiles corressponding to given prob
quantile(picture, probs = c(0.3, 0.8) )


#### Question 3 ####

# install.packages("data.table)
library("data.table")

# Download and read FGDP data into data.table
FGDP <- data.table::fread(
    'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv',
    skip=4, nrows = 190,
    select = c(1, 2, 4, 5),
    col.names=c("CountryCode", "Rank", "Economy", "Total")
)

# Download and read FEDSTATS data into data.table
FEDSTATS_Country <- data.table::fread(
    'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv')

mergedDT <- merge(FGDP, FEDSTATS_Country, by = 'CountryCode')

nrow(mergedDT)

mergedDT[order(-Rank)][13,.(Economy)]

#### Question 5 ####

library('dplyr')

breaks <- quantile(mergedDT[, Rank], 
                   probs = seq(0, 1, 0.2), 
                   na.rm = TRUE)

mergedDT$quantileGDP <- cut(mergedDT[,Rank], breaks = breaks)
mergedDT[`Income Group` == "Lower middle income", .N, 
         by = c("Income Group", "quantileGDP")]
