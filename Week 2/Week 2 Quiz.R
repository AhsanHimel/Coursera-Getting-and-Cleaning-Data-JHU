
library(jsonlite)
library(httpuv)
library(httr)

#### Question 1 ####

## Copy and paste the code from below in the console.
## Running from script doesn't work ...

# Can be github, linkedin etc depending on application
oauth_endpoints("github")

# Change based on your appname, key, and secret 
# link to my app https://github.com/settings/applications/1406016
myapp <- oauth_app("Getting-and-Cleaning-Data-JHU",
                   key = "8d2ed6b88f7c879964ff",
                   secret = "ed94bae929971eba351a7bdcc8a98ab7e2dc8d44")

# Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

# Use API
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/users/jtleek/repos", gtoken)

# Take action on http error
stop_for_status(req)

# Extract content from a request
json1 = content(req)

# Convert to a data.frame
gitDF = jsonlite::fromJSON(jsonlite::toJSON(json1))

# Subset data.frame
gitDF[gitDF$full_name == "jtleek/datasharing", "created_at"] 



#### Question 2 ####

# install.packages("sqldf")
library("sqldf")

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
f <- file.path(getwd(), "Week 2/ss06pid.csv")
download.file(url, f)
acs <- data.table::data.table(read.csv(f))
str(acs)
# Answer: 
query1 <- sqldf("select pwgtp1 
                from acs 
                where AGEP < 50;")

#### Question 3 #### 

sqldf("select distinct AGEP 
      from acs;")


#### Question 4 ####

connection <- url("http://biostat.jhsph.edu/~jleek/contact.html")
htmlCode <- readLines(connection)
close(connection)

nchar(htmlCode[c(10,20,30,100)])


#### Question 5 ####

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
lines <- readLines(url)
#### don't know how to solve