# =============================================================================
# Antimicrobial Carbon Emissions Calculator
# File: R/data.R
#
# Two data frames used by the Antimicrobial Carbon Emissions calculator:
#   antibiotic_factors  -- CO2e per day of therapy (DOT) for each drug
#   ghg_factors         -- GHG equivalency conversion factors
#
# Scope: End-of-life emissions only (packaging, preparation, and
# administration waste). These values reflect disposal of single-use
# materials and do not include drug manufacturing, shipping, or upstream
# supply chain emissions. Full cradle-to-grave values are in development
# under a companion research program.
#
# Primary source:
#   Hojat LS, Veltri C, Newman NJ, et al. Development of a Novel Carbon
#   Emissions Estimation Tool for Disposable Waste Associated With
#   Antimicrobial Packaging, Preparation, and Administration in the Hospital
#   Setting. Open Forum Infect Dis. 2025;12(10):ofaf308.
#   https://doi.org/10.1093/ofid/ofaf308
#
# Emissions factors: Supplementary Table 6, Hojat et al. OFID 2025
# GHG equivalency factors: U.S. EPA GHG Emission Factors Hub (2024)
#   https://www.epa.gov/climateleadership/ghg-emission-factors-hub
# =============================================================================


# ------------------------------------------------------------------------------
# antibiotic_factors
# ------------------------------------------------------------------------------
# drug_name       : Drug name as used in the calculator
# nhsn_name       : Name as it appears in NHSN antimicrobial use (AU) data
# route           : Route of administration ("IV" or "PO")
# co2e_per_dot_mt : CO2-equivalent GHG emissions per day of therapy (DOT),
#                   in metric tons CO2e. Based on average materials at two
#                   large academic medical centers (Cleveland, OH and
#                   Salt Lake City, UT).
# source          : Data source
#
# Note: Values marked NA_real_ are present in the DOT Calculator but require
# population from Supplementary Table 6 of Hojat et al. OFID 2025.
# The supplementary Excel file is available at the journal website.
# The vancomycin value is confirmed from Figure 2B of the paper
# (875 DOT = 0.0224421300 metric tons CO2e; per-DOT rate derived from this).

