# TidyDataProject
Getting and Cleaning Data Course Project

This repository hosts the R code and documentation files for the Data Science's track course "Getting and Cleaning data", available in coursera.

The dataset being used, as well as a full description is available at the website : http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

# How the R script in "run_analysis.R" work and how they are connected

0. Create a file directory named "dataset.zip" wherein the dataset is downloaded and unzipped;

1.Load both the training and test datasets;
  Load the activity and feature info;
  Make use of descriptive activity names to name the activities in the data set;
  Merges the two datasets (training and test sets) to create one data set "setAllinOne";

2.Create a vector to define ID, meand and standard deviation;
  Take a subset from "setAllinOne" specified just by mean and standard deviation;

3/4.Names the activities in the subset with descriptive activity names;

5. Creates a tidy dataset that consists of the average (mean) value of each variable for each subject and activity pair;

The end result is shown in the file secTidySet.txt.
