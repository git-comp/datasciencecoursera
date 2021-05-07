---
title: "Code Book for the 'Getting and Cleaning Data' couse, week 4"
output: html_notebook
---

# How to reproduce the generation of tinyData.txt
1. Execute the R script run_analysis.R; the source data will be downloaded, reformated, cleaned, pruned and exported to a file called tidyData.txt.

## About R script run_analysis.R
1. Loading required packages, downloading the file
2. Parsing the file and load activityLabels and features
3. Restrict to mean and standard deviation (and take care of mean in brackets of raw data)
4. Remove brackets in data set
5. Load training data sets
6. Load testing data sets
7. Merge training and testing data sets
8. Rename columns for better readibility
9. change type of subjectNum to factor
10. melt and dcast
11. export to file

# Data source
[Dataset](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

# Description of data source
[Description](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

