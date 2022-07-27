#' Sample Matrix
#'
#'@description This data set contains 2 populations named "1" and "2" and 4 individuals named "C1","C2","H1", and "H2". This data set can serve as the matrix parameter in transRate::matrix_to_string.
#'
#'@format A data with 7 rows and 9 variables:
#' \describe{
#' \item{ancestor}{the interger indicating the ancestoral node of the individual}
#' \item{son1}{the first descendant of the ancestoral node}
#' \item{son2}{the second descendant of the ancestoral node}
#' \item{brlen}{the branch thength of the individual}
#' \item{}{}
#' \item{}{}
#' \item{}{}
#' \item{pop}{the population that this individual belongs to}
#' \item{name}{the name of the individual}
#' }
#' @source {Created by Skylar Ann Gay to serve as an example.}
#'
#' @examples
#' matrix <- sample_matrix
#' matrix
"sample_matrix"
