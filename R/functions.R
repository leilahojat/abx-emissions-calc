# =============================================================================
# Antimicrobial Carbon Emissions Calculator
# File: R/functions.R
#
# Calculation functions for estimating CO2-equivalent GHG emissions from
# inpatient IV antimicrobial use. Intended for use with NHSN antimicrobial
# use (AU) module data or equivalent facility-level DOT data.
#
# Usage:
#   source("R/data.R")
#   source("R/functions.R")
#   result <- calculate_emissions("Vancomycin", dot = 875)
#
# Source: Hojat LS et al. Open Forum Infect Dis. 2025;12(10):ofaf308.
# =============================================================================


# ------------------------------------------------------------------------------
# calculate_emissions()
# ------------------------------------------------------------------------------
#' Estimate CO2-equivalent emissions for a single drug
#'
#' Looks up the emissions factor for the specified drug from antimicrobial_factors
#' and multiplies by the number of DOT to produce total CO2e and GHG
#' equivalencies.
#'
#' @param drug_name Character. Must match a value in antimicrobial_factors$drug_name.
#'   Case-sensitive. Use list_drugs() to see available names.
#' @param dot Numeric. Days of therapy (DOT). Must be non-negative.
#' @param units Character. Output CO2e units: "mt" (metric tons, default) or "kg".
#'
#' @return Named numeric vector with the following elements:
#'   co2e_mt        -- total CO2e in metric tons
#'   co2e_kg        -- total CO2e in kilograms
#'   waste_kg       -- total waste generated in kg
#'   miles_driven   -- GHG equivalency: miles driven (average passenger car)
#'   gallons_gas    -- GHG equivalency: gallons of gasoline consumed
#'   pounds_coal    -- GHG equivalency: pounds of coal burned
#'   phones_charged -- GHG equivalency: smartphones charged
#'
#' @examples
#' source("R/data.R")
#' source("R/functions.R")
#' calculate_emissions("Vancomycin", dot = 875)
calculate_emissions <- function(drug_name, dot, units = "mt") {
  
  # Input validation
  if (!is.character(drug_name) || length(drug_name) != 1) {
    stop("drug_name must be a single character string.")
  }
  if (!is.numeric(dot) || length(dot) != 1 || dot < 0) {
    stop("dot must be a single non-negative number.")
  }
  if (!units %in% c("mt", "kg")) {
    stop("units must be 'mt' (metric tons) or 'kg'.")
  }
  
  # Check that data frames are available
  if (!exists("antimicrobial_factors") || !exists("ghg_factors")) {
    stop(
      "Data frames not found. Please run source('R/data.R') before calling this function."
    )
  }
  
  # Look up emissions factor
  idx <- match(drug_name, antimicrobial_factors$drug_name)
  if (is.na(idx)) {
    stop(paste0(
      "Drug '", drug_name, "' not found in antimicrobial_factors.\n",
      "Run list_drugs() to see available drug names."
    ))
  }
  
  factor_mt <- antimicrobial_factors$co2e_per_dot_mt[idx]
  if (is.na(factor_mt)) {
    stop(paste0(
      "Emissions factor for '", drug_name, "' is not yet populated.\n",
      "Please add the per-DOT CO2e value from Supplementary Calculator Reference tab of\n",
      "Hojat et al., OFID 2025 (doi:10.1093/ofid/ofaf308) to antimicrobial_factors."
    ))
  }
  
  factor_waste <- antimicrobial_factors$waste_kg_per_dot[idx]
  
  # Calculate total CO2e and waste
  co2e_mt <- factor_mt * dot
  co2e_kg <- co2e_mt * 1000
  waste_kg <- factor_waste * dot
  
  # Apply GHG equivalency factors
  # Use direct indexing via match() to avoid name-propagation from named vectors,
  # which would cause downstream subsetting by name to return NA.
  ef <- function(label) {
    ghg_factors$mt_co2e_per_unit[match(label, ghg_factors$equivalency)]
  }
  
  result <- c(
    co2e_mt        = co2e_mt,
    co2e_kg        = co2e_kg,
    waste_kg       = waste_kg,
    miles_driven   = co2e_mt / ef("Miles driven (average passenger car)"),
    gallons_gas    = co2e_mt / ef("Gallons of gasoline consumed"),
    pounds_coal    = co2e_mt / ef("Pounds of coal burned"),
    phones_charged = co2e_mt / ef("Smartphones charged")
  )
  
  return(result)
}


