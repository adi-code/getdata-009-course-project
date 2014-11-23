# Author: Adrian Boczkowski (http://github.com/adi-code).
# Getting and Cleaning Data (Courser)
# getdata-009

# Load plyr library to use ddply() and join() functions.
library(plyr)

# A path to a directory that contains the original dataset.
dataDir <- "getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset"

# A path to a directory that will store all outputed files.
targetDir <- "cleaned"

# This function created a directory if necessary.
prepareMergedData <- function(targetDir) {
        if(!file.exists(targetDir)) {
                message("Creating ", targetDir)
                dir.create(targetDir)
        }
}

# This function cleans all .txt files from the target directory.
cleanMergedData <- function(targetDir) {
        files <- dir(targetDir, pattern=".+\\.txt")
        sapply(files, function(fileName) {
                filePath <- file.path(targetDir, fileName)
                message("Removing ", filePath)
                file.remove(filePath)
        })
}

# This function is internally used by mergeData(), it copies/appends files
# in order to merge two datasets.
appendFile <- function(fileName, dataDir, targetDir, dataType) {
        if(dataType != "test" & dataType != "train") {
                error("The dataType value should be 'train' or 'test'")
        }
        
        # Create a new filename "*_merged.txt".
        repl <- paste("_", dataType, sep="")
        newFileName <- gsub(repl, "_merged", fileName)

        # A path to the source file.
        sourcePath <- file.path(dataDir, dataType, fileName)
        # A path to the target file.
        targetPath <- file.path(targetDir, newFileName)

        if(!file.exists(targetPath)) { # If file doesn't exist, create it.
                message("Copying ", sourcePath, " to ", targetPath)
                file.copy(from=sourcePath, to=targetPath)
        } else { # If file exists, just append to it.
                message("Appending ", sourcePath, " to ", targetPath)
                file.append(targetPath, sourcePath)
        }
}

# This function merges two datasets.
mergeData <- function(dataDir, targetDir) {
        # Get list of .txt files from "test" subdirectory
        # in the original dataset.
        files <- dir(file.path(dataDir, "test"), pattern=".+\\.txt")
        # For each file create a merged file.
        sapply(files, appendFile, dataDir=dataDir, targetDir=targetDir,
               dataType="test")
        
        # Get list of .txt files from "train" subdirectory
        # in the original dataset.
        files <- dir(file.path(dataDir, "train"), pattern=".+\\.txt")
        # For each file append to the merged file.
        sapply(files, appendFile, dataDir=dataDir, targetDir=targetDir,
               dataType="train")
        
        # Copy also some useful files (features_info.txt, etc.).
        files <- dir(dataDir, pattern=".+\\.txt")
        sapply(files, function(fileName) {
                # Skip README.txt file
                if(fileName == "README.txt") {
                        return()
                }
                
                # A path to the source file.
                sourcePath <- file.path(dataDir, fileName)
                
                # A path to the target file.
                targetPath <- file.path(targetDir, fileName)
                
                # Copy it.
                message("Copying ", sourcePath, " to ", targetPath)
                file.copy(sourcePath, targetPath)
        })
}

# It creates descriptive labels for variables. In order to make processed data
# readable and understandable, these names in the header should be provided.
# Kind of "camelCase" syntax is used.
createDescriptiveNames <- function(features) {
        # Correct bug in the original dataset.
        features <- gsub("BodyBody", "Body", features)
        # Full name for frequency domain variables.
        features <- gsub("f(Body|Gravity)", "frequency\\1", features)
        # Full name for time domain variables.
        features <- gsub("t(Body|Gravity)", "time\\1", features)
        # Full name for a accelerometer.
        features <- gsub("Acc", "Accelerometer", features)
        # Full name for a gyroscope.
        features <- gsub("Gyro", "Gyroscope", features)
        # Full name for a magnitude.
        features <- gsub("Mag", "Magnitude", features)
        # Full name for a mean frequency.
        features <- gsub("meanFreq", "MeanFrequency", features)
        # Capitalize first letter of "mean".
        features <- gsub("mean", "Mean", features)
        # Full name for a standard deviation.
        features <- gsub("std", "StandardDeviation", features)
        # Remove "-", "(" and ")".
        features <- gsub("-|\\(|\\)", "", features)
        features
}

