# Functions to show the earthquake epicenters on a map

#' Create Labels for Earthquake Pop-Up Annotations
#'
#' The function creates labels for pop-up annotations in a Leaflet map, providing details about earthquake locations, magnitudes, and total deaths.
#'
#' @param data_create_label A data frame containing earthquake data with columns `LOCATION`, `MAG`, and `TOTAL_DEATHS`.
#'
#' @return A character vector with HTML strings for pop-up annotations.
#' @examples
#' # Example dataset
#' earthquakes <- data.frame(
#'   LOCATION_NAME = c("Acapulco", "Mexico City", "Oaxaca"),
#'   MAG = c(7.0, 6.5, 8.0),
#'   TOTAL_DEATHS = c(100, 50, 200)
#' )
#'
#' # Create labels for pop-ups
#' labels <- eq_create_label(earthquakes)
#' @importFrom rlang .data
#' @export
eq_create_label <- function(data_create_label = rlang::.data) {
  paste("<b>Location: </b>", data_create_label$LOCATION_NAME, "<br>",
    "<b>Magnitude: </b>", data_create_label$MAG, "<br>",
    "<b>Total deaths: </b>", data_create_label$TOTAL_DEATHS,
    sep = ""
  )
}

#' Visualize Earthquake Epicenters on a Map
#'
#' The function visualizes earthquake epicenters on a map using the Leaflet package, with circle sizes proportional to earthquake magnitudes and pop-up annotations displaying specified information.
#'
#' @param data_map A data frame containing earthquake data with columns `LONGITUDE`, `LATITUDE`, and `MAG`.
#' @param annot_col A character string specifying the column name in `data_map` to be used for pop-up annotations.
#'
#' @return A Leaflet map with earthquake epicenters visualized as circles.
#' @examples
#' library(leaflet)
#'
#' # Example dataset
#' earthquakes <- data.frame(
#'   LONGITUDE = c(-118.2437, -123.2620, 142.3690),
#'   LATITUDE = c(34.0522, 44.5646, 38.3210),
#'   MAG = c(7.0, 6.5, 8.0),
#'   LOCATION_NAME = c("Acapulco", "Mexico City", "Oaxaca"),
#'   TOTAL_DEATHS = c(100, 50, 200)
#' )
#'
#' # Create labels for pop-ups
#' earthquakes$popup_text <- eq_create_label(earthquakes)
#'
#' # Plot the earthquakes on the map
#' eq_map(earthquakes, "popup_text")
#' @importFrom leaflet leaflet addTiles addCircles
#' @importFrom rlang .data
#' @export
eq_map <- function(data_map = rlang::.data, annot_col) {
  # Using Leaflet to plot a map
  leaflet::leaflet(data_map) %>%
    leaflet::addTiles() %>%
    # Adding circles in each Earthquake point.
    leaflet::addCircles(
      lng = ~LONGITUDE,
      lat = ~LATITUDE,
      weight = 1,
      radius = ~ MAG * 10000,
      # Plotting a simple information inside of the popup.
      popup = ~ eval(parse(text = annot_col))
    ) -> map_to_plot

  # Returning the map with circles
  return(map_to_plot)
}
