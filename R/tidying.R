# Functions to read and clean the data

#' Extract Country from Location Name
#'
#' This helper function extracts the country name from the `Location.Name` column in the dataset.
#' If the location name contains a colon, it extracts the part before the colon.
#' If there is no colon, it returns the entire location name.
#' If the input is NA or non-character, it returns NA.
#'
#' @param location_name A character vector containing location names in the format "Country: Location".
#' @return A character vector with the country names extracted.
#' @examples
#' location_name <- c("Mexico: Acapulco")
#' extract_country(location_name)
#' @export
extract_country <- function(location_name) {
  ifelse(location_name == "" | is.na(location_name), NA,
    ifelse(grepl(":", location_name),
      sub(":.*", "", location_name),
      location_name
    )
  )
}


#' Clean Location Name and Extract Country
#'
#' The function cleans the `Location.Name` column by removing the country name and converting the location to title case.
#' If the location name contains a colon, it extracts the part after the colon.
#' If there is no colon, it returns NA.
#' If the input is NA or non-character, it returns NA.
#'
#' @param location A character vector containing location names in the format "Country: Location".
#' @return A character vector with the cleaned location names.
#' @examples
#' locations <- c("Mexico: Acapulco", "Japan: Tokyo", "Chile: Santiago")
#' eq_location_clean(locations)
#' @importFrom tools toTitleCase
#' @export
eq_location_clean <- function(location) {
  ifelse(is.na(location) | location == "", NA,
    ifelse(grepl(":", location),
      {
        cleaned_location <- sub("^[^:]*:", "", location) # Remove everything before the first colon
        cleaned_location <- trimws(cleaned_location) # Remove leading and trailing whitespace
        cleaned_location <- tolower(cleaned_location) # Convert to lowercase
        cleaned_location <- tools::toTitleCase(cleaned_location) # Convert to title case
        cleaned_location
      },
      NA
    )
  )
}


#' Clean NOAA Earthquake Data
#'
#' The function cleans the NOAA earthquake dataset by creating a date column, converting latitude and longitude to numeric, extracting country names, and cleaning location names.
#'
#' @param raw_data A data frame containing the raw NOAA earthquake data with the following required columns: Year, Mo, Dy, Latitude, Longitude, Location.Name, Hr, Mn, and Sec.
#' @return A cleaned data frame with additional columns and removed unnecessary columns.
#' @examples
#' \dontrun{
#' raw_data <- read.delim(system.file("extdata", "earthquakes.tsv",
#'   package = "earthquakes"
#' ), header = TRUE, sep = "\t")
#' cleaned_data <- eq_clean_data(raw_data)
#' head(cleaned_data)
#' }
#' @importFrom dplyr mutate select rename_all
#' @importFrom lubridate make_date
#' @importFrom rlang .data
#' @importFrom magrittr %>%
#' @export
#' @keywords internal
eq_clean_data <- function(raw_data = rlang::.data) {
  if (nrow(raw_data) == 0) {
    stop("There is no data")
  }
  required_columns <- c("Year", "Mo", "Dy", "Latitude", "Longitude", "Location.Name", "Deaths")
  missing_columns <- required_columns[!required_columns %in% colnames(raw_data)]
  if (length(missing_columns) > 0) {
    stop(paste("Dataframe must have columns:", paste(missing_columns, collapse = ", ")))
  }
  dat <- raw_data %>%
    dplyr::rename_all(~ toupper(gsub("\\.", "_", .))) %>% # Convert column names to uppercase and replace dots with underscores
    dplyr::mutate(
      DATE = lubridate::make_date(YEAR, MO, DY), # Create date column
      LATITUDE = as.numeric(LATITUDE), # Convert to numeric
      LONGITUDE = as.numeric(LONGITUDE), # Convert to numeric
      COUNTRY = extract_country(LOCATION_NAME), # Extract country
      LOCATION_NAME = eq_location_clean(LOCATION_NAME) # Clean location name
    ) %>%
    dplyr::select(-MO, -DY, -HR, -MN, -SEC) # Remove unnecessary columns
  return(dat)
}
