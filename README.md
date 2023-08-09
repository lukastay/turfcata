# turfcata
R package for making turf tables and waterfall charts for "choose all that apply" type survey data.

![https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.pewresearch.org%2Fmethods%2F2019%2F05%2F09%2Fwhen-online-survey-respondents-only-select-some-that-apply%2F&psig=AOvVaw1NUc7ws4dSGHoqXYpSHZcO&ust=1691643390857000&source=images&cd=vfe&opi=89978449&ved=0CBAQjRxqFwoTCJDkju3kzoADFQAAAAAdAAAAABAE](https://www.pewresearch.org/methods/wp-content/uploads/sites/10/2019/05/PM_19.05.29_featured.png)
Image from "When Online Survey Respondents Only ‘Select Some That Apply’" by Pew Research Center

This package takes in "Check All That Apply" data, or CATA data, and returns a a TURF analysis chart. Check all that apply data is when a respondent in a survey is asked to choose all the results that meet the given criteria in a question. This data can be used in marketing and advertisement to determine the best choices when choosing multiple strategies at the same time. For instance, one can ask what scent of candle one likes. Upon gathering surveys across a representative sample, the firm can reach a maximum number of unique customers by using a turf analysis. The turf analysis will tell them how to maximize reach. Although TURF can give advice for which survey answers the firm should focus on for any given number of choices to persue at the same time, TURF cannot tell the firm what the number of items that they should invest in. Optimal combinations are chosen primarily by reach, which is the percent of customers that will be attracted by at least one of the chosen strategies.

As explained by Carla Kuesten and Jian Bi:
> "TURF, i.e., Total Unduplicated Reach and Frequency, is a statistical model. It can be used for selecting the optimum combinations from the huge numbers of possible combinations. There are two criteria for optimization: Reach and Frequency. Reach is the number of the re- spondents who mentioned at least one of the terms in a combination. Frequency is the total number of mentions of the terms in a combination."
> -"TURF analysis for CATA data using R package ‘turfR’" by Carla Kuesten and Jian Bi

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

|          |         1|         2|         3|        4|        5|        6|        7|        8|        9|
|:---------|---------:|---------:|---------:|--------:|--------:|--------:|--------:|--------:|--------:|
|Reach     | 0.8888889| 0.9882248| 0.9986732| 1.000000| 1.000000| 1.000000| 1.000000| 1.000000| 1.000000|
|Frequency | 0.8888889| 1.7128373| 2.4489926| 3.077334| 3.795561| 4.268121| 4.618102| 4.948056| 5.133911|
|1         | 0.0000000| 0.0000000| 0.0000000| 0.000000| 0.000000| 0.000000| 0.000000| 0.000000| 0.000000|
|2         | 0.0000000| 0.0000000| 0.0000000| 0.000000| 0.000000| 0.000000| 0.000000| 0.000000| 1.000000|
|3         | 0.0000000| 0.0000000| 0.0000000| 0.000000| 0.000000| 0.000000| 0.000000| 1.000000| 1.000000|
|4         | 0.0000000| 0.0000000| 0.0000000| 0.000000| 0.000000| 0.000000| 1.000000| 1.000000| 1.000000|
|5         | 0.0000000| 0.0000000| 0.0000000| 0.000000| 0.000000| 1.000000| 1.000000| 1.000000| 1.000000|
|6         | 0.0000000| 0.0000000| 0.0000000| 1.000000| 1.000000| 1.000000| 1.000000| 1.000000| 1.000000|
|7         | 0.0000000| 0.0000000| 0.0000000| 0.000000| 1.000000| 1.000000| 1.000000| 1.000000| 1.000000|
|8         | 0.0000000| 0.0000000| 1.0000000| 1.000000| 1.000000| 1.000000| 1.000000| 1.000000| 1.000000|
|9         | 0.0000000| 1.0000000| 1.0000000| 1.000000| 1.000000| 1.000000| 1.000000| 1.000000| 1.000000|
|10        | 1.0000000| 1.0000000| 1.0000000| 1.000000| 1.000000| 1.000000| 1.000000| 1.000000| 1.000000|

This code builds upon code released in "TURF analysis for CATA data using R package ‘turfR’" by Carla Kuestena and Jian Bib. This package amends the code so reach and frequency are both expressed for each combination number.

2) Creating waterfall charts from turf tables

Code:

```
turfwaterfall(dataframe)
```

![waterfall example](waterfall.png?raw=true)

This code also creates waterfall tables to see how much reach rises with each increase in the maximum number of items in the combination.

------Importing data:
From turfR package documentation: "Required. Literal character string representing name of a file in the working directory readable using read.table(data, header=TRUE), or name of a data frame or matrix in R containing TURF data. Rows are individuals (respondents). Columns are (1) respondent identifier, (2) a weight variable, and a minimum of n columns containing only zeroes and ones, each representing an individual item in the TURF algorithm. Respondent identifiers need not be unique and weights need not sum to the total number of rows. In the absence of any weight variable, substitute a column of ones. Ones in the remaining columns indicate that the reach criterion was met for a given item by a given individual. Values other than zero or one in these columns (including NA) trigger an error. data may contain more than n + 2 columns, but any columns in addition to that number will be ignored."

Here is an example of how data should be entered prior to using this package:

 |ID | weight| Flavor1| flavor2| flavor3| flavor4| flavor5| flavor6| flavor7| flavor8|
 |:--|------:|-------:|-------:|-------:|-------:|-------:|-------:|-------:|-------:|
   |1  |      1|       1|       1|       1|       1|       1|       1|       1|       1|
   |2  |      2|       1|       1|       1|       0|       0|       0|       1|       1|
   |3  |      3|       1|       0|       0|       0|       1|       0|       0|       1|
   |4  |      4|       1|       0|       0|       1|       1|       0|       1|       0|
   |5  |      5|       1|       1|       1|       1|       1|       1|       1|       1|
   |6  |      6|       1|       1|       1|       1|       1|       0|       1|       1|
   |7  |      7|       1|       0|       0|       0|       1|       0|       1|       0|
   |8  |      8|       1|       0|       0|       0|       0|       1|       0|       0|
   |9  |      9|       1|       0|       1|       1|       1|       1|       0|       1|
   |10 |     10|       1|       0|       1|       0|       1|       1|       1|       1|

------Reach vs. Frequency Example
#' Let's say a firm is selling scented candles, in this case, reach is the number of respondents who answered at least one of the scents in the combination (we can calculate this as a percentage), not double counting for respondents who chose multiple scents in the combination. Frequency is the number of times times all scents in the combination were chosen, including double (or triple or more) counting for respondents who chose multiple scents in the combination.
------Note on optimal bundles
Optimal bundles for each maximum number of options are calculated by reach, using frequency only as a tiebreaker.
------Further reading
For full documentation on the package, see the manuals in the "man" folder.
