# Functions to create geom_timeline_label


#' GeomTimelineLabel: A Custom ggplot2 Geom for Adding Labels to Timeline Plots of Earthquakes
#'
#' This function creates a custom ggplot2 geom for adding labels to timeline plots of significant earthquakes.
#'
#' @param mapping Set of aesthetic mappings created by `aes()`. If specified and `inherit.aes = TRUE` (the default), it is combined with the default mapping at the top level of the plot. You must supply `mapping` if there is no plot mapping.
#' @param data The data to be displayed in this layer. There are three options:
#'   - If `NULL`, the default, the data is inherited from the plot data as specified in the call to `ggplot()`.
#'   - A `data.frame`, or other object, will override the plot data. All objects will be fortified to produce a data frame. See `fortify()` for which variables will be created.
#'   - A `function` will be called with a single argument, the plot data. The return value must be a `data.frame`, and will be used as the layer data.
#' @param stat The statistical transformation to use on the data for this layer, as a string.
#' @param position Position adjustment, either as a string, or the result of a call to a position adjustment function.
#' @param na.rm If `FALSE`, the default, missing values are removed with a warning. If `TRUE`, missing values are silently removed.
#' @param show.legend logical. Should this layer be included in the legends? `NA`, the default, includes if any aesthetics are mapped. `FALSE` never includes, and `TRUE` always includes.
#' @param inherit.aes If `FALSE`, overrides the default aesthetics, rather than combining with them. This is most useful for helper functions that define both data and aesthetics and shouldn't inherit behaviour from the default plot specification, e.g., `borders()`.
#' @param ... Other arguments passed on to `layer()`. These are often aesthetics, used to set an aesthetic to a fixed value, like `color = "red"` or `size = 3`.
#'
#' @return A ggplot2 layer.
#' @examples
#' library(ggplot2)
#' library(dplyr)
#'
#' # Example dataset
#' earthquakes <- data.frame(
#'   date = as.Date(c('2000-01-01', '2001-01-01', '2002-01-01')),
#'   magnitude = c(7.0, 6.5, 8.0),
#'   location = c('Place A', 'Place B', 'Place C')
#' )
#'
#' # Basic ggplot
#' ggplot(earthquakes, aes(x = date, y = magnitude, label = location)) +
#'   geom_timeline_label()
#'
#' @importFrom ggplot2 ggproto Geom aes layer
#' @importFrom dplyr arrange desc
#' @importFrom utils head
#' @importFrom grid segmentsGrob textGrob gTree gList gpar
#' @export
geom_timeline_label <- function(mapping = NULL,
                                data = NULL,
                                stat = "identity",
                                position = "identity",
                                na.rm = FALSE,
                                show.legend = NA,
                                inherit.aes = TRUE, ...) {

  ggplot2::layer(
    geom = GeomTimelineLabel,
    mapping = mapping,
    data = data,
    stat = stat,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(na.rm = na.rm, ...)
  )
}

#' GeomTimelineLabel: Internal ggproto object for custom timeline label geom
#'
#' This is an internal ggproto object that defines the custom timeline label geom for significant earthquakes. It should not be called directly, but instead used via the `geom_timeline_label` function.
#'
#' @format An object of class `ggproto` defining the custom timeline label geom.
#' @keywords internal
#' @importFrom ggplot2 ggproto Geom aes layer
#' @importFrom dplyr top_n
#' @importFrom grid textGrob polylineGrob gpar gList unit
GeomTimelineLabel <- ggplot2::ggproto(
  "GeomTimelineLabel", ggplot2::Geom,
  required_aes = c("x"),
  optional_aes = c('label', 'y', 'mag', 'color', 'alpha', 'n_max'),
  default_aes = ggplot2::aes(y = 0.3, n_max = 5, stroke = 1.0, size = 15, colour = "grey", fill = "grey", alpha = 0.4),
  draw_key = ggplot2::draw_key_point,
  draw_panel = function(data, panel_params, coord) {
    data <- data %>% dplyr::arrange(dplyr::desc(data$size))
    data <- utils::head(data, unique(data$n_max))
    coords <- coord$transform(data, panel_params)

    lines <- grid::segmentsGrob(
      x0 = coords$x,
      y0 = coords$y,
      x1 = coords$x,
      y1 = coords$y + 0.15,
      default.units = "npc",
      gp = grid::gpar(col = coords$colour, alpha = coords$alpha, fontsize = coords$size, lwd = coords$stroke)
    )

    texts <- grid::textGrob(
      label = coords$label,
      x = coords$x,
      y = coords$y + 0.15,
      just = "left",
      rot = 45,
      check.overlap = TRUE,
      default.units = "npc",
      gp = grid::gpar(col = coords$colour, fontsize = coords$size, lwd = coords$stroke)
    )

    grid::gTree(children = grid::gList(lines, texts))
  }
)
