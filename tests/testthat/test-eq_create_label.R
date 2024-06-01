# Test eq_create_label function
source("setup.R")

sample_data <- data.frame(
  LOCATION_NAME = c("Acapulco", "Mexico City", "Oaxaca"),
  MAG = c(7.0, 6.5, 8.0),
  TOTAL_DEATHS = c(100, 50, 200),
  stringsAsFactors = FALSE
)

test_that("eq_create_label generates correct label for a single row", {
  single_row <- sample_data[1, ]
  expected_label <- "<b>Location: </b>Acapulco<br><b>Magnitude: </b>7<br><b>Total deaths: </b>100"
  result <- eq_create_label(single_row)
  expect_equal(result, expected_label)
})


test_that("eq_create_label generates correct labels for multiple rows", {
  expected_labels <- c(
    "<b>Location: </b>Acapulco<br><b>Magnitude: </b>7<br><b>Total deaths: </b>100",
    "<b>Location: </b>Mexico City<br><b>Magnitude: </b>6.5<br><b>Total deaths: </b>50",
    "<b>Location: </b>Oaxaca<br><b>Magnitude: </b>8<br><b>Total deaths: </b>200"
  )
  results <- sapply(1:nrow(sample_data), function(i) eq_create_label(sample_data[i, ]))
  expect_equal(results, expected_labels)
})
