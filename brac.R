# Using horrible practices so you can see more of the language

url <- "http://archive.ics.uci.edu/ml/machine-learning-databases"
data.path <- "breast-cancer-wisconsin/breast-cancer-wisconsin.data"
names.path <- "breast-cancer-wisconsin/breast-cancer-wisconsin.names"

# Here's the paste function - it comes in handy quite often. sep is short for separate
data.location <- paste(url, data.path, sep = "/")

# Use R's base read.table function to pull the data from the archive
# it's comma-separated so specify that here - also there are no headers, we'll add those later
brac <- read.table(data.location, sep = ",", header = FALSE)

# Create a vector containing the names - don't worry about this stuff yet
# The attribute names are on lines 106-116 so I want to extract those and use regexpr
# to extract the names
raw <- readLines(file(paste(url, names.path, sep = "/")))[106:116]

# DON'T WORRY ABOUT UNDERSTANDING THE CODE BELOW!!!

# This function will help extract the attribute names using regular expressions
# The format of the names is i.e.
# 1. Sample code number               id number
# We want: sample.code.number
extract.names <- function(x){
  a <- paste(unlist(strsplit(tolower(
    unlist(strsplit(gsub("^ .*\\. ", "", x), split = "  "))[1]),split = " ")), 
    collapse = ".")
  a <- as.character(lapply(a, FUN = function(x) gsub(":", "", x))) # class attr has ":"
  return(a)
}

# Using the function above, we'll iterate over the vector of names using lapply
brac.names <- lapply(raw, FUN = extract.names)

# And finally we assign the names to the data set
colnames(brac) <- brac.names

View(brac)