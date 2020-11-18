# Load Packages and get the Data

require(data.table)
require(reshape2)
# packages <- c("data.table", "reshape2")
# sapply(packages, FUN = require, 
#        character.only=T, quietly=T)

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, file.path("Project/dataFiles.zip"))
unzip(zipfile = "Project/dataFiles.zip",
      exdir = "Project")

# Load activity labels and features
activityLabels <- fread("Project/UCI HAR Dataset/activity_labels.txt", 
                        col.names = c("classLabels", "activityName"))

features <- fread("Project/UCI HAR Dataset/features.txt", 
                  col.names = c("index", "featureNames"))
featuresWanted <- grep("(mean|std)\\(\\)", features[, featureNames])
measurements <- features[featuresWanted, featureNames]
measurements <- gsub('[()]', '', measurements)

# Load train data-sets
train <- fread("Project/UCI HAR Dataset/train/X_train.txt")[, featuresWanted, with = FALSE]
setnames(train, 
         old = colnames(train), 
         new = measurements)
trainActivities <- fread("Project/UCI HAR Dataset/train/Y_train.txt", 
                         col.names = "Activity")
trainSubjects <- fread("Project/UCI HAR Dataset/train/subject_train.txt", 
                       col.names = "SubjectNum")
train <- cbind(trainSubjects, trainActivities, train)

# Load test data-sets
test <- fread("Project/UCI HAR Dataset/test/X_test.txt")[, featuresWanted, with = FALSE]
setnames(test, 
         old = colnames(test), 
         new = measurements)
testActivities <- fread("Project/UCI HAR Dataset/test/Y_test.txt",
                        col.names = c("Activity"))
testSubjects <- fread("Project/UCI HAR Dataset/test/subject_test.txt",
                      col.names = c("SubjectNum"))
test <- cbind(testSubjects, testActivities, test)

# merge data-sets and add labels
combined <- rbind(train, test)

# Convert classLabels to activityName 
combined$Activity <- factor(combined$Activity,
                            levels = activityLabels$classLabels,
                            labels = activityLabels$activityName)
combined$SubjectNum <- as.factor(combined$SubjectNum)
combined <- reshape2::melt(data = combined, id = c("SubjectNum", "Activity"))
combined <- reshape2::dcast(data = combined, 
                            SubjectNum + Activity ~ variable, fun.aggregate = mean)

data.table::fwrite(x = combined, file = "Project/tidyData.txt", quote = FALSE)