antibiotic_factors <- data.frame(
  drug_name = c(
    "Acyclovir",
    "Amikacin",
    "Amphotericin B liposomal",
    "Ampicillin",
    "Ampicillin-sulbactam",
    "Azithromycin",
    "Aztreonam",
    "Caspofungin",
    "Cefazolin",
    "Cefepime",
    "Cefiderocol",
    "Cefoxitin",
    "Ceftaroline",
    "Ceftazidime",
    "Ceftazidime-avibactam",
    "Ceftolozane-tazobactam",
    "Ceftriaxone",
    "Cefuroxime",
    "Ciprofloxacin",
    "Clindamycin",
    "Colistimethate",
    "Daptomycin",
    "Doxycycline",
    "Ertapenem",
    "Erythromycin",
    "Fluconazole",
    "Ganciclovir",
    "Gentamicin",
    "Imipenem-cilastatin",
    "Isavuconazonium",
    "Levofloxacin",
    "Linezolid",
    "Meropenem",
    "Meropenem-vaborbactam",
    "Metronidazole",
    "Micafungin",
    "Minocycline",
    "Nafcillin",
    "Penicillin",
    "Pentamidine",
    "Piperacillin-tazobactam",
    "Posaconazole",
    "Remdesivir",
    "Rifampin",
    "Sulfamethoxazole-trimethoprim",
    "Tigecycline",
    "Vancomycin"
  ),
  nhsn_name = c(
    "Acyclovir",
    "Amikacin",
    "Amphotericin B liposomal",
    "Ampicillin",
    "Ampicillin-sulbactam",
    "Azithromycin",
    "Aztreonam",
    "Caspofungin",
    "Cefazolin",
    "Cefepime",
    "Cefiderocol",
    "Cefoxitin",
    "Ceftaroline",
    "Ceftazidime",
    "Ceftazidime-avibactam",
    "Ceftolozane-tazobactam",
    "Ceftriaxone",
    "Cefuroxime",
    "Ciprofloxacin",
    "Clindamycin",
    "Colistimethate",
    "Daptomycin",
    "Doxycycline",
    "Ertapenem",
    "Erythromycin",
    "Fluconazole",
    "Ganciclovir",
    "Gentamicin",
    "Imipenem-cilastatin",
    "Isavuconazonium",
    "Levofloxacin",
    "Linezolid",
    "Meropenem",
    "Meropenem-vaborbactam",
    "Metronidazole",
    "Micafungin",
    "Minocycline",
    "Nafcillin",
    "Penicillin",
    "Pentamidine",
    "Piperacillin-tazobactam",
    "Posaconazole",
    "Remdesivir",
    "Rifampin",
    "Sulfamethoxazole-trimethoprim",
    "Tigecycline",
    "Vancomycin"
  ),
  route = rep("IV", 14),
  co2e_per_dot_mt = c(
    NA_real_,       # Acyclovir           -- see Supp. Table 6
    NA_real_,       # Amikacin            -- see Supp. Table 6
    NA_real_,       # Amphotericin B lip. -- see Supp. Table 6
    NA_real_,       # Ampicillin          -- see Supp. Table 6
    NA_real_,       # Ampicillin-sul.     -- see Supp. Table 6
    NA_real_,       # Azithromycin        -- see Supp. Table 6
    NA_real_,       # Aztreonam           -- see Supp. Table 6
    NA_real_,       # Caspofungin         -- see Supp. Table 6
    NA_real_,       # Cefazolin           -- see Supp. Table 6
    NA_real_,       # Cefepime            -- see Supp. Table 6
    NA_real_,       # Cefiderocol         -- see Supp. Table 6
    NA_real_,       # Cefoxitin           -- see Supp. Table 6
    NA_real_,       # Ceftaroline         -- see Supp. Table 6
    NA_real_,       # Ceftazidime         -- see Supp. Table 6
    NA_real_,       # Ceftazidime-avi.    -- see Supp. Table 6
    NA_real_,       # Ceftolozane-tazo.   -- see Supp. Table 6
    NA_real_,       # Ceftriaxone         -- see Supp. Table 6
    NA_real_,       # Cefuroxime          -- see Supp. Table 6
    NA_real_,       # Ciprofloxacin       -- see Supp. Table 6
    NA_real_,       # Clindamycin         -- see Supp. Table 6
    NA_real_,       # Colistimethate      -- see Supp. Table 6
    NA_real_,       # Daptomycin          -- see Supp. Table 6
    NA_real_,       # Doxycycline         -- see Supp. Table 6
    NA_real_,       # Ertapenem           -- see Supp. Table 6
    NA_real_,       # Erythromycin        -- see Supp. Table 6
    NA_real_,       # Fluconazole         -- see Supp. Table 6
    NA_real_,       # Ganciclovir         -- see Supp. Table 6
    NA_real_,       # Gentamicin          -- see Supp. Table 6
    NA_real_,       # Imipenem-cilastatin -- see Supp. Table 6
    NA_real_,       # Isavuconazonium     -- see Supp. Table 6
    NA_real_,       # Levofloxacin        -- see Supp. Table 6
    NA_real_,       # Linezolid           -- see Supp. Table 6
    NA_real_,       # Meropenem           -- see Supp. Table 6
    NA_real_,       # Meropenem-vabor.    -- see Supp. Table 6
    NA_real_,       # Metronidazole       -- see Supp. Table 6
    NA_real_,       # Micafungin          -- see Supp. Table 6
    NA_real_,       # Minocycline         -- see Supp. Table 6
    NA_real_,       # Nafcillin           -- see Supp. Table 6
    NA_real_,       # Penicillin          -- see Supp. Table 6
    NA_real_,       # Pentamidine         -- see Supp. Table 6
    NA_real_,       # Piperacillin-tazo.  -- see Supp. Table 6
    NA_real_,       # Posaconazole        -- see Supp. Table 6
    NA_real_,       # Remdesivir          -- see Supp. Table 6
    NA_real_,       # Rifampin            -- see Supp. Table 6
    NA_real_,       # SMX-TMP             -- see Supp. Table 6
    NA_real_,       # Tigecycline         -- see Supp. Table 6
    2.564814857e-05 # Vancomycin -- Hojat et al. Fig 2B: 875 DOT = 0.0224421300 mt CO2e
    #              back-calculated: 0.0224421300 / 875
  ),
  source = rep(
    "Hojat et al., Open Forum Infect Dis. 2025;12(10):ofaf308. Supplementary Table 6.",
    14
  ),
  stringsAsFactors = FALSE
)

# Convenience column: kg CO2e per DOT (multiply metric tons by 1000)
antibiotic_factors$co2e_per_dot_kg <- antibiotic_factors$co2e_per_dot_mt * 1000


# ------------------------------------------------------------------------------
# ghg_factors
# ------------------------------------------------------------------------------
# GHG equivalency conversion factors from U.S. EPA Emission Factors Hub (2024).
# factor_per_mt_co2e : how many units of the equivalency equal 1 metric ton CO2e
#
# Factors derived from Figure 2B, Hojat et al. OFID 2025:
#   875 DOT vancomycin = 0.0224421300 metric tons CO2e
#                      = 57.39675 miles driven
#                      = 2.52528 gallons of gasoline
#                      = 24.74325 pounds of coal
#                      = 1486.23377 smartphones charged
# Back-calculated per-metric-ton rates are used here.

ghg_factors <- data.frame(
  equivalency = c(
    "Miles driven (average passenger car)",
    "Gallons of gasoline consumed",
    "Pounds of coal burned",
    "Smartphones charged"
  ),
  factor_per_mt_co2e = c(
    2557.8,    # miles per metric ton CO2e
    112.5,     # gallons per metric ton CO2e
    1102.6,    # pounds coal per metric ton CO2e
    66227.0    # phones per metric ton CO2e
  ),
  unit = c(
    "miles",
    "gallons",
    "pounds",
    "phones"
  ),
  source = rep(
    "U.S. EPA GHG Emission Factors Hub (2024); Hojat et al. OFID 2025 Fig. 2B.",
    4
  ),
  stringsAsFactors = FALSE
)
