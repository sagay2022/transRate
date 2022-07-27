#' Simulate Migration Events in the Coalescent
#'
#' @description This function allows users to simulate migration events in a coalescent. The migration rate is drawn from a binomial distribution using the migration_rate parameter.
#' @param migration_rate A numerical value containing the desired migration rate.
#' @param treestr A tree string, written in Newick format, containing the
#' coalescent to undergo the migration simulation.
#' @param popnames The names of populations in the tree as a list.
#' @param popnum The number of populations in the tree as an interger.
#'
#' @return Matrix containing the transformed populations and ancestral nodes.
#' @export
#'
#' @examples
#' treestr <- "(((H1:0.00402#0.01,C1:0.00402#0.01):0.00304#0.01,G2:0.00707#0.01):0.00929#0.01,C2:0.01635#0.01)#0.01;"
#' migration_rate <- 0.5
#' popnames <- c("H","C","G")
#' popnum <- 3
#' migration_sim(migration_rate,treestr,popnames,popnum)
#'
migration_sim <- function(migration_rate,treestr,popnames,popnum) {
  #read in coalescent simulation tree string using Phybase read.tree.nodes function
  name=phybase:: species.name(treestr)
  nodematrix=phybase:: read.tree.nodes(treestr,name)$nodes
  combined=phybase:: read.tree.nodes(treestr,name)
  nodematrix <- as.data.frame(nodematrix)
  colnames(nodematrix) <- c("ancestor","son1","son2","brlen","theta","bootstrap","?")

  #Subset
  nodematrix$pop <- cbind(nodematrix$pop, ifelse(nodematrix$son1 != "-9",nodematrix$pop == "NODE","TEST"))
  nodematrixsub <- subset(nodematrix, pop %in% "TEST")
  nodematrixsub$name <- combined$names
  x <- 1
  nodematrixsubnew <- data.frame()
  nodematrixsubnewx <- data.frame()
  nodematrixsub <- tibble::rownames_to_column(nodematrixsub)
  repeat{
    pop <- nodematrixsub %>%
      subset(str_detect(nodematrixsub$name, popnames[x]))
    pop$pop <- x
    nodematrixsub <- nodematrixsub[!rownames(nodematrixsub) %in% rownames(pop), ]

    y <- 1
    repeat{
      if(y==x){
        NULL
      } else if(y!=popnum){
        popnow <- pop
        z <- rbinom(1,nrow(popnow),migration_rate)
        migs <- dplyr:: sample_n(popnow, z)
        if(nrow(migs)>0){
          migs$pop <- y
        }
        rownames(popnow) <- NULL
        popnow <- tibble::column_to_rownames(popnow)
        rownames(migs) <- NULL
        migs <- tibble::column_to_rownames(migs)

        popnow <- popnow[!rownames(popnow) %in% rownames(migs), ]

        nodematrixsubnew <- rbind(nodematrixsubnew,popnow,migs)
      }

      if(y==popnum){
        break
        return(nodematrixsubnew)
      }
      y <- y+1
    }
    if(x==popnum){
      break
      return(nodematrixsubnew)
    }
    x <- x+1
  }

  nodes <- subset(nodematrix, !(nodematrix$pop %in% "TEST"))
  nodes$pop <- "<NA>"
  nodes$name <- "<NA>"

  transmatrix <- rbind(nodematrixsubnew,nodes)
  rownames(transmatrix) <- 1:nrow(transmatrix)

  rootnode <- nrow(transmatrix)
  nsp <- nrow(nodematrixsubnew)
  transmatrix <- phybase:: noclock2clock(rootnode,transmatrix,nsp)
  return(transmatrix)
}
