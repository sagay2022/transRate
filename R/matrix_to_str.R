#' Convert a Matrix to a Tree String
#' @description This function allows users to convert a matrix to a tree string in Newick format.
#' @param matrix A matrix containing columns:
#'
#' 1. ancestor
#'
#' 2. son1
#'
#' 3. son2
#'
#' 4. brlen
#'
#' 5. name
#' @seealso transRate:: sample_matrix
#'
#' @return A string containing the rooted tree string for the input matrix.
#' @export
#'
#' @examples
#' matrix <- transRate:: sample_matrix
#' matrix
#' matrix_to_string(matrix)
#'
matrix_to_string <- function(matrix) {
  rootnode <- nrow(matrix)
  names <- matrix$name
  treestr <- phybase::write.subtree(rootnode,matrix,names,rootnode)
  return(treestr)
}
