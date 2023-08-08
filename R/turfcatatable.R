##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
##                                                                            --
##------------------------- TURF CATA TABLE CREATOR-----------------------------
##                                                                            --
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
## Adapted From "TURF analysis for CATA data using R package ‘turfR’" by Carla Kuestena and Jian Bi----
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
##  ~ Adapted By Lukas Taylor To Add Reach And Frequency To TURF Table  ----
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



##
#' @title turfcatatable
#'
#' @param catadat
#'
#' From turfR package documentation: "Required. Literal character string representing name of a file in the working directory readable using read.table(data, header=TRUE), or name of a data frame or matrix in R containing TURF data. Rows are individuals (respondents). Columns are (1) respondent identifier, (2) a weight variable, and a minimum of n columns containing only zeroes and ones, each representing an individual item in the TURF algorithm. Respondent identifiers need not be unique and weights need not sum to the total number of rows. In the absence of any weight variable, substitute a column of ones. Ones in the remaining columns indicate that the reach criterion was met for a given item by a given individual. Values other than zero or one in these columns (including NA) trigger an error. data may contain more than n + 2 columns, but any columns in addition to that number will be ignored."
#'
#' Here is an example of how data should be entered prior to using this package:
#'
#' |ID | weight| Flavor1| flavor2| flavor3| flavor4| flavor5| flavor6| flavor7| flavor8|
#' |:--|------:|-------:|-------:|-------:|-------:|-------:|-------:|-------:|-------:|
#'   |1  |      1|       1|       1|       1|       1|       1|       1|       1|       1|
#'   |2  |      2|       1|       1|       1|       0|       0|       0|       1|       1|
#'   |3  |      3|       1|       0|       0|       0|       1|       0|       0|       1|
#'   |4  |      4|       1|       0|       0|       1|       1|       0|       1|       0|
#'   |5  |      5|       1|       1|       1|       1|       1|       1|       1|       1|
#'   |6  |      6|       1|       1|       1|       1|       1|       0|       1|       1|
#'   |7  |      7|       1|       0|       0|       0|       1|       0|       1|       0|
#'   |8  |      8|       1|       0|       0|       0|       0|       1|       0|       0|
#'   |9  |      9|       1|       0|       1|       1|       1|       1|       0|       1|
#'   |10 |     10|       1|       0|       1|       0|       1|       1|       1|       1|
#'
#' @export turfcatatable
#'
#' @details
#'
#' NOTE: This code is a simple add-on to code from "TURF analysis for CATA data using R package ‘turfR’" by Carla Kuestena and Jian Bi. This code adds R-Markdown table formatting as well as reach and frequency values in the table.
#'
#' This package takes in "Check All That Apply" data, or CATA data, and returns a a TURF analysis chart. Check all that apply data is when a respondent in a survey is asked to choose all the results that meet the given criteria in a question. This data can be used in marketing and advertisement to determine the best choices when choosing multiple strategies at the same time. For instance, one can ask what scent of candle one likes. Upon gathering surveys across a representative sample, the firm can reach a maximum number of unique customers by using a turf analysis. The turf analysis will tell them how to maximize reach. Although TURF can give advice for which survey answers the firm should focus on for any given number of choices to persue at the same time, TURF cannot tell the firm what the number of items that they should invest in. Optimal combinations are chosen primarily by reach, which is the percent of customers that will be attracted by at least one of the chosen strategies.
#'
#' As explained by Carla Kuesten and Jian Bi:
#' "TURF, i.e., Total Unduplicated Reach and Frequency, is a statistical model. It can be used for selecting the optimum combinations from the huge numbers of possible combinations. There are two criteria for optimization: Reach and Frequency. Reach is the number of the re- spondents who mentioned at least one of the terms in a combination. Frequency is the total number of mentions of the terms in a combination."
#' -"TURF analysis for CATA data using R package ‘turfR’" by Carla Kuesten and Jian Bi
#'
#' Let's say a firm is selling scented candles, in this case, reach is the number of respondents who answered at least one of the scents in the combination (we can calculate this as a percentage), not double counting for respondents who chose multiple scents in the combination. Frequency is the number of times times all scents in the combination were chosen, including double (or triple or more) counting for respondents who chose multiple scents in the combination.
#'
#' Optimal bundles for each maximum number of options are calculated by reach, using frequency only as a tiebreaker.
#'
#' @examples
#'
#' my_nested_list <- list(id=c(1,2,3,4,5),
#' weight=c(1,1,1,1,1),
#' choice1 = c(0,0,1,1,0),
#' choice2 = c(1,0,0,1,1),
#' choice3 = c(0,1,0,1,1),
#' choice4 = c(0,1,0,1,1),
#' choice5 = c(1,1,1,1,1))
#'
#' catadat <-  as.data.frame(do.call(cbind, my_nested_list))
#'
#' turfcatatable(catadat)
#'
#' @returns
#'
#' Table of optimal combinations and their reach and frequencies.
#'
#' Then this is the output from turfcatatable(function) for the data from the details section:
#'
#' |          |         1|        2|        3|        4|        5|        6|        7|
#' |:---------|---------:|--------:|--------:|--------:|--------:|--------:|--------:|
#'   |Reach     | 0.0581395| 1.000000| 1.000000| 1.000000| 1.000000| 1.000000| 1.000000|
#'   |Frequency | 1.0000000| 1.818182| 2.472727| 3.109091| 3.709091| 4.309091| 4.763636|
#'   |1         | 1.0000000| 1.000000| 1.000000| 1.000000| 1.000000| 1.000000| 1.000000|
#'   |2         | 0.0000000| 0.000000| 0.000000| 0.000000| 0.000000| 0.000000| 0.000000|
#'   |3         | 0.0000000| 0.000000| 0.000000| 0.000000| 1.000000| 1.000000| 1.000000|
#'   |4         | 0.0000000| 0.000000| 0.000000| 0.000000| 0.000000| 0.000000| 1.000000|
#'   |5         | 0.0000000| 1.000000| 1.000000| 1.000000| 1.000000| 1.000000| 1.000000|
#'   |6         | 0.0000000| 0.000000| 0.000000| 0.000000| 0.000000| 1.000000| 1.000000|
#'   |7         | 0.0000000| 0.000000| 0.000000| 1.000000| 1.000000| 1.000000| 1.000000|
#'   |8         | 0.0000000| 0.000000| 1.000000| 1.000000| 1.000000| 1.000000| 1.000000|
#'
#' One reads the table by first looking at a column. The number of each column corrosponds to how many items are in the combination. Remember, TURF only attempts to tell you the best combination for any given number of items in the combination. But, it cannot tell you how many items should be in the combination. So, going back to the table, the 1 column corresponds with having only one item in the combination.  In this case, there is a 1 next to option 1. This means that if you're only going to choose one option, it should be option 1. The next column shows you the two options that you should choose if you're only going to choose two options, and so on. The chosen options in each column have a 1 instead of a 0.
#'
#' The reach and frequency are on the top of the table.
#'
#' @md
#'
#' @importFrom turfR turf
#' @importFrom stats na.omit
#' @importFrom Rdpack reprompt
#' @importFrom insight export_table
#'
#' @references
#' Carla Kuesten, Jian Bi,
#' TURF analysis for CATA data using R package ‘turfR’,
#' Food Quality and Preference,
#' Volume 91,
#' 2021,
#' 104201,
#' ISSN 0950-3293,
#' https://doi.org/10.1016/j.foodqual.2021.104201.
#' (https://www.sciencedirect.com/science/article/pii/S0950329321000288)
#' Abstract: CATA (Check All That Apply) questions are one of the most popular approaches used widely in sensory and consumer fields. This paper proposes to apply the TURF (Total Unduplicated Reach and Frequency) technique to summarize and analyze CATA data. Numerical examples from a women’s multi-vitamin/mineral gummy survey conducted online recently in the US are provided to show the TURF analysis for CATA data. The R package ‘turfR’ was used in the analysis of the CATA data. An R code (‘turfcata’) was developed and is provided for the analysis using the R package ‘turfR’.
#' Keywords: CATA (Check All That Apply); TURF (Total Unduplicated Reach and Frequency); Multi-vitamin/mineral gummy





