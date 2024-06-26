% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/tidying.R
\name{extract_country}
\alias{extract_country}
\title{Extract Country from Location Name}
\usage{
extract_country(location_name)
}
\arguments{
\item{location_name}{A character vector containing location names in the format "Country: Location".}
}
\value{
A character vector with the country names extracted.
}
\description{
This helper function extracts the country name from the \code{Location.Name} column in the dataset.
If the location name contains a colon, it extracts the part before the colon.
If there is no colon, it returns the entire location name.
If the input is NA or non-character, it returns NA.
}
\examples{
location_name <- c("Mexico: Acapulco")
extract_country(location_name)
}
