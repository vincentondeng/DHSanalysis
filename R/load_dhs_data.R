#' Load DHS Data from a Specified Directory
#'
#' This function reads DHS data files from a given directory and returns a structured data frame.
#'
#' @param file_path A string specifying the full path to the DHS data file.
#' @param sheet Optional sheet name or number for Excel files (.xlsx and .xls).
#' @return A data frame containing the loaded DHS data.
#' @examples
#' load_dhs_data("C:/path/to/dhs_data.dta")
#' load_dhs_data("C:/path/to/excel_file.xlsx", sheet = 2)
#' load_dhs_data("C:/path/to/shapefile.shp")
#' @export
load_dhs_data <- function(file_path, sheet = NULL) {
  library(haven)  # For reading .dta, .sav, and .sas files
  library(readr)  # For reading .csv files
  library(readxl) # For reading .xls and .xlsx files
  library(dplyr)  # For data handling
  library(sf)     # For reading shapefiles

  # Check if file exists
  if (!file.exists(file_path)) {
    stop("Error: File not found. Please provide a valid file path.")
  }

  # Detect file extension
  file_extension <- tolower(tools::file_ext(file_path))
  message("Detected file extension: ", file_extension)

  # Load data based on file type
  if (file_extension == "dta") {
    message("Loading Stata (.dta) file...")
    data <- tryCatch({
      read_dta(file_path)
    }, error = function(e) {
      stop("Error: Failed to read .dta file. Ensure the file is not corrupted or in an unsupported format: ", e$message)
    })
  } else if (file_extension == "sav") {
    message("Loading SPSS (.sav) file...")
    data <- tryCatch({
      read_sav(file_path)
    }, error = function(e) {
      stop("Error: Failed to read .sav file. Ensure the file is not corrupted or in an unsupported format: ", e$message)
    })
  } else if (file_extension == "csv") {
    message("Loading CSV file...")
    data <- tryCatch({
      read_csv(file_path, show_col_types = FALSE)
    }, error = function(e) {
      stop("Error: Failed to read .csv file. Ensure the file is formatted correctly: ", e$message)
    })
  } else if (file_extension == "sas7bdat") {
    message("Loading SAS (.sas7bdat) file...")
    data <- tryCatch({
      read_sas(file_path)
    }, error = function(e) {
      stop("Error: Failed to read .sas7bdat file. Ensure the file is not corrupted or in an unsupported format: ", e$message)
    })
  } else if (file_extension %in% c("xls", "xlsx")) {
    message("Loading Excel (.xls or .xlsx) file...")
    data <- tryCatch({
      read_excel(file_path, sheet = sheet)
    }, error = function(e) {
      available_sheets <- tryCatch({
        excel_sheets(file_path)
      }, error = function(e) { return(NULL) })
      stop("Error: Failed to read .xls or .xlsx file. Available sheets: ", paste(available_sheets, collapse = ", "), " Ensure the file is formatted correctly: ", e$message)
    })
  } else if (file_extension == "shp") {
    message("Loading Shapefile (.shp) file...")
    data <- tryCatch({
      st_read(file_path, quiet = TRUE)
    }, error = function(e) {
      stop("Error: Failed to read .shp file. Ensure the file is not corrupted or in an unsupported format: ", e$message)
    })
  } else {
    stop("Unsupported file format. Supported formats: .dta, .sav, .csv, .sas7bdat, .xls, .xlsx, .shp")
  }

  # Convert to tibble if not spatial data
  if (!inherits(data, "sf")) {
    data <- as_tibble(data)
  }

  return(data)
}
