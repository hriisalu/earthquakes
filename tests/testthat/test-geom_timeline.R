# Test geom_timeline functions
source("setup.R")

test_that("geom_timeline returns a ggplot layer", {
  layer <- geom_timeline()
  expect_s3_class(layer, "LayerInstance")
})

test_that("GeomTimeline has correct required aesthetics", {
  expect_equal(GeomTimeline$required_aes, c("x", "size", "colour"))
})

sample_data <- data.frame(
  DATE = as.Date(c("1902-01-16", "1907-04-15", "1920-01-03", "1928-06-17")),
  COUNTRY = c("Mexico", "Mexico", "Mexico", "Mexico"),
  MAG = c(7.0, 8.3, 7.8, 7.7),
  DEATHS = c(2, 8, 648, 4),
  stringsAsFactors = FALSE
)

test_that("geom_timeline creates a ggplot layer", {
  plot <- ggplot(sample_data, aes(x = DATE, y = COUNTRY, size = MAG, colour = DEATHS)) +
    geom_timeline()
  expect_s3_class(plot, "ggplot")
})
