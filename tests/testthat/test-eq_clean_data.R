# Test eq_clean_data function
source("setup.R")

test_that("eq_clean_data handles no data", {
  expect_error(eq_clean_data(data.frame()), "There is no data")
})

test_that("eq_clean_data handles missing columns", {
  # Create sample data
  data <- data.frame(
    Year = c(2020, 2021),
    Mo = c(1, 2),
    Dy = c(1, 2),
    #Latitude = c(40.7128, 37.7749),
    #Longitude = c(-74.0060, -122.4194),
    Location.Name = c("New York", "San Francisco"),
    Deaths = c(10, 5)
  )
  expect_error(eq_clean_data(data), "Dataframe must have columns: Latitude, Longitude")
})
