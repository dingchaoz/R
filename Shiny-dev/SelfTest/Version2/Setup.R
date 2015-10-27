## Script to set up library, files to be sourced, functions to be used by other scripts


library(shiny)
library(RODBC)
library(RSQLServer)
library(ggplot2)

list.dirs <- function(path=".", pattern=NULL, all.dirs=FALSE,
                      full.names=FALSE, ignore.case=FALSE) {
  # use full.names=TRUE to pass to file.info
  all <- list.files(path, pattern, all.dirs,
                    full.names=TRUE, recursive=FALSE, ignore.case)
  dirs <- all[file.info(all)$isdir]
  # determine whether to return full names or just dir names
  if(isTRUE(full.names))
    return(dirs)
  else
    return(basename(dirs))
}

## Define the root directory of the scripts reside in
CodeDir <- "C:/Users/ks692/Documents/Dingchao/Courses/R/R Programming/Assignments/Shiny-dev/SelfTest/Version2"
# Set working directory to the above root
setwd(CodeDir)

# Source ListDir.R to use list.dirs function defined
#source("ListDir.R")
# Get all the folders in the root directory
AllFolders <- list.dirs(CodeDir)
# List all the R files in all the folders
file.sources = list.files(list.dirs(CodeDir),pattern="*.R$", full.names=TRUE,ignore.case=TRUE)
# Source all of them
sapply(file.sources,source,.GlobalEnv)