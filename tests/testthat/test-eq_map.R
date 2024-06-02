# Test eq_map function
source("setup.R")

sample_data <- data.frame(
  LOCATION_NAME = c("Acapulco", "Mexico City", "Oaxaca"),
  MAG = c(7.0, 6.5, 8.0),
  TOTAL_DEATHS = c(100, 50, 200),
  LONGITUDE = c(-99.9088, -99.1332, -96.7266),
  LATITUDE = c(16.8634, 19.4326, 17.0732),
  stringsAsFactors = FALSE,
  popup_text = c(
    "<b>Location: </b>Acapulco<br><b>Magnitude: </b>7<br><b>Total deaths: </b>100",
    "<b>Location: </b>Mexico City<br><b>Magnitude: </b>6.5<br><b>Total deaths: </b>50",
    "<b>Location: </b>Oaxaca<br><b>Magnitude: </b>8<br><b>Total deaths: </b>200"
  )
)

test_that("eq_map returns a leaflet map object", {
  map <- eq_map(sample_data, "popup_text")
  # expect_is(map, "leaflet")
  expect_true(inherits(map, "leaflet"))
})

test_that("eq_map adds the correct number of circles to the map", {
  map <- eq_map(sample_data, "popup_text")

  # Extract the layers from the map
  layers <- map$x$calls

  # Count the number of circles
  circle_layers <- sum(sapply(layers, function(call) {
    if (call$method == "addCircles") {
      return(length(call$args[[1]])) # Length of the data argument
    }
    return(0)
  }))

  expect_equal(circle_layers, nrow(sample_data))
})
