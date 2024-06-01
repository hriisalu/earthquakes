# Function to create theme for timeline plot

#' theme_timeline: A Custom ggplot2 Theme for Timeline Plots of Earthquakes
#'
#' This function creates a custom ggplot2 theme suitable for timeline plots of significant earthquakes.
#'
#' @return A ggplot2 theme object with customized settings for timeline plots.
#' @examples
#' \dontrun{
#' library(ggplot2)
#' data <- data.frame(
#'   x = as.Date('2020-01-01') + 0:4,
#'   size = c(4, 5, 6, 7, 8),
#'   colour = c("red", "blue", "green", "purple", "orange")
#' )
#' ggplot(data) +
#'   geom_timeline(aes(x = x, size = size, colour = colour)) +
#'   theme_time()
#' }
#' @importFrom ggplot2 theme element_blank element_line
#' @export
theme_timeline <- function() {
  theme(
    plot.background = element_blank(),
    panel.background = element_blank(),
    axis.line.x = element_line(colour = 'black', linewidth = 0.5, linetype = 'solid'),
    legend.position = "bottom",
    plot.margin = unit(c(4, 4, 0, 0), "cm"),
    panel.spacing = unit(c(4, 4, 0, 0), "cm")
  )
}
