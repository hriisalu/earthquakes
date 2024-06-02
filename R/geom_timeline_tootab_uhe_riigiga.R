# Functions to create geom_timeline

#' GeomTimeline: A Custom ggplot2 Geom for Timeline Plots of Earthquakes
#'
#' The function creates a custom ggplot2 geom for plotting timelines of significant earthquakes. The size of the points represents the magnitude of the earthquakes.
#'
#' @param mapping Set of aesthetic mappings created by `aes()` or `aes_()`. If specified and `inherit.aes = TRUE` (the default), it is combined with the default mapping at the top level of the plot.
#' @param data The data to be displayed in this layer. There are three options:
#'   \itemize{
#'     \item If `NULL`, the default, the data is inherited from the plot data as specified in the call to `ggplot()`.
#'     \item A `data.frame`, or other object, will override the plot data. All objects will be fortified to produce a data frame. See `fortify()` for which variables will be created.
#'     \item A function will be called with a single argument, the plot data. The return value must be a `data.frame.`
#'   }
#' @param stat The statistical transformation to use on the data for this layer, as a string.
#' @param position Position adjustment, either as a string, or the result of a call to a position adjustment function.
#' @param na.rm If `FALSE`, the default, missing values are removed with a warning. If `TRUE`, missing values are silently removed.
#' @param show.legend logical. Should this layer be included in the legends? `NA`, the default, includes if any aesthetics are mapped. `FALSE` never includes, and `TRUE` always includes.
#' @param inherit.aes If `FALSE`, overrides the default aesthetics, rather than combining with them. This is most useful for helper functions that define both data and aesthetics and shouldn't inherit behavior from the default plot specification, e.g., `borders()`.
#' @param ... Other arguments passed on to `layer()`. These are often aesthetics, used to set an aesthetic to a fixed value, like `colour = "red"` or `size = 3`. They may also be parameters to the paired geom/stat.
#' @return A ggplot2 layer that can be added to a ggplot object to create a timeline plot of significant earthquakes.
#' @examples
#' \dontrun{
#' library(ggplot2)
#' data <- data.frame(
#'   x = as.Date("2020-01-01") + 0:4,
#'   size = c(4, 5, 6, 7, 8),
#'   colour = c("red", "blue", "green", "purple", "orange")
#' )
#' ggplot(data) +
#'   geom_timeline(aes(x = x, size = size, colour = colour))
#' }
#' @importFrom ggplot2 ggproto Geom aes layer
#' @importFrom grid circleGrob polylineGrob gpar gList unit
#' @export
geom_timeline <- function(mapping = NULL, data = NULL, stat = "identity",
                          position = "identity", na.rm = FALSE, show.legend = NA,
                          inherit.aes = TRUE, ...) {
  ggplot2::layer(
    geom = GeomTimeline, mapping = mapping, data = data, stat = stat,
    position = position, show.legend = show.legend, inherit.aes = inherit.aes,
    params = list(na.rm = na.rm, ...)
  )
}


#' GeomTimeline: Internal ggproto object for custom timeline geom
#'
#' This is an internal ggproto object that defines the custom timeline geom for significant earthquakes. It should not be called directly, but instead used via the `geom_timeline` function.
#'
#' @format An object of class `ggproto` defining the custom timeline geom.
#' @keywords internal
#' @importFrom ggplot2 ggproto Geom aes layer
#' @importFrom grid circleGrob polylineGrob gpar gList unit
GeomTimeline <- ggplot2::ggproto(
  "GeomTimeline", ggplot2::Geom,
  required_aes = c("x", "size", "colour"),
  default_aes = ggplot2::aes(y = 0.3, size = 1, colour = "grey", alpha = 0.6),
  draw_key = ggplot2::draw_key_point,
  draw_panel = function(data, panel_scales, coord, na.rm = FALSE) {
    if (na.rm) {
      data <- na.omit(data)
    }

    coords <- coord$transform(data, panel_scales)

    points <- grid::circleGrob(
      x = unit(coords$x, "npc"),
      y = unit(coords$y, "npc"),
      r = (2^coords$size) / 1000,
      gp = grid::gpar(
        col = coords$colour,
        fill = coords$colour,
        alpha = coords$alpha
      )
    )

    y_line_center <- unique(coords$y)

    lines <- grid::polylineGrob(
      x = unit(c(0, 1), "npc"),
      y = unit(c(y_line_center, y_line_center), "npc"),
      gp = grid::gpar(col = "grey")
    )

    return(grid::gList(points, lines))
  }
)
