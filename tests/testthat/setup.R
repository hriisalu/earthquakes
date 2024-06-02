# Libraries for testing
library(testthat)
library(dplyr)
library(grid)
suppressWarnings(library(leaflet))
library(earthquakes)

# Load ggplot2 without attaching it to the global environment
requireNamespace("ggplot2", quietly = TRUE)
