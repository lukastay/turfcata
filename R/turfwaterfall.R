#' @title turfwaterfall
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
#' @export turfwaterfall
#'
#' @details
#'
#' Plots waterfall graph for reach as you add variables.
#'
#' @returns
#'
#' Waterfall plot
#'
#' @md
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
#' turfwaterfall(catadat)
#'
#' @importFrom waterfalls waterfall

turfwaterfall <- function(catadat){

  labels <- names(catadat)[3:length(names(catadat))]

  turfcalced <- turfcalc(catadat)

  values_before <- turfcalced[1, ]

  values_place <- 0
  firsttime <- 1
  for (value in values_before) {
    if (firsttime == 1) {
      values_after = c(value)
      firsttime <- 0
    } else{
      new_value <- value - values_place
      values_after <- append(values_after, new_value)
    }
    values_place <- value
  }

  already_added = c("empty")
  ordered_labels = c("empty")

  first <- 1

  for (col in 0:length(turfcalced[1, ])) {
    variable_number <- 1

    for (cell in turfcalced[3:length(turfcalced[, 1]), col]) {
      if (cell == 1) {
        if (variable_number %in% already_added) {
          i <- 1

        } else{
          if (first == 1) {
            already_added <- variable_number
            ordered_labels <- c(names(catadat)[2 + variable_number])
            first <- 0
          } else{
            already_added <- append(already_added, variable_number)
            ordered_labels <-
              append(ordered_labels, names(catadat)[2 + variable_number])
          }

        }

      }

      variable_number <- variable_number + 1

    }

  }

  return(waterfall(values = values_after, labels = ordered_labels))

}
