
#' fileStruct: A package for developing reproducable project structures
#'
#' The fileStruct package provides one main function, with some additional "helper"
#' functions for creating an organized workflows.
#'
#'
#' @section The fileStruct() function:
#' createFullProject() is the most important function here, and creates a file structure
#' based on the following link: https://julianreif.com/guide/
#'
#' Simply set a directory and run the function with your desired project name to
#' create a clean and efficient project structure.
#'
#'
#'
#' @docType package
#' @name fileStruct
NULL




#' projectCreate:
#'
#' @param name A character string
#' @return an r.proj of name "name"
#' @examples
#' projectCreate("My first project")
#' @export
projectCreate<- function(name){
  # Initialize R project
  readr::write_file(
    "Version: 1.0

RestoreWorkspace: Default
SaveWorkspace: Default
AlwaysSaveHistory: Default

EnableCodeIndexing: Yes
UseSpacesForTab: Yes
NumSpacesForTab: 2
Encoding: UTF-8

RnwWeave: Sweave
LaTeX: pdfLaTeX,", path = paste(name,".txt", sep = ""))

  path <- paste(name,"/", sep = "")

  file.rename(paste(name, ".txt", sep =''), paste(path,name,".rproj", sep = ""))
}



#' createSubdirectories:
#'
#' @param name A character string
#' @return a directory structure based on https://julianreif.com/guide/
#' @examples
#' createSubdirectories("My first project")
#' @export
createSubdirectories<- function(name){

  print(paste("Creating subdirectories for the following project:", name))

  dir.create(paste(name,"/", sep = ""))
  dir.create(paste(name,"/analysis/data", sep = ""), recursive = TRUE)
  dir.create(paste(name,"/analysis/processed", sep = ""), recursive = TRUE)
  dir.create(paste(name,"/analysis/results/figures", sep = ""), recursive = TRUE)
  dir.create(paste(name,"/analysis/results/tables", sep = ""), recursive = TRUE)
  dir.create(paste(name,"/analysis/scripts/libraries/R", sep = ""), recursive = TRUE)
  dir.create(paste(name,"/paper/figures", sep = ""), recursive = TRUE)
  dir.create(paste(name,"/paper/tables", sep = ""), recursive = TRUE)

}


#' scriptCreate:
#'
#' @param name A character string
#' @return a simple .R script in analysis/scripts
#' @examples
#' scriptCreate("My first project")
#' @export

scriptCreate <- function(name){
  script_path <- paste(paste(getwd(),"/",name,"/analysis/script1.R", sep = ""))

  readr::write_file("print(paste('Hello Project Creation!'))",
                    path = script_path )
}



#' fileMasterCreate:
#' create a .R script for sourcing example
#'
#' @param name A character string
#' @return a master .Rmd file for sourcing scripts
#' @examples
#' fileMasterCreate("My first project")
#' @export
fileMasterCreate <- function(name){
  readr::write_file(paste(

    "---
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

# .Rmd master file

## Setup/Titles:

This first section of code initializes the Rmd document for knitting.

- Default output is html_document
- Author based on system user
- Title is created by fileStructure::createFullProject()

```{r dynamic titles, include = FALSE}
 author_param <- ", "'",Sys.info()[["user"]],"'","\n",
    "date_param <-", "'",date(),"'", "\n","title_param<-", '"',name, '"',
    "\n```

---
title: `r title_param`
author: `r author_param`
date:  `r date_param`
---

## Idea
This file can be used to source different modules throughout the project.

Run the example below!

```{r source 1}
sys.source(paste(paste(getwd(),'/analysis/script1.R', sep = '')))
```

"

  ), path = paste(getwd(),"/",name,"/master.rmd", sep = ""))


}

#' createFullProject:
#' THE MOST IMPORTANT FUNCTION
#'
#' @param name A character string
#' @return An entire project directory structure
#' @examples
#' crearteFullProject("My first project")
#' @export
createFullProject <- function(name){

  createSubdirectories(name)
  scriptCreate(name)
  fileMasterCreate(name)
  projectCreate(name)
}



