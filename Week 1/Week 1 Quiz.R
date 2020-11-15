library(data.table)
library(dplyr)

# Question 1

## Reading Data
df1 <- fread('Week 1/Data/getdata_data_ss06hid.csv', stringsAsFactors = T)
str(df1)
class(df1)

## Filtering and counting rows
df1[VAL == 24, ] %>% count() 

### Ans. 53 housing units in this survey were worth more than $1,000,000.

# Question 2

### Ans. Tidy data has one variable per column, whereas FES has: 
### gender, marital status and empoloyement status; three variables, which violets
### tidy data principle.

# Question 3

## Reading data
library(readxl)
dat <- read_xlsx('Week 1/Data/getdata_data_DATA.gov_NGAP.xlsx', 
                 range = 'G18:O23',
                 col_names = T)
glimpse(dat)

sum(dat$Zip*dat$Ext,na.rm=T)
### Ans. 36534720

# Question 4

## Reading Data
library(XML)

file <- "http://d396qusza40orc.cloudfront.net/getdata/data/restaurants.xml"
xmldata <- xmlParse(file, useInternal=T)
rootNode <- xmlRoot(xmldata)
xmlName(rootNode)

xpathSApply(rootNode, "//zipcode", xmlValue) -> zipcode
zipcode[zipcode==21231] %>% length()

### Ans. 127

# Question 5

### This is a tricky question. The answer is in the question and without any calculation it can be answered!

### Read carefully and see the options
### Using the 'data.table' package, which will deliver the fastest user time.