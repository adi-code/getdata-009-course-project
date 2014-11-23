dataDir <- "getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset"
targetDir <- "cleaned"


prepareMergedData <- function(targetDir) {
        if(!file.exists(targetDir)) {
                message("Creating ", targetDir)
                dir.create(targetDir)
        }
}

cleanMergedData <- function(targetDir) {
        files <- dir(targetDir, pattern=".+\\.txt")
        sapply(files, function(fileName) {
                filePath <- file.path(targetDir, fileName)
                message("Removing ", filePath)
                file.remove(filePath)
        })
}

appendFile <- function(fileName, dataDir, targetDir, dataType) {
        if(dataType != "test" & dataType != "train") {
                error("The dataType value should be 'train' or 'test'")
        }
        repl <- paste("_", dataType, sep="")
        newFileName <- gsub(repl, "_merged", fileName)

        sourcePath <- file.path(dataDir, dataType, fileName)
        targetPath <- file.path(targetDir, newFileName)

        if(!file.exists(targetPath)) {
                message("Copying ", sourcePath, " to ", targetPath)
                file.copy(from=sourcePath, to=targetPath)
        } else {
                message("Appending ", sourcePath, " to ", targetPath)
                file.append(targetPath, sourcePath)
        }
}

mergeData <- function(dataDir, targetDir) {
        files <- dir(file.path(dataDir, "test"), pattern=".+\\.txt")
        sapply(files, appendFile, dataDir=dataDir, targetDir=targetDir,
               dataType="test")
        files <- dir(file.path(dataDir, "train"), pattern=".+\\.txt")
        sapply(files, appendFile, dataDir=dataDir, targetDir=targetDir,
               dataType="train")
        
        files <- dir(dataDir, pattern=".+\\.txt")
        sapply(files, function(fileName) {
                if(fileName == "README.txt") {
                        return()
                }
                sourcePath <- file.path(dataDir, fileName)
                targetPath <- file.path(targetDir, fileName)
                message("Copying ", sourcePath, " to ", targetPath)
                file.copy(sourcePath, targetPath)
        })
}

createDescriptiveNames <- function(features) {
        features <- gsub("BodyBody", "Body", features)
        features <- gsub("f(Body|Gravity)", "frequency\\1", features)
        features <- gsub("t(Body|Gravity)", "time\\1", features)
        features <- gsub("Acc", "Accelerometer", features)
        features <- gsub("Gyro", "Gyroscope", features)
        features <- gsub("Mag", "Magnitude", features)
        features <- gsub("meanFreq", "MeanFrequency", features)
        features <- gsub("mean", "Mean", features)
        features <- gsub("std", "StandardDeviation", features)
        features <- gsub("-|\\(|\\)", "", features)
        features
}

writeFeatureNames <- function(mergedDir, features) {
        featureNames <- data.frame(names=features)
        featureNames$domain <- sapply(featureNames$names, function(featureName) {
                domain <- "time"
                if(grepl("^frequency", featureName)) {
                        domain <- "frequency"
                }
                domain
        })
        
        featureNames$device <- sapply(featureNames$names, function(featureName) {
                device <- "accelerometer"
                if(grepl("Gyroscope", featureName)) {
                        device <- "gyroscope"
                }
                device
        })
        
        featureNames$group <- sapply(featureNames$names, function(featureName) {
                group <- "body"
                if(grepl("Gravity", featureName)) {
                        group <- "gravity"
                }
                group
        })
        
        featureNames$valueType <- sapply(featureNames$names, function(featureName) {
                valueType <- "mean"
                if(grepl("StandardDeviation", featureName)) {
                        valueType <- "standard deviation"
                } else if(grepl("MeanFrequency", featureName)) {
                        valueType <- "mean frequency"
                }
                valueType
        })
        
        featureNames$comment <- sapply(featureNames$names, function(featureName) {
                "x direction"
        })
        
        write.table(featureNames, row.names=F, sep=" | ", quote=F,
                    file=file.path(mergedDir, "processed_features.txt"))
}

extractMeanAndStd <- function(mergedDir) {
        activityLabelsPath <- file.path(mergedDir, "activity_labels.txt")
        activityLabels <- read.csv(activityLabelsPath, sep=" ", header=F,
                                   col.names=c("nr", "activity"))

        featuresPath <- file.path(mergedDir, "features.txt")
        features <- read.csv(featuresPath, sep=" ", header=F,
                             col.names=c("nr", "feature"))

        descriptiveNames <- createDescriptiveNames(as.character(features$feature))
        meanOrStd <- grepl("^(time|frequency).+(StandardDeviation|Mean|MeanFrequency)(X|Y|Z)?$", descriptiveNames)
        descriptiveNames <- make.names(descriptiveNames, unique=T)
        
        subjectFilePath <- file.path(mergedDir, "subject_merged.txt")
        subject <- read.csv(subjectFilePath, sep=" ", header=F,
                            col.names=c("subject"))
        
        yFilePath <- file.path(mergedDir, "y_merged.txt")
        y <- read.csv(yFilePath, sep=" ", header=F, col.names=c("nr"))
        yActivities <- merge(y, activityLabels, by.x="nr", by.y="nr")
        
        n <- 100
        xFilePath <- file.path(mergedDir, "X_merged.txt")
        message("Reading...")
        x <- read.table(xFilePath, header=F,
                      col.names=descriptiveNames,
                      colClasses=rep("numeric", 561), nrow=11000,
                      comment.char="")
        message("A file has been read")
        x <- x[,meanOrStd]
        #xActivities <- merge(x, activityLabels, by.x="nr", by.y="nr")
        x$activity <- yActivities$activity
        x$subject <- subject$subject
        
        writeFeatureNames(mergedDir, names(x))
        
        print(names(x))
#         print(x[1:5,1:5])
        resultFile <- file.path(mergedDir, "cleaned_data.txt")
        write.table(x, file=resultFile, row.names=F)
        message("The result file ", resultFile, " has been created")
}

meanForSubjectAndActivity <- function(mergedDir, fileName) {
        library(plyr)
        featureValues <- read.csv(fileName, sep=" ")
        means <- ddply(featureValues, .(subject, activity), numcolwise(mean))
        resultFile <- file.path(mergedDir, "averages.txt")
        write.table(means, file=resultFile, row.names=F)
        message("The result file ", resultFile, " has been created")
}

prepareMergedData(targetDir)
cleanMergedData(targetDir)
mergeData(dataDir, targetDir)
extractMeanAndStd(targetDir)
meanForSubjectAndActivity(targetDir, file.path(targetDir, "cleaned_data.txt"))