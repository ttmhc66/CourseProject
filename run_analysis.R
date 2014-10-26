##    You should create one R script called run_analysis.R that does the following. 
##    Merges the training and the test sets to create one data set.
##    Extracts only the measurements on the mean and standard deviation for each measurement. 
##    Uses descriptive activity names to name the activities in the data set
##    Appropriately labels the data set with descriptive variable names. 
##    From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

##    Script requires the packages: dplyr
library("dplyr")
x_test <- read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt", header = FALSE)
y_test <- read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt", header = FALSE)
subject_test <- read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt", header = FALSE)
x_train <- read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt", header = FALSE)
y_train <- read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt", header = FALSE)
subject_train <- read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt", header = FALSE)
features <- read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/features.txt", header = FALSE)
names(x_test) <- features[[2]]
names(x_train) <- features[[2]]
names(y_test) <- "activity"
names(y_train) <- "activity"
names(subject_test) <- "subject"
names(subject_train) <- "subject"
x <- rbind(x_test, x_train)
y <- rbind(y_test, y_train)
subject <- rbind(subject_test, subject_train)
y[y == 1] <- "WALKING"
y[y == 2] <- "WALKING_UPSTAIRS"      
y[y == 3] <- "WALKING_DOWNSTAIRS"
y[y == 4] <- "SITTING"     
y[y == 5] <- "STANDING"
y[y == 6] <- "LAYING"      
dat <- cbind(subject, y, x)
dat <- dat[,grepl("mean|std|subject|activity", names(dat)) & !grepl("meanFreq", names(dat))]
dat <- arrange(dat, subject, activity)
groupdat <- dat %>% group_by(subject, activity)
newdat <- groupdat %>% summarise_each(funs(mean))
