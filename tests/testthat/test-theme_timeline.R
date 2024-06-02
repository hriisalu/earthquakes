source("setup.R")

test_that("theme_timeline returns a ggplot theme", {
  theme <- theme_timeline()
  expect_s3_class(theme, "theme")
})

test_that("theme_timeline has the correct elements", {
  theme <- theme_timeline()

  expect_equal(theme$plot.background, element_blank())
  expect_equal(theme$panel.background, element_blank())
  expect_true(is.list(theme$axis.line.x))
  expect_equal(theme$axis.line.x$colour, "black")
  expect_equal(theme$axis.line.x$linewidth, 0.5)
  expect_equal(theme$axis.line.x$linetype, "solid")
  expect_equal(theme$legend.position, "bottom")
  expect_equal(theme$plot.margin, unit(c(4, 4, 0, 0), "cm"))
  expect_equal(theme$panel.spacing, unit(c(4, 4, 0, 0), "cm"))
})
