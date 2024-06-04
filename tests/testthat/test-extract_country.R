# Test extract_country function
library(testthat)

test_that("extract_country extracts the correct country", {
  expect_equal(extract_country("Mexico: Acapulco"), "Mexico")
  expect_equal(extract_country("Japan: Tokyo"), "Japan")
  expect_equal(extract_country("Chile: Santiago"), "Chile")
  expect_equal(extract_country("France"), "France")
  expect_equal(extract_country("ALASKA PENINSULA"), "ALASKA PENINSULA")
  expect_equal(extract_country("CHINA:  QINGHAI PROVINCE:  GANGHE-XINGHAI"), "CHINA")
})

test_that("extract_country handles missing values", {
  expect_equal(extract_country(NA), NA)
  expect_equal(extract_country(""), NA)
})
