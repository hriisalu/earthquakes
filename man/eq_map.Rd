% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/mapping.R
\name{eq_map}
\alias{eq_map}
\title{Visualize Earthquake Epicenters on a Map}
\usage{
eq_map(data_map = rlang::.data, annot_col)
}
\arguments{
\item{data_map}{A data frame containing earthquake data with columns \code{LONGITUDE}, \code{LATITUDE}, and \code{MAG}.}

\item{annot_col}{A character string specifying the column name in \code{data_map} to be used for pop-up annotations.}
}
\value{
A Leaflet map with earthquake epicenters visualized as circles.
}
\description{
The function visualizes earthquake epicenters on a map using the Leaflet package, with circle sizes proportional to earthquake magnitudes and pop-up annotations displaying specified information.
}
\examples{
library(leaflet)

# Example dataset
earthquakes <- data.frame(
  LONGITUDE = c(-118.2437, -123.2620, 142.3690),
  LATITUDE = c(34.0522, 44.5646, 38.3210),
  MAG = c(7.0, 6.5, 8.0),
  LOCATION_NAME = c("Acapulco", "Mexico City", "Oaxaca"),
  TOTAL_DEATHS = c(100, 50, 200)
)

# Create labels for pop-ups
earthquakes$popup_text <- eq_create_label(earthquakes)

# Plot the earthquakes on the map
eq_map(earthquakes, "popup_text")
}