# ------------------------------------------------------------------------------
# calculate_facility_emissions()
# ------------------------------------------------------------------------------
#' Calculate emissions for a facility-level antimicrobial use dataset
#'
#' Accepts a data frame of drug names and DOT counts (e.g., from an NHSN AU
#' module export) and returns per-drug and total facility emissions.
#'
#' @param usage_df Data frame with at minimum two columns:
#'   drug_name (character) -- must match antimicrobial_factors$drug_name
#'   dot (numeric)         -- days of therapy
#' @param units Character. "mt" or "kg".
#' @param warn_missing Logical. If TRUE (default), warns for drugs with
#'   unpopulated emissions factors rather than stopping.
#'
#' @return Data frame with all columns from usage_df plus:
#'   co2e_mt, co2e_kg, waste_kg, miles_driven, gallons_gas, pounds_coal, phones_charged
#'   A TOTAL row is appended at the bottom.
#'
#' @examples
#' source("R/data.R")
#' source("R/functions.R")
#' usage <- data.frame(
#'   drug_name = c("Vancomycin", "Ampicillin/sulbactam"),
#'   dot       = c(1200, 800)
#' )
#' calculate_facility_emissions(usage)
calculate_facility_emissions <- function(usage_df, units = "mt", warn_missing = TRUE) {
  
  # Validate input
  required_cols <- c("drug_name", "dot")
  missing_cols  <- setdiff(required_cols, names(usage_df))
  if (length(missing_cols) > 0) {
    stop(paste(
      "usage_df is missing required columns:",
      paste(missing_cols, collapse = ", ")
    ))
  }
  
  # Compute per-row emissions
  metric_names <- c("co2e_mt", "co2e_kg", "waste_kg", "miles_driven",
                    "gallons_gas", "pounds_coal", "phones_charged")
  
  row_results <- lapply(seq_len(nrow(usage_df)), function(i) {
    tryCatch(
      calculate_emissions(usage_df$drug_name[i], usage_df$dot[i], units),
      error = function(e) {
        if (warn_missing) {
          warning(paste("Row", i, "(", usage_df$drug_name[i], "):", conditionMessage(e)))
        }
        return(setNames(rep(NA_real_, length(metric_names)), metric_names))
      }
    )
  })
  
  # Append metric columns to output data frame
  out <- usage_df
  for (m in metric_names) {
    out[[m]] <- sapply(row_results, function(r) r[m])
  }
  
  # Append totals row
  total_row <- out[1, , drop = FALSE]
  rownames(total_row) <- NULL
  total_row[1, "drug_name"] <- "TOTAL"
  total_row[1, "dot"] <- sum(out$dot, na.rm = TRUE)
  for (m in metric_names) {
    total_row[1, m] <- sum(out[[m]], na.rm = TRUE)
  }
  
  out <- rbind(out, total_row)
  rownames(out) <- NULL
  return(out)
}


# ------------------------------------------------------------------------------
# list_drugs()
# ------------------------------------------------------------------------------
#' List drugs available in the calculator with their emissions factor status
#'
#' @return Data frame showing drug names, routes, and whether the emissions
#'   factor has been populated.
#'
#' @examples
#' source("R/data.R")
#' source("R/functions.R")
#' list_drugs()
list_drugs <- function() {
  if (!exists("antimicrobial_factors")) {
    stop("antimicrobial_factors not found. Please run source('R/data.R') first.")
  }
  out <- antimicrobial_factors[, c("drug_name", "nhsn_name", "route",
                                "co2e_per_dot_mt", "co2e_per_dot_kg", 
                                "waste_kg_per_dot")]
  out$factor_available <- !is.na(out$co2e_per_dot_mt)
  return(out)
}


# ------------------------------------------------------------------------------
# summarize_emissions()
# ------------------------------------------------------------------------------
#' Print a human-readable emissions summary
#'
#' @param emissions_result Named numeric vector from calculate_emissions().
#' @param drug_name Character (optional). Drug name for the header.
#' @param dot Numeric (optional). DOT count for the header.
#'
#' @return Invisibly returns the input vector.
#'
#' @examples
#' source("R/data.R")
#' source("R/functions.R")
#' result <- calculate_emissions("Vancomycin", 875)
#' summarize_emissions(result, drug_name = "Vancomycin", dot = 875)
summarize_emissions <- function(emissions_result, drug_name = NULL, dot = NULL) {
  if (!is.null(drug_name) && !is.null(dot)) {
    cat(sprintf(
      "\n--- Antimicrobial Emissions Estimate ---\n%s: %s DOT\n",
      drug_name, format(dot, big.mark = ",")
    ))
  }
  cat(sprintf("\nCO2e (metric tons): %.8f\n", emissions_result["co2e_mt"]))
  cat(sprintf("CO2e (kg):          %.4f\n",   emissions_result["co2e_kg"]))
  cat(sprintf("Waste generated (kg): %.3f\n", emissions_result["waste_kg"]))
  cat(sprintf("\nGHG equivalencies:\n"))
  cat(sprintf("  Miles driven (avg. passenger car): %.1f\n",  emissions_result["miles_driven"]))
  cat(sprintf("  Gallons of gasoline consumed:      %.1f\n",  emissions_result["gallons_gas"]))
  cat(sprintf("  Pounds of coal burned:             %.1f\n",  emissions_result["pounds_coal"]))
  cat(sprintf("  Smartphones charged:               %.0f\n",  emissions_result["phones_charged"]))
  cat(sprintf("\nSource: Hojat et al., Open Forum Infect Dis. 2025;12(10):ofaf308.\n"))
  invisible(emissions_result)
}
