#### Question 1 ####

library(data.table)
library(dplyr)

communities <- data.table::fread("http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv")
varNamesSplit <- strsplit(names(communities), "wgtp")
varNamesSplit[[123]]

#### Question 2 ####

GDPrank <- data.table::fread('http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv', 
                             skip=5, 
                             nrows=190, 
                             select = c(1, 2, 4, 5), 
                             col.names=c("CountryCode", "Rank", "Country", "GDP")
)

# Remove the commas using gsub
# Convert to integer after removing commas. 
# Take mean of GDP column
GDPrank[, mean(
    as.integer(
        gsub(
            pattern = ',', 
            replacement = '', 
            x = GDP)
        )
    )
        ]

#### Question 3 ####

grep("^United",GDPrank[, Country])

#### Question 4 ####

GDPrank <- data.table::fread('http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv', 
                             skip=5, 
                             nrows=190, 
                             select = c(1, 2, 4, 5), 
                             col.names=c("CountryCode", "Rank", "Country", "GDP")
)

eduDT <- data.table::fread('http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv')

mergedDT <- merge(GDPrank, eduDT, by = 'CountryCode')

mergedDT[grepl(pattern = "Fiscal year end: June 30;", mergedDT[, `Special Notes`]), .N]
