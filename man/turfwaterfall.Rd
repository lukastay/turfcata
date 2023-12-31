% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/turfwaterfall.R
\name{turfwaterfall}
\alias{turfwaterfall}
\title{turfwaterfall}
\usage{
turfwaterfall(
  catadat,
  themed = TRUE,
  adding = FALSE,
  top_horizontal_line = TRUE,
  vertical_lines = TRUE,
  middle_horizontal_line = TRUE,
  y_axis_label = "Reach After Adding Item (\%)",
  x_axis_label = "Adding Item To Combination"
)
}
\arguments{
\item{catadat}{From turfR package documentation: "Required. Literal character string representing name of a file in the working directory readable using read.table(data, header=TRUE), or name of a data frame or matrix in R containing TURF data. Rows are individuals (respondents). Columns are (1) respondent identifier, (2) a weight variable, and a minimum of n columns containing only zeroes and ones, each representing an individual item in the TURF algorithm. Respondent identifiers need not be unique and weights need not sum to the total number of rows. In the absence of any weight variable, substitute a column of ones. Ones in the remaining columns indicate that the reach criterion was met for a given item by a given individual. Values other than zero or one in these columns (including NA) trigger an error. data may contain more than n + 2 columns, but any columns in addition to that number will be ignored."}

\item{themed}{Set to TRUE to add cowplot themed for high resolution text and dashed borders between bars.}

\item{adding}{Set to TRUE to add "Adding" to each x axis label. FALSE by default.}

\item{top_horizontal_line}{Set to TRUE or FALSE depending on if you want a black line at 1.0. TRUE by default.}

\item{vertical_lines}{Set to TRUE or FALSE depending on if you want a dashed line between each bar. TRUE by default.}

\item{middle_horizontal_line}{Set to TRUE to add horizontal line intersecting the x-axis at .5. Set to True by default.}

\item{y_axis_label}{String for y axis label. Defaults to "Reach After Adding Item (\%)". Set to FALSE for no y axis label.}

\item{x_axis_label}{String for x axis label. Defaults to "Adding Item To Combination". Set to FALSE for no x axis label.}
}
\value{
Waterfall plot
}
\description{
turfwaterfall
}
\details{
Plots waterfall graph for reach as you add variables.

Here is an example of how data should be entered prior to using this package:\tabular{lrrrrrrrrr}{
   ID \tab weight \tab Flavor1 \tab flavor2 \tab flavor3 \tab flavor4 \tab flavor5 \tab flavor6 \tab flavor7 \tab flavor8 \cr
   1 \tab 1 \tab 1 \tab 1 \tab 1 \tab 1 \tab 1 \tab 1 \tab 1 \tab 1 \cr
   2 \tab 2 \tab 1 \tab 1 \tab 1 \tab 0 \tab 0 \tab 0 \tab 1 \tab 1 \cr
   3 \tab 3 \tab 1 \tab 0 \tab 0 \tab 0 \tab 1 \tab 0 \tab 0 \tab 1 \cr
   4 \tab 4 \tab 1 \tab 0 \tab 0 \tab 1 \tab 1 \tab 0 \tab 1 \tab 0 \cr
   5 \tab 5 \tab 1 \tab 1 \tab 1 \tab 1 \tab 1 \tab 1 \tab 1 \tab 1 \cr
   6 \tab 6 \tab 1 \tab 1 \tab 1 \tab 1 \tab 1 \tab 0 \tab 1 \tab 1 \cr
   7 \tab 7 \tab 1 \tab 0 \tab 0 \tab 0 \tab 1 \tab 0 \tab 1 \tab 0 \cr
   8 \tab 8 \tab 1 \tab 0 \tab 0 \tab 0 \tab 0 \tab 1 \tab 0 \tab 0 \cr
   9 \tab 9 \tab 1 \tab 0 \tab 1 \tab 1 \tab 1 \tab 1 \tab 0 \tab 1 \cr
   10 \tab 10 \tab 1 \tab 0 \tab 1 \tab 0 \tab 1 \tab 1 \tab 1 \tab 1 \cr
}
}
\examples{

my_nested_list <- list(id=c(1,2,3,4,5),
weight=c(1,1,1,1,1),
choice1 = c(0,0,1,1,0),
choice2 = c(1,0,0,1,1),
choice3 = c(0,1,0,1,1),
choice4 = c(0,1,0,1,1),
choice5 = c(1,1,1,1,1))

catadat <-  as.data.frame(do.call(cbind, my_nested_list))

turfwaterfall(catadat)

}
