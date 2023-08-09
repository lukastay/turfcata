# turfcata
R package for making turf tables and waterfall charts for "choose all that apply" type survey data.

To install, type the following two commands into an R script or in the console.

```
library(devtools)
install_github("lukastay/turfcata")
library(turfcata)
```

This package is for working with "choose all that apply" survey type questions. This package requires raw data from these questions. You will need a dataframe suitable for the turfR library. Each row should represent a single respondent to the survey. Its columns should be:

1) A identifier column
2) A weight column (if you don't want to weight it, send a column full of 1s)
3) 3 or more columns for each of the possible answers to the question. With 1s if the respondent chose the answer and 0 otherwise.

There are two main functions of this package:

1) Displaying turf tables

Code:

```
turfcatatable(dataframe)
```

![turf table example](turftable.png?raw=true)


This code builds upon code released in "TURF analysis for CATA data using R package ‘turfR’" by Carla Kuestena and Jian Bib. This package amends the code so reach and frequency are both expressed for each combination number.

2) Creating waterfall charts from turf tables

Code:

```
turfwaterfall(dataframe)
```

![waterfall example](waterfall.png?raw=true)

This code also creates waterfall tables to see how much reach rises with each increase in the maximum number of items in the combination.

For full documentation on the package, see the manuals in the "man" folder.
