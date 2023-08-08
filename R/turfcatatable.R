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
#' @param catadat Required. Literal character string representing name of a file in the working directory readable using read.table(data, header=TRUE), or name of a data frame or matrix in R containing TURF data. Rows are individuals (respondents). Columns are (1) respondent identifier, (2) a weight variable, and a minimum of n columns containing only zeroes and ones, each representing an individual item in the TURF algorithm. Respondent identifiers need not be unique and weights need not sum to the total number of rows. In the absence of any weight variable, substitute a column of ones. Ones in the remaining columns indicate that the reach criterion was met for a given item by a given individual. Values other than zero or one in these columns (including NA) trigger an error. data may contain more than n + 2 columns, but any columns in addition to that number will be ignored.
#'
#' @export turfcatatable
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
#'
#' catadat <-  as.data.frame(do.call(cbind, my_nested_list))
#'
#' print(catadat)
#'
#' a <- turfcatatable(catadat)
#'
#' print(a)
#'
#' @returns Table of optimal combinations and their reach and frequencies
#'
#' @importFrom turfR turf
#' @importFrom stats na.omit
#'
#' @returns A table of optimal combinations as well as their reach and value.
#'

turfcatatable <- function(catadat) {

  #............................Old Code............................

  x <- catadat
  m <- dim(x)[2] - 2
  if (m < 17) {
    k <- m - 1
  }
  else{
    k <- 7
  }
  x <- as.data.frame(x)
  x <- na.omit(x)
  d <- dim(x)
  cat(d, "\n")
  Turfexam <- turf(x, m, 2:k)
  a <- matrix(0, m + 2, k - 1)
  dimnames(a) <- list(c("Reach", "Frequency", seq(1, m)), c(seq(2, k)))
  for (i in 1:(k - 1)) {
    a[, i] <- as.numeric(as.vector(Turfexam$turf[[i]][1, ])[2:(m + 3)])
  }
  b<-matrix(0,m,2)
  b[,1]<-seq(1,m)
  b[,2]<-apply(x[,3:(m+2)],2,sum)
  b<-b[rev(sort.list(b[,2])),]
  b<-cbind(b,c(1, rep(0,m-1)))
  b<-b[sort.list(b[,1]),]

  # ab<-cbind(b[,3],a[3:(m+2),])
  # dimnames(ab)[[2]][1]<-"1"

  #........New Code To Add Reach And Frequency To TURF Table.......

  reach1 <-  max(b[,2])/length(catadat[,1])

  bindex <- 0
  it <- 1
  for(oneorzero in b[,3]){
    if(oneorzero == 1){
      bindex=it
    }
    it <- it + 1
  }

  dataindex <- bindex + 2

  onecount <- 0
  for(oneorzero in catadat[,dataindex]){
    if(oneorzero == 1){
      onecount <- onecount + 1
    }
  }

  onecount <- onecount / length(catadat[,1])

  combo_one_column <- c(reach1,onecount,b[,3])

  ab<-cbind(combo_one_column,a[1:(m+2),])
  dimnames(ab)[[2]][1]<-"1"

  return(ab)
}
