#' Calculates a transmission rate estimate
#'
#' @param treestr Tree string written in Newick format. The string argument
#' labels must be written in the following format: “Current Population
#' (Uppercase)” + “Previous Population (Lowercase)” + “ID number".
#' @param popnum Number of populations in the tree string.
#' @param popnames Names of populations in the tree string as a list.
#'
#' @return A transmission rate estimate between the populations listed in the
#' treestr parameter.
#' @export
#'
#' @import phybase
#' @import stringr
#'
#' @examples
#' treestr <- "(((Hc1:0.00402#0.01,Ch1:0.00402#0.01):0.00304#0.01,
#' Gc2:0.00707#0.01):0.00929#0.01,Cc2:0.01635#0.01)#0.01;"
#' popnum <- 3
#' popnames <- c("H","G","C")
#'
#' trans_rate_est(treestr,popnum,popnames)

trans_rate_est <- function(treestr,popnum,popnames) {

  names <- species.name(treestr)
  matrix <- as.data.frame(phybase::read.tree.nodes(treestr,names)$nodes)
  names <- as.data.frame(names)
  nrownames <- nrow(names)
  colnames(matrix) <- c("ancestor","son1","son2","brlen","theta","bootstrap","?")

  i <- 1
  repeat{
    if(matrix$son1[i] == "-9"){
      matrix$names[i] <- names[i,]
    }
    r <- (nrownames + 1) : nrow(matrix)
    matrix$names[r] <- "NA"


    if(i == nrownames){
      break
    }
    i <- i + 1
  } #Names col in matrix


  matrix$pop1 <- "NA"
  matrix$pop2 <- "NA"
  d <- 1
  repeat{
    if(str_detect(matrix$names[d], "[:upper:][:lower:]\\d")){

      pop1and2names <- (stringr::str_extract_all(matrix$names[d], "[:upper:][:lower:]\\d"))
      pop1name <- (stringr:: str_extract_all(pop1and2names, "[:upper:]"))
      matrix$pop1[d] <- pop1name
      pop2name <- (stringr::str_extract_all(pop1and2names, "[:lower:]"))
      matrix$pop2[d] <- toupper(pop2name)

    }
    if(d==nrow(matrix)){
      break
    }
    d <- d + 1

  } #Pops1 and pops2 cols in matrix

  transmatrix <- matrix[- grep("NA", matrix$names),]

  f <- 1
  repeat{
    pop <- subset(transmatrix, pop1 %in% popnames[f])
    divisor <- nrow(pop)
    g <- 1
    object1name <- paste("Population",popnames[f],sep=" ")

    repeat{
      subpop <- subset(pop, pop2 %in% popnames[g])
      dividend <- nrow(subpop)
      object2name <- paste("Population",popnames[g],sep=" ")
      num <- 100*(dividend / divisor)
      print(paste(num,"% of",object1name,"originated from",object2name,sep=" "))
      if(g==popnum){
        break
      }
      g <- g + 1
    }

    if(f == popnum){
      break
    }
    f <- f + 1
  } #Estimator
}
