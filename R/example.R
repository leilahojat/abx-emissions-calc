# =============================================================================
# Antimicrobial Carbon Emissions Calculator
# File: R/example.R
#
# Worked example reproducing the vancomycin calculation from Figure 2B of:
#   Hojat LS, Veltri C, Newman NJ, et al.
#   Open Forum Infect Dis. 2025;12(10):ofaf308.
#   https://doi.org/10.1093/ofid/ofaf308
#
# The example is based on a real stewardship intervention:
#   A pharmacy-initiated MRSA nasal PCR protocol reduced vancomycin use
#   by approximately 875 DOT at one institution (Thayer et al.,
#   Antibiotics (Basel). 2024;13:1195).
#
# Published result (Hojat et al., Fig. 2B):
#   875 DOT IV vancomycin = 0.0224421300 metric tons CO2e
#                         = 57.4 miles driven
#                         = 2.5 gallons of gasoline consumed
#                         = 24.7 pounds of coal burned
#                         = 1486 smartphones charged
#
# Running this file:
#   Rscript R/example.R
#   or, from an R session with working directory at the repo root:
#   source("R/example.R")
# =============================================================================

# Load data and functions
# Run from the repo root (ecorxchoice-calculator/) or set your working
# directory there before sourcing:
#   setwd("/path/to/ecorxchoice-calculator")
#   source("R/example.R")
source("R/data.R")
source("R/functions.R")


# =============================================================================
# EXAMPLE 1: Single-drug calculation -- Vancomycin
# Reproduces Figure 2B, Hojat et al. OFID 2025
# =============================================================================

cat("=============================================================\n")
cat("Antimicrobial Emissions Calculator Worked Example\n")
cat("Reproducing Hojat et al., OFID 2025, Figure 2B\n")
cat("=============================================================\n\n")

vancomycin_dot <- 875

result_vanco <- calculate_emissions(
  drug_name = "Vancomycin",
  dot       = vancomycin_dot
)

summarize_emissions(result_vanco, drug_name = "Vancomycin IV", dot = vancomycin_dot)


# ------------------------------------------------------------------------------
# Validation: compare against published values from Figure 2B
# ------------------------------------------------------------------------------
cat("--- Validation against published values (Hojat et al. Fig 2B) ---\n\n")

published <- c(
  co2e_mt        = 0.0224421300,
  miles_driven   = 57.39675,
  gallons_gas    = 2.52528,
  pounds_coal    = 24.74325,
  phones_charged = 1486.23377
)

check_fields <- names(published)
tolerance    <- list(
  co2e_mt        = 1e-5,
  miles_driven   = 0.1,
  gallons_gas    = 0.05,
  pounds_coal    = 0.1,
  phones_charged = 1.0
)

all_pass <- TRUE
for (field in check_fields) {
  diff   <- abs(result_vanco[field] - published[field])
  tol    <- tolerance[[field]]
  status <- if (diff <= tol) "PASS" else "WARN"
  if (status == "WARN") all_pass <- FALSE
  cat(sprintf(
    "  [%s] %-22s  calculated: %10.5f  published: %10.5f  diff: %.2e\n",
    status, field,
    result_vanco[field], published[field], diff
  ))
}

cat("\n")
if (all_pass) {
  cat("All values match published results within tolerance. Validation passed.\n\n")
} else {
  cat("One or more values exceed tolerance. Check antibiotic_factors and ghg_factors in data.R.\n\n")
}


# =============================================================================
# EXAMPLE 2: Facility-level calculation
# Hypothetical quarterly stewardship program report
# (only vancomycin is fully populated in this version; other drugs
#  require values from Supplementary Table 6, Hojat et al. OFID 2025)
# =============================================================================

cat("=============================================================\n")
cat("Facility-Level Example: Quarterly Antimicrobial Use\n")
cat("(Vancomycin only -- other factors pending Supp. Table 6)\n")
cat("=============================================================\n\n")

# Example: quarterly DOT data from an NHSN AU module export
# In practice, import this from a CSV or NHSN line listing report
quarterly_use <- data.frame(
  drug_name = c("Vancomycin"),
  dot       = c(1450),
  quarter   = c("Q1 FY2025"),
  stringsAsFactors = FALSE
)

facility_result <- calculate_facility_emissions(quarterly_use)

# Display selected columns
display_cols <- c("drug_name", "dot", "co2e_mt", "co2e_kg",
                  "miles_driven", "phones_charged")
print(facility_result[, display_cols], row.names = FALSE)

cat(sprintf(
  "\nTotal quarterly vancomycin-associated CO2e: %.4f metric tons (%.2f kg)\n",
  facility_result[facility_result$drug_name == "TOTAL", "co2e_mt"],
  facility_result[facility_result$drug_name == "TOTAL", "co2e_kg"]
))
cat(sprintf(
  "Equivalent to %.0f miles driven by an average passenger car.\n\n",
  facility_result[facility_result$drug_name == "TOTAL", "miles_driven"]
))

cat("To add additional drugs: populate co2e_per_dot_mt values in R/data.R\n")
cat("using Supplementary Table 6 from doi:10.1093/ofid/ofaf308\n\n")


# =============================================================================
# EXAMPLE 3: Interpreting an IV-to-PO switch intervention
# Avoided emissions from converting vancomycin DOT to oral linezolid
# (illustrative -- oral linezolid factor requires cradle-to-grave LCA data
#  not yet available in this version)
# =============================================================================

cat("=============================================================\n")
cat("Illustrative: Avoided Emissions from IV-to-PO Switch\n")
cat("(Requires oral drug factors -- placeholder for future version)\n")
cat("=============================================================\n\n")

# DOT reduction from a hypothetical IV vancomycin restriction intervention
avoided_dot_iv <- 200   # DOT of IV vancomycin avoided

avoided_emissions <- calculate_emissions("Vancomycin", dot = avoided_dot_iv)

cat(sprintf(
  "Avoiding %d DOT of IV vancomycin is estimated to prevent:\n",
  avoided_dot_iv
))
cat(sprintf("  %.6f metric tons CO2e\n",   avoided_emissions["co2e_mt"]))
cat(sprintf("  equivalent to %.1f miles driven\n\n", avoided_emissions["miles_driven"]))
cat("Note: Full IV-to-PO emissions comparison requires cradle-to-grave LCA\n")
cat("data for oral formulations, which are in development (v2.0).\n\n")
