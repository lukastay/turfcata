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
#' @param catadat CATA Dataframe
#'
#' @export turfcatatable
#'
#' @returns Table of optimal combinations and their reach and frequencies
#'
#' @importFrom turfR turf
#' @importFrom stats na.omit
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

  ab
}