##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
##  ~ CODE FROM RESEARCH PAPER CITED IN DOCUMENTATION  ----
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


turfcatatable <- function(catadat) {

  x <- catadat
  m <- dim(x)[2] - 2
  if (m < 17) {
    k <- m - 1
  } else{
    k <- 7
  }
  x <- as.data.frame(x)
  x <- na.omit(x)
  d <- dim(x)
  # cat(d, "\n")
  Turfexam <- turf(x, m, 2:k)
  a <- matrix(0, m + 2, k - 1)
  dimnames(a) <-
    list(c("Reach", "Frequency", seq(1, m)), c(seq(2, k)))
  for (i in 1:(k - 1)) {
    a[, i] <- as.numeric(as.vector(Turfexam$turf[[i]][1, ])[2:(m + 3)])
  }
  b <- matrix(0, m, 2)
  b[, 1] <- seq(1, m)
  b[, 2] <- apply(x[, 3:(m + 2)], 2, sum)
  b <- b[rev(sort.list(b[, 2])),]
  b <- cbind(b, c(1, rep(0, m - 1)))
  b <- b[sort.list(b[, 1]),]





  ##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  ##  ~ NEW CODE TO ADD REACH AND FREQUENCY  ----
  ##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  #........................Calculating.......................

  reach1 <-  max(b[, 2]) / length(unlist(catadat[, 1]))

  combo_one_column <- c(reach1, reach1, b[, 3])

  ab <- cbind(combo_one_column, a[1:(m + 2),])
  dimnames(ab)[[2]][1] <- "1"

  #........................Printing Result.........................

  export_table(ab, format = "md")

}
