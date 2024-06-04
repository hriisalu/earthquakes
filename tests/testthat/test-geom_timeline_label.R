# Test geom_timeline_label functions
source("setup.R")

test_that("geom_timeline_label returns a ggplot layer", {
  layer <- geom_timeline_label()
  expect_s3_class(layer, "LayerInstance")
})

test_that("GeomTimelineLabel has correct required aesthetics", {
  expect_equal(GeomTimelineLabel$required_aes, c("x"))
})

sample_data <- data.frame(
  DATE = as.Date(c("1902-01-16", "1907-04-15", "1920-01-03", "1928-06-17")),
  COUNTRY = c("Mexico", "Mexico", "Mexico", "Mexico"),
  MAG = c(7.0, 8.3, 7.8, 7.7),
  DEATHS = c(2, 8, 648, 4),
  LABEL = c("A", "B", "C", "D"),
  stringsAsFactors = FALSE
)

test_that("geom_timeline_label can be added to a ggplot object", {
  plot <- ggplot2::ggplot(sample_data, aes(x = DATE, y = COUNTRY, size = MAG, colour = DEATHS)) +
    geom_timeline_label()
  expect_s3_class(plot, "ggplot")
})