# This function is used to provide a markdown-style table. It saves the table
# to processed_features.txt file.
writeFeatureNames <- function(mergedDir, features) {
        # Create a data frame with a "names" column.
        featureNames <- data.frame(names=features)
        
        # Create a "domain" column.
        featureNames$domain <- sapply(featureNames$names, function(featureName) {
                domain <- "time"
                if(grepl("^frequency", featureName)) {
                        domain <- "frequency"
                }
                domain
        })
        
        # Create a "device" column.
        featureNames$device <- sapply(featureNames$names, function(featureName) {
                device <- "accelerometer"
                if(grepl("Gyroscope", featureName)) {
                        device <- "gyroscope"
                }
                device
        })
        
        # Create a "group" column (a body or a gravity).
        featureNames$group <- sapply(featureNames$names, function(featureName) {
                group <- "body"
                if(grepl("Gravity", featureName)) {
                        group <- "gravity"
                }
                group
        })
        
        # Create a "value type" column.
        featureNames$valueType <- sapply(featureNames$names, function(featureName) {
                valueType <- "mean"
                if(grepl("StandardDeviation", featureName)) {
                        valueType <- "standard deviation"
                } else if(grepl("MeanFrequency", featureName)) {
                        valueType <- "mean frequency"
                }
                valueType
        })
        
        # Just add comment column and correct it by hand.
        featureNames$comment <- sapply(featureNames$names, function(featureName) {
                "x direction"
        })
        
        # Save the table to a file.
        write.table(featureNames, row.names=F, sep=" | ", quote=F,
                    file=file.path(mergedDir, "processed_features.txt"))
}

# It extracts relevant variables and describes "activity" values and
# all features.
extractMeanAndStd <- function(mergedDir) {
        # Read descriptive values for the "activity" variable.
        activityLabelsPath <- file.path(mergedDir, "activity_labels.txt")
        activityLabels <- read.csv(activityLabelsPath, sep=" ", header=F,
                                   col.names=c("nr", "activity"))

        # Read descriptive labels for all features.
        featuresPath <- file.path(mergedDir, "features.txt")
        features <- read.csv(featuresPath, sep=" ", header=F,
                             col.names=c("nr", "feature"))

        # Create descriptive labels.
        descriptiveNames <- createDescriptiveNames(as.character(features$feature))
        
        # Extract which variables describes a mean or a standard deviation.
        meanOrStd <- grepl("^(time|frequency).+(StandardDeviation|Mean|MeanFrequency)(X|Y|Z)?$",
                           descriptiveNames)
        # Make sure the labels are unique.
        descriptiveNames <- make.names(descriptiveNames, unique=T)
        
        # Read values for the "subject" variable.
        subjectFilePath <- file.path(mergedDir, "subject_merged.txt")
        subject <- read.csv(subjectFilePath, sep=" ", header=F,
                            col.names=c("subject"))
        
        # Read values for the "activity" variable.
        yFilePath <- file.path(mergedDir, "y_merged.txt")
        y <- read.csv(yFilePath, sep=" ", header=F, col.names=c("nr"))

        # Use descritive values for the "activity" variable.
        # Merge data frames using join() from the plyr package.
        yActivities <- join(y, activityLabels, by="nr")
        
        # Read values for the rest.
        xFilePath <- file.path(mergedDir, "X_merged.txt")
        # It can be time-consuming...
        message("Reading...")
        # A rough number of rows is given and a comment char is cleared
        # to speed up reading (see ?read.table).
        x <- read.table(xFilePath, header=F, col.names=descriptiveNames,
                      colClasses=rep("numeric", 561), nrow=11000,
                      comment.char="")
        message("The file has been read")
        
        # Extract means and standard deviations only.
        x <- x[,meanOrStd]
        # Add the "activity" variable.
        x$activity <- yActivities$activity
        # Add the "subject" variable.
        x$subject <- subject$subject
        
        # Save feature names for further use in CodeBook.
        writeFeatureNames(mergedDir, names(x))
        
        # Save the result.
        resultFile <- file.path(mergedDir, "cleaned_data.txt")
        write.table(x, file=resultFile, row.names=F)
        message("The result file ", resultFile, " has been created")
}

# This function computes the average for each variable for each pair
# ("activity", "subject") that occurs in the processed dataset.
meanForSubjectAndActivity <- function(mergedDir, fileName) {
        # Read the processed data.
        filePath <- file.path(mergedDir, fileName)
        featureValues <- read.csv(filePath, sep=" ")

        # Compute the averages.
        means <- ddply(featureValues, .(subject, activity), numcolwise(mean))

        # Save the result.
        resultFile <- file.path(mergedDir, "averages.txt")
        write.table(means, file=resultFile, row.names=F)
        message("The result file ", resultFile, " has been created")
}

prepareMergedData(targetDir)
cleanMergedData(targetDir)
mergeData(dataDir, targetDir)
extractMeanAndStd(targetDir)
meanForSubjectAndActivity(targetDir, "cleaned_data.txt")