#Alonzo Castanon
#11/17/2017

## Script assumes current working directory is UCI HAR Dataset folder

## First, read the Y data (this data represents what action the subjects did
## that caused these readings.
testY <- read.table("./test/y_test.txt", header = FALSE, sep = "")
trainY <- read.table("./train/y_train.txt", header = FALSE, sep = "")

## Then read X data, the actual values
testX <- read.table("./test/X_test.txt", header = FALSE, sep = "")
trainX <- read.table("./train/X_train.txt", header = FALSE, sep = "")

## Finally, subject data, an identifier for each subject
testSub <- read.table("./test/subject_test.txt", header = FALSE, sep = "")
trainSub <- read.table("./train/subject_train.txt", header = FALSE, sep = "")

## Combine two datasets by index (row name), putting Y data in front (leftmost)
test_data <- cbind(testY$V1, testSub$V1)
test_data <- cbind(test_data, testX)
train_data <- cbind(trainY$V1, trainSub$V1)
train_data <- cbind(train_data, trainX)

## Use supporting text files to properly name columns, so we can merge
cnames_set <- read.table("./features.txt")
cnames <- c("Activity", "Subject")
cnames <- append(cnames, as.character(cnames_set$V2))
colnames(test_data) <- cnames
colnames(train_data) <- cnames

## Combine two resultant datasets into one unified set
unified_data <- rbind(test_data, train_data)

## Use supporting text files to properly replace activity numbers with char strings
anames_table <- read.table("./activity_labels.txt", col.names = c("number","label"))
anames_table$label <- as.character(anames_table$label)
act_col <- unified_data$Activity
act_col <- lapply(act_col, function(x) anames_table$label[match(x, anames_table$number)])
unified_data$Activity <- act_col
unified_data$Activity <- as.character(unified_data$Activity)

## Finally, remove any columns not relating to mean or standard deviation
## Here I use a regular expression to get any column with name that has a "mean" or "std" in it
## It takes the substring "Mean", "mean", or "std" as a match, and leaves only 86 columns.
## It also allows the column "Activity" and "Subject" to match through as well
cleaned_data <- unified_data[, grep("(.*([Mm]ean|std|Activity|Subject).*)", colnames(unified_data))]

## For Step 5, "From the data set in step 4, creates a second, independent
## tidy data set with the average of each variable for each activity and each subject",
## done below using aggregate
tidy <- aggregate(cleaned_data[,3:88], by=list(cleaned_data$Activity, cleaned_data$Subject), mean)
colnames(tidy)[1] <- "Activity"
colnames(tidy)[2] <- "Subject"

## Write out tidy dataset to "tidy.csv"
write.csv(tidy, file = "./tidy.csv", row.names = FALSE)

