\name{turfcatatable}
\alias{turfcatatable}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{~~ Dummy title ~~}
\description{~~ Dummy description ~~}
\usage{
turfcatatable(catadat)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{catadat}{
%%     ~~Describe \code{catadat} here~~
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
}
\references{
%% ~put references to the literature/web site here ~
}
\author{
%%  ~~who you are~~
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{
##---- Should be DIRECTLY executable !! ----
##-- ==>  Define data, use random,
##--	or do  help(data=index)  for the standard data sets.

## The function is currently defined as
function (catadat) 
{
    x <- catadat
    m <- dim(x)[2] - 2
    if (m < 17) {
        k <- m - 1
    }
    else {
        k <- 7
    }
    x <- as.data.frame(x)
    x <- na.omit(x)
    d <- dim(x)
    cat(d, "\n")
    Turfexam <- turf(x, m, 2:k)
    a <- matrix(0, m + 2, k - 1)
    dimnames(a) <- list(c("Reach", "Frequency", seq(1, m)), c(seq(2, 
        k)))
    for (i in 1:(k - 1)) {
        a[, i] <- as.numeric(as.vector(Turfexam$turf[[i]][1, 
            ])[2:(m + 3)])
    }
    b <- matrix(0, m, 2)
    b[, 1] <- seq(1, m)
    b[, 2] <- apply(x[, 3:(m + 2)], 2, sum)
    b <- b[rev(sort.list(b[, 2])), ]
    b <- cbind(b, c(1, rep(0, m - 1)))
    b <- b[sort.list(b[, 1]), ]
    reach1 <- max(b[, 2])/length(catadat[, 1])
    bindex <- 0
    it <- 1
    for (oneorzero in b[, 3]) {
        if (oneorzero == 1) {
            bindex = it
        }
        it <- it + 1
    }
    dataindex <- bindex + 2
    onecount <- 0
    for (oneorzero in catadat[, dataindex]) {
        if (oneorzero == 1) {
            onecount <- onecount + 1
        }
    }
    onecount <- onecount/length(catadat[, 1])
    combo_one_column <- c(reach1, onecount, b[, 3])
    ab <- cbind(combo_one_column, a[1:(m + 2), ])
    dimnames(ab)[[2]][1] <- "1"
    return(ab)
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory (show via RShowDoc("KEYWORDS")):
% \keyword{ ~kwd1 }
% \keyword{ ~kwd2 }
% Use only one keyword per line.
% For non-standard keywords, use \concept instead of \keyword:
% \concept{ ~cpt1 }
% \concept{ ~cpt2 }
% Use only one concept per line.
