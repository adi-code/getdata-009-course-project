# Course Project (Getting and Cleaning Data from Coursera)
This repo contains files for Course Project from Getting and Cleaning Data from Coursera (getdata-009). Done by Adrian Boczkowski.

## Purpose

The purpose of this script is to merge "test" and "train" dataset, to extract required information (the mean and the standard deviation), to use descriptive values for "activity" variable, to make descriptive labels for each variable and to compute the average for each variable for each pair ("activity", "subject") that occurs in the dataset.

## Description

Only one script is used to perform the processing named "run_analysis.R". It contains several variables and functions.

Variables:
* dataDir - a (relative) path to folder with the original data
* targetDir - a path to folder with processed data

Functions:
* prepareMergedData - it creates the target directory if necessary
* cleanMergedData - it clears out the target directory
* appendFile - it is used internaly by mergeData for copying/appending data to a file
* mergeData - it merges two datasets ("test" and "train")
* createDescriptiveNames - it creates descriptive labels for variables
* writeFeatureNames - it saves labels for variables to a file
* extractMeanAndStd - it performs the main part, extracts relevant variables, uses descriptive values for the "activity" variable, creates descriptive labels for variables and saves it all to a new file
* meanForSubjectAndActivity - it computes mean for every pair (activity, subject) that occurs in the previously processed dataset

## Input

It is assumed that dataDir contains the following files:
* activity_labels.txt
* features.txt
* features_info.txt (not necessary)
* test/subject_test.txt
* test/y_test.txt
* test/X_test.txt
* train/subject_train.txt
* train/y_train.txt
* train/X_train.txt

## Output

The script creates several files in the targetDir:
* cleaned_data.txt - the merged, extracted and described dataset
* averages.txt - the final result of the whole processing
* processed_features.txt - a file that contains a markdown-syntax table to describe features in CodeBook
* subject_merged.txt - the merged subject_test.txt and subject_train.txt
* y_merged.txt - the merged y_test.txt and y_train.txt
* X_merged.txt - the merged X_test.txt and X_train.txt

It also copies these files from the input:
* activity_labels.txt
* features.txt
* features_info.txt

## Processing

All the processing is done by calling:
1. prepareMergedData(targetDir)
2. cleanMergedData(targetDir)
3. mergeData(dataDir, targetDir)
4. extractMeanAndStd(targetDir)
5. meanForSubjectAndActivity(targetDir, file.path(targetDir, "cleaned_data.txt"))