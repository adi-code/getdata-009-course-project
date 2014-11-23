#  The CodeBook

## Introduction

This data is used for "Getting and Cleaning Data" from Coursera. The original
data can be downloaded from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.

This data comes from experiments carried out by Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto from Smartlab - Non Linear Complex Systems Laboratory. They aquired measurements from inertial sensors (accelerometer, gyroscope), which were built into Samsung Galaxy S II smartphones used by 30 volunteers. After filtering some features were computed. For more information please read README.txt from http://archive.ics.uci.edu/ml/machine-learning-databases/00240/UCI%20HAR%20Dataset.zip.

## Description

In this case both the training and the testing data were merged and only several features were extracted (these, which were described as a mean, a standard deviation or a frequency mean).

If the feature name starts with "time", it was computed using a time domain analysis, similarily if the feature name starts with "frequency", it was computed using a frequency domain analysis. There are two groups of data: a body and a gravity. These two groups were extracted from the raw data using a Butterworth filter. As mentioned above, two inertial sensors were used: an accelerometer and a gyroscope. Several variables were computed: X, Y, Z stand for direction, Magnitude were computed using the Euclidean norm and the body linear acceleration and angular velocity were derived in time to obtain Jerk signals. Frequency domain features were computed using Fast Fourier Transform.

Apart from the "activity" which is a string and the "subject" which is a number from 1 to 30, all features are normalized and bounded within [-1,1].

## Feature list

There are following features in the dataset:

Feature | Domain | Device | Group | Value type | Comment
--- | --- | --- | --- | --- | ---
activity | NA | NA | NA | NA | an activity that the volunteer performed
subject | NA | NA | NA | NA | an identifier of the subject who carried out the experiment (from 1 to 30)
timeBodyAccelerometerMeanX | time | accelerometer | body | mean | x direction
timeBodyAccelerometerMeanY | time | accelerometer | body | mean | y direction
timeBodyAccelerometerMeanZ | time | accelerometer | body | mean | z direction
timeBodyAccelerometerStandardDeviationX | time | accelerometer | body | standard deviation | x direction
timeBodyAccelerometerStandardDeviationY | time | accelerometer | body | standard deviation | y direction
timeBodyAccelerometerStandardDeviationZ | time | accelerometer | body | standard deviation | z direction
timeGravityAccelerometerMeanX | time | accelerometer | gravity | mean | x direction
timeGravityAccelerometerMeanY | time | accelerometer | gravity | mean | y direction
timeGravityAccelerometerMeanZ | time | accelerometer | gravity | mean | z direction
timeGravityAccelerometerStandardDeviationX | time | accelerometer | gravity | standard deviation | x direction
timeGravityAccelerometerStandardDeviationY | time | accelerometer | gravity | standard deviation | y direction
timeGravityAccelerometerStandardDeviationZ | time | accelerometer | gravity | standard deviation | z direction
timeBodyAccelerometerJerkMeanX | time | accelerometer | body | mean | x direction (jerk)
timeBodyAccelerometerJerkMeanY | time | accelerometer | body | mean | y direction (jerk)
timeBodyAccelerometerJerkMeanZ | time | accelerometer | body | mean | z direction (jerk)
timeBodyAccelerometerJerkStandardDeviationX | time | accelerometer | body | standard deviation | x direction (jerk)
timeBodyAccelerometerJerkStandardDeviationY | time | accelerometer | body | standard deviation | y direction (jerk)
timeBodyAccelerometerJerkStandardDeviationZ | time | accelerometer | body | standard deviation | z direction (jerk)
timeBodyGyroscopeMeanX | time | gyroscope | body | mean | x direction
timeBodyGyroscopeMeanY | time | gyroscope | body | mean | y direction
timeBodyGyroscopeMeanZ | time | gyroscope | body | mean | z direction
timeBodyGyroscopeStandardDeviationX | time | gyroscope | body | standard deviation | x direction
timeBodyGyroscopeStandardDeviationY | time | gyroscope | body | standard deviation | y direction
timeBodyGyroscopeStandardDeviationZ | time | gyroscope | body | standard deviation | z direction
timeBodyGyroscopeJerkMeanX | time | gyroscope | body | mean | x direction (jerk)
timeBodyGyroscopeJerkMeanY | time | gyroscope | body | mean | y direction (jerk)
timeBodyGyroscopeJerkMeanZ | time | gyroscope | body | mean | z direction (jerk)
timeBodyGyroscopeJerkStandardDeviationX | time | gyroscope | body | standard deviation | x direction (jerk)
timeBodyGyroscopeJerkStandardDeviationY | time | gyroscope | body | standard deviation | y direction (jerk)
timeBodyGyroscopeJerkStandardDeviationZ | time | gyroscope | body | standard deviation | z direction (jerk)
timeBodyAccelerometerMagnitudeMean | time | accelerometer | body | mean | magnitude
timeBodyAccelerometerMagnitudeStandardDeviation | time | accelerometer | body | standard deviation | magnitude
timeGravityAccelerometerMagnitudeMean | time | accelerometer | gravity | mean | magnitude
timeGravityAccelerometerMagnitudeStandardDeviation | time | accelerometer | gravity | standard deviation | magnitude
timeBodyAccelerometerJerkMagnitudeMean | time | accelerometer | body | mean | magnitude (jerk)
timeBodyAccelerometerJerkMagnitudeStandardDeviation | time | accelerometer | body | standard deviation | magnitude (jerk)
timeBodyGyroscopeMagnitudeMean | time | gyroscope | body | mean | magnitude
timeBodyGyroscopeMagnitudeStandardDeviation | time | gyroscope | body | standard deviation | magnitude
timeBodyGyroscopeJerkMagnitudeMean | time | gyroscope | body | mean | magnitude (jerk)
timeBodyGyroscopeJerkMagnitudeStandardDeviation | time | gyroscope | body | standard deviation | magnitude (jerk)
frequencyBodyAccelerometerMeanX | frequency | accelerometer | body | mean | x direction
frequencyBodyAccelerometerMeanY | frequency | accelerometer | body | mean | y direction
frequencyBodyAccelerometerMeanZ | frequency | accelerometer | body | mean | z direction
frequencyBodyAccelerometerStandardDeviationX | frequency | accelerometer | body | standard deviation | x direction
frequencyBodyAccelerometerStandardDeviationY | frequency | accelerometer | body | standard deviation | y direction
frequencyBodyAccelerometerStandardDeviationZ | frequency | accelerometer | body | standard deviation | z direction
frequencyBodyAccelerometerMeanFrequencyX | frequency | accelerometer | body | mean frequency | x direction
frequencyBodyAccelerometerMeanFrequencyY | frequency | accelerometer | body | mean frequency | y direction
frequencyBodyAccelerometerMeanFrequencyZ | frequency | accelerometer | body | mean frequency | z direction
frequencyBodyAccelerometerJerkMeanX | frequency | accelerometer | body | mean | x direction (jerk)
frequencyBodyAccelerometerJerkMeanY | frequency | accelerometer | body | mean | y direction (jerk)
frequencyBodyAccelerometerJerkMeanZ | frequency | accelerometer | body | mean | z direction (jerk)
frequencyBodyAccelerometerJerkStandardDeviationX | frequency | accelerometer | body | standard deviation | x direction (jerk)
frequencyBodyAccelerometerJerkStandardDeviationY | frequency | accelerometer | body | standard deviation | y direction (jerk)
frequencyBodyAccelerometerJerkStandardDeviationZ | frequency | accelerometer | body | standard deviation | z direction (jerk)
frequencyBodyAccelerometerJerkMeanFrequencyX | frequency | accelerometer | body | mean frequency | x direction (jerk)
frequencyBodyAccelerometerJerkMeanFrequencyY | frequency | accelerometer | body | mean frequency | y direction (jerk)
frequencyBodyAccelerometerJerkMeanFrequencyZ | frequency | accelerometer | body | mean frequency | z direction (jerk)
frequencyBodyGyroscopeMeanX | frequency | gyroscope | body | mean | x direction
frequencyBodyGyroscopeMeanY | frequency | gyroscope | body | mean | y direction
frequencyBodyGyroscopeMeanZ | frequency | gyroscope | body | mean | z direction
frequencyBodyGyroscopeStandardDeviationX | frequency | gyroscope | body | standard deviation | x direction
frequencyBodyGyroscopeStandardDeviationY | frequency | gyroscope | body | standard deviation | y direction
frequencyBodyGyroscopeStandardDeviationZ | frequency | gyroscope | body | standard deviation | z direction
frequencyBodyGyroscopeMeanFrequencyX | frequency | gyroscope | body | mean frequency | x direction
frequencyBodyGyroscopeMeanFrequencyY | frequency | gyroscope | body | mean frequency | y direction
frequencyBodyGyroscopeMeanFrequencyZ | frequency | gyroscope | body | mean frequency | z direction
frequencyBodyAccelerometerMagnitudeMean | frequency | accelerometer | body | mean | magnitude
frequencyBodyAccelerometerMagnitudeStandardDeviation | frequency | accelerometer | body | standard deviation | magnitude
frequencyBodyAccelerometerMagnitudeMeanFrequency | frequency | accelerometer | body | mean frequency | magnitude
frequencyBodyAccelerometerJerkMagnitudeMean | frequency | accelerometer | body | mean | magnitude (jerk)
frequencyBodyAccelerometerJerkMagnitudeStandardDeviation | frequency | accelerometer | body | standard deviation | magnitude (jerk)
frequencyBodyAccelerometerJerkMagnitudeMeanFrequency | frequency | accelerometer | body | mean frequency | magnitude (jerk)
frequencyBodyGyroscopeMagnitudeMean | frequency | gyroscope | body | mean | magnitude
frequencyBodyGyroscopeMagnitudeStandardDeviation | frequency | gyroscope | body | standard deviation | magnitude
frequencyBodyGyroscopeMagnitudeMeanFrequency | frequency | gyroscope | body | mean frequency | magnitude
frequencyBodyGyroscopeJerkMagnitudeMean | frequency | gyroscope | body | mean | magnitude (jerk)
frequencyBodyGyroscopeJerkMagnitudeStandardDeviation | frequency | gyroscope | body | standard deviation | magnitude (jerk)
frequencyBodyGyroscopeJerkMagnitudeMeanFrequency | frequency | gyroscope | body | mean frequency | magnitude (jerk)

## Processing path

1. Merging data from both test and train datasets.
2. Extracting features on the mean and the standard deviation (without angle() variables).
3. Using descriptive labels for each variable.
4. Using descriptive values for the "activity" variable.
5. Computing the average of each variable for every pair (activity, subject) that occurs in the dataset.

## Files

* cleaned/cleaned_data.txt - the merged, extracted and described dataset that contains all features described above (after step 4.)
* cleaned/averages.txt - the list of averages for each variable for each pair ("activity", "subject") that occurs in the cleaned_data.txt file