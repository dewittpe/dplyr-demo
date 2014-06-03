################################################################################
# file: strikes.R
# author: Peter DeWitt <peter.dewitt@ucdenver.edu>
# 
# For: data import of the FAAs wildlife strikes on aircraft since 1990.  The
# data can be downloaded from 
# http://www.faa.gov/airports/airport_safety/wildlife/database/
# The database is in Microsoft Access format.  There were only four tables in
# the DB.  Each table was exported to a csv file.  A data dictionary, in an
# Excel file, was also included in the download from faa.gov
#
# The data sets are going to be used as examples of working with dplyr and large
# data sets in R.  This file is the initial work towards a presentation on to be
# given at the Denver R User Group Meetup in June 2014.
#
# change log:
# 31 May 2014 - file created
#  1 Jun 2014 - building initial data import and dplyr examples
################################################################################

# ---------------------------------------------------------------------------- #
# set options and load needed packages
# ---------------------------------------------------------------------------- #
options(stringsAsFactors = FALSE,
        java.parameters = "-Xmx4096m",
        max.print = 1000)
library(XLConnect)
library(dplyr)

# ---------------------------------------------------------------------------- #
# Data loads
# ---------------------------------------------------------------------------- #
# There is a data dictionary provided in 
dd.wb           <- loadWorkbook(file = "data/read_me.xls")
data.dictionary <- readWorksheet(dd.wb, sheet = "Column Name")
engine.codes    <- readWorksheet(dd.wb, sheet = "Engine Codes", startRow = 3)
aircraft.type   <- readWorksheet(dd.wb, sheet = "Aircraft Type")
engine.position <- readWorksheet(dd.wb, sheet = "Engine Position")

# rename the columns in each of the data.frames above
names(data.dictionary) <- c("column", "explanation")
names(engine.codes)    <- tolower(names(engine.codes))
names(aircraft.type)   <- tolower(names(aircraft.type))
names(engine.position) <- tolower(names(engine.position))

# read in the civialian strike reports
strikes.90.99 <- read.csv("data/STRIKE_REPORTS (1990-1999).csv")
strikes.00.09 <- read.csv("data/STRIKE_REPORTS (2000-2009).csv")
strikes.10.14 <- read.csv("data/STRIKE_REPORTS (2010-Current).csv")
strikes.civ   <- rbind(strikes.90.99, strikes.00.09, strikes.10.14)

# military wildlife striks
strikes.mil <- read.csv("data/STRIKE_REPORTS_BASH (1990-Current).csv")

# create tbl_df verions of the data.frames
strikes.civ.tbl <- tbl_df(strikes.civ)
strikes.mil.tbl <- tbl_df(strikes.mil)

# ---------------------------------------------------------------------------- #




# ---------------------------------------------------------------------------- #
# end of file
# ---------------------------------------------------------------------------- #
