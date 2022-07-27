#' Sample Data Set with 3 Clades
#'
#'@description This data set contains 3 clades geographically centered in Belgium, WA,USA, and Japan. This data set can serve as the df parameter in transRate::airplane_plot.
#'
#'@format A data with 148 rows and 9 variables:
#' \describe{
#' \item{clade}{the interger specifying which clade the sample in that row belongs to}
#' \item{name}{a string identifying each sample}
#' \item{nameabr}{a brief string that serves as an abreviation for the "name" variable of that row}
#' \item{country}{the sample's country of origin}
#' \item{continent}{the sample's continent of origin}
#' \item{timepoint}{the interger specifying which timepoint the sample in that row belongs to}
#' \item{location}{the sample's location of origin}
#' \item{longitude}{the sample's longitudinal position of origin}
#' \item{latitude}{the sample's latitudinal position of origin}
#' }
#' @source {Created by Skylar Ann Gay to serve as an example.}
#'
#' @examples
#' df <- sample_df
#' df
"sample_df"
