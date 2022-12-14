% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/trans_rate_est.R
\name{trans_rate_est}
\alias{trans_rate_est}
\title{Calculates a transmission rate estimate}
\usage{
trans_rate_est(treestr, popnum, popnames)
}
\arguments{
\item{treestr}{Tree string written in Newick format. The string argument
labels must be written in the following format: “Current Population
(Uppercase)” + “Previous Population (Lowercase)” + “ID number".}

\item{popnum}{Number of populations in the tree string.}

\item{popnames}{Names of populations in the tree string as a list.}
}
\value{
A transmission rate estimate between the populations listed in the
treestr parameter.
}
\description{
Calculates a transmission rate estimate
}
\examples{
treestr <- "(((Hc1:0.00402#0.01,Ch1:0.00402#0.01):0.00304#0.01,
Gc2:0.00707#0.01):0.00929#0.01,Cc2:0.01635#0.01)#0.01;"
popnum <- 3
popnames <- c("H","G","C")

trans_rate_est(treestr,popnum,popnames)
}
