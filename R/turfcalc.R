##
#' @title turfcalc
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
#' @export turfcalc
#'
#' @details
#'
#' Does calculations for table and graphing.
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
#' turfcalc(catadat)
#'
#' @returns
#'
#' Unformatted table of optimal combinations and their reach and frequencies.
#'
#' @md
#'
#' @importFrom turfR turf
#' @importFrom stats na.omit
#' @importFrom Rdpack reprompt
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

turfcalc <- function(catadat) {

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

  return(ab)

}
