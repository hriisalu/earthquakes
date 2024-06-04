# Test eq_location_clean function
library(testthat)

test_that("eq_location_clean extracts the correct location name", {
  expect_equal(eq_location_clean("Mexico: Acapulco"), "Acapulco")
  expect_equal(eq_location_clean("Japan: Tokyo"), "Tokyo")
  expect_equal(eq_location_clean("Chile: Santiago"), "Santiago")
  expect_equal(eq_location_clean("France"), NA)
  expect_equal(eq_location_clean("ALASKA PENINSULA"), NA)
  expect_equal(eq_location_clean("CHINA:  QINGHAI PROVINCE:  GANGHE-XINGHAI"), "Qinghai Province:  Ganghe-Xinghai")
})

test_that("eq_location_clean handles missing values", {
  expect_equal(eq_location_clean(NA), NA)
  expect_equal(eq_location_clean(""), NA)
})
