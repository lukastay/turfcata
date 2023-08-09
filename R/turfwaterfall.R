##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
##                                                                            --
##------------------------------- TURFWATERFALL---------------------------------
##                                                                            --
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
##                            roxygen2 Parameters                           ----
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#' @title turfwaterfall
#'
#' @param catadat From turfR package documentation: "Required. Literal character string representing name of a file in the working directory readable using read.table(data, header=TRUE), or name of a data frame or matrix in R containing TURF data. Rows are individuals (respondents). Columns are (1) respondent identifier, (2) a weight variable, and a minimum of n columns containing only zeroes and ones, each representing an individual item in the TURF algorithm. Respondent identifiers need not be unique and weights need not sum to the total number of rows. In the absence of any weight variable, substitute a column of ones. Ones in the remaining columns indicate that the reach criterion was met for a given item by a given individual. Values other than zero or one in these columns (including NA) trigger an error. data may contain more than n + 2 columns, but any columns in addition to that number will be ignored."
#'
#' @param themed Set to TRUE to add cowplot themed for high resolution text and dashed borders between bars.
#'
#' @param adding Set to TRUE to add "Adding" to each x axis label. FALSE by default.
#'
#' @param top_horizontal_line Set to TRUE or FALSE depending on if you want a black line at 1.0. TRUE by default.
#'
#' @param vertical_lines Set to TRUE or FALSE depending on if you want a dashed line between each bar. TRUE by default.
#'
#' @param y_axis_label String for y axis label. Defaults to "Reach After Adding Item (%)". Set to FALSE for no y axis label.
#'
#' @param x_axis_label String for x axis label. Defaults to "Adding Item To Combination". Set to FALSE for no x axis label.
#'
#' @param middle_horizontal_line Set to TRUE to add horizontal line intersecting the x-axis at .5. Set to True by default.
#'
#' @returns Waterfall plot
#'
#' @export turfwaterfall
#'
#' @details
#'
#' Plots waterfall graph for reach as you add variables.
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
#' @importFrom cowplot theme_cowplot
#' @import ggplot2

##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
##  ~ Function Definition And Code  ----
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

turfwaterfall <-
  function(catadat,
           themed = TRUE,
           adding = FALSE,
           top_horizontal_line = TRUE,
           vertical_lines = TRUE,
           middle_horizontal_line = TRUE,
           y_axis_label = "Reach After Adding Item (%)",
           x_axis_label = "Adding Item To Combination") {

    #......................Running TURF Analysis.....................

    turfcalced <- turfcalc(catadat)

    #...................Getting Delta Reach Values...................

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

    #..................Rounding Delta Reach Values...................

    iteration <- 1
    for (value in values_after) {
      if (iteration == 1) {
        values_after2 <- c(round(value, digits = 2))
      } else{
        values_after2 <- append(values_after2, round(value, digits = 2))
      }
      iteration <- iteration + 1
    }

    #.................Adding Labels In Correct Order.................

    already_added = c("empty")
    ordered_labels = c("empty")

    labels <- names(catadat)[3:length(names(catadat))]

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
              ordered_labels <-
                c(names(catadat)[2 + variable_number])
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

    #..........Optional Addition Of Context To X Axis Labels.........

    if (adding == TRUE) {
      iteration <- 1
      for (label in ordered_labels) {
        label_toadd <- paste("Adding", label, sep = " ")
        if (iteration == 1) {
          ordered_labels2 <- c(label_toadd)
        } else{
          ordered_labels2 <- append(ordered_labels2, label_toadd)
        }

        iteration <- iteration + 1
      }
      ordered_labels <- ordered_labels2
    }

    #....................Defining Waterfall Chart....................

    p <- waterfall(values = values_after2, labels = ordered_labels) +
      scale_x_discrete(guide = guide_axis(n.dodge = 2))

    #......................Setting Axis Labels.......................

    if (y_axis_label != FALSE) {
      p <- p + ylab(y_axis_label)
    }
    if (x_axis_label != FALSE) {
      p <- p + xlab(x_axis_label)
    }

    #............Adding Lines To Plot For Better Clarity.............

    if (vertical_lines == TRUE) {
      xint <- 1.5
      for (value in ordered_labels) {
        p <-
          p + geom_vline(xintercept = xint,
                         linetype = "dashed",
                         alpha = .2)
        xint <- xint + 1.5
      }
    }

    if (top_horizontal_line == TRUE) {
      p <- p +
        geom_hline(yintercept = 1)
    }

    if (middle_horizontal_line == TRUE) {
      p <- p +
        geom_hline(yintercept = .5,
                   linetype = "dashed",
                   color = "grey")
    }

    #........Adding Theme For High Resolution And Minimalism.........

    if (themed != FALSE) {
      p <- p + theme_cowplot(12) +
        theme(axis.text = element_text(size = 7))
    }

    #....................Returning Waterfall Chart...................

    return(p)

  }
