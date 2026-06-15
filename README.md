# Antimicrobial Carbon Emissions Calculator

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

The **Antimicrobial Carbon Emissions Calculator** is an open-source tool for 
estimating carbon dioxide equivalent (CO2e) greenhouse gas (GHG) emissions 
associated with intravenous (IV) antimicrobial use in the hospital setting. It 
translates days of therapy (DOT) data (standard antimicrobial use (AU) unit 
collected by antimicrobial stewardship programs through the CDC's National 
Healthcare Safety Network (NHSN) AU module) into CO2-equivalent emissions and
interpretable CO2 equivalencies.

The tool was developed by antimicrobial stewardship physicians and pharmacists 
at University Hospitals Cleveland Medical Center and University of Utah 
Hospital. The web-based version is publicly available at 
**[ecorxchoice.com](https://ecorxchoice.com)**.

---

## What this repository contains

```
├── R/
│   ├── data.R        # Emissions factors and GHG equivalency data frames
│   ├── functions.R   # Calculation functions
│   └── example.R     # Worked example reproducing the published result
├── README.md
├── LICENSE
└── CITATION.md
```

**R/data.R** defines two data frames:
- `antibiotic_factors` -- CO2e emissions per DOT for each
  antimicrobial agent (metric tons CO2e per DOT), derived from the published
  supplementary data
- `ghg_factors` -- CO2e conversion factors from the U.S. EPA
  GHG Emission Factors Hub, enabling translation of CO2e values into miles
  driven, gallons of gasoline, pounds of coal, and smartphones charged

**R/functions.R** provides:
- `calculate_emissions()` -- single-drug calculation
- `calculate_facility_emissions()` -- multi-drug facility-level calculation
  from a data frame (e.g., an NHSN AU module export)
- `list_drugs()` -- shows available drugs and factor status
- `summarize_emissions()` -- prints a formatted summary

**R/example.R** reproduces the vancomycin calculation from Figure 2B of
Hojat et al., OFID 2025 and includes a validation check against the
published values.

---

## Quick start

```r
# Set working directory to the repo root, then:
source("R/data.R")
source("R/functions.R")

# Single drug
result <- calculate_emissions("Vancomycin", dot = 875)
summarize_emissions(result, drug_name = "Vancomycin", dot = 875)

# Facility-level
usage <- data.frame(
  drug_name = c("Vancomycin", "Piperacillin-tazobactam"),
  dot       = c(1200, 3400)
)
calculate_facility_emissions(usage)

# See available drugs
list_drugs()
```

---

## What these emissions represent

The current version estimates **end-of-life emissions** only: CO2e
generated from disposal of single-use materials associated with IV 
antimicrobial packaging, preparation, and administration. Emissions data are 
calculated from U.S. EPA GHG emission factors for landfill disposal.

This is a known underestimate. Major emission sources not yet included:
- Drug manufacturing (active pharmaceutical ingredient synthesis)
- Upstream packaging material production
- Shipping and transportation

Full **cradle-to-grave** life cycle assessment (LCA) data for a panel of
antimicrobials are in development. When available, they will replace the
end-of-life factors in this calculator.

---

## Current drug coverage

The DOT calculator currently includes 47 IV antimicrobial agents. Oral drug 
emissions are not included in this version.

| Drug | NHSN Name | Factor status |
|------|-----------|---------------|
| Acyclovir | Acyclovir | Pending |
| Amikacin | Amikacin | Pending |
| Amphotericin B liposomal | Amphotericin B liposomal | Pending |
| Ampicillin | Ampicillin | Pending |
| Ampicillin-sulbactam | Ampicillin-sulbactam | Pending |
| Azithromycin | Azithromycin | Pending |
| Aztreonam | Aztreonam | Pending |
| Caspofungin | Caspofungin | Pending |
| Cefazolin | Cefazolin | Pending |
| Cefepime | Cefepime | Pending |
| Cefiderocol | Cefiderocol | Pending |
| Cefoxitin | Cefoxitin | Pending |
| Ceftaroline | Ceftaroline | Pending |
| Ceftazidime | Ceftazidime | Pending |
| Ceftazidime-avibactam | Ceftazidime-avibactam | Pending |
| Ceftolozane-tazobactam | Ceftolozane-tazobactam | Pending |
| Ceftriaxone | Ceftriaxone | Pending |
| Cefuroxime | Cefuroxime | Pending |
| Ciprofloxacin | Ciprofloxacin | Pending |
| Clindamycin | Clindamycin | Pending |
| Colistimethate | Colistimethate | Pending |
| Daptomycin | Daptomycin | Pending |
| Doxycycline | Doxycycline | Pending |
| Ertapenem | Ertapenem | Pending |
| Erythromycin | Erythromycin | Pending |
| Fluconazole | Fluconazole | Pending |
| Ganciclovir | Ganciclovir | Pending |
| Gentamicin | Gentamicin | Pending |
| Imipenem-cilastatin | Imipenem-cilastatin | Pending |
| Isavuconazonium | Isavuconazonium | Pending |
| Levofloxacin | Levofloxacin | Pending |
| Linezolid | Linezolid | Pending |
| Meropenem | Meropenem | Pending |
| Meropenem-vaborbactam | Meropenem-vaborbactam | Pending |
| Metronidazole | Metronidazole | Pending |
| Micafungin | Micafungin | Pending |
| Minocycline | Minocycline | Pending |
| Nafcillin | Nafcillin | Pending |
| Penicillin | Penicillin | Pending |
| Pentamidine | Pentamidine | Pending |
| Piperacillin-tazobactam | Piperacillin-tazobactam | Pending |
| Posaconazole | Posaconazole | Pending |
| Remdesivir | Remdesivir | Pending |
| Rifampin | Rifampin | Pending |
| Sulfamethoxazole-trimethoprim | Sulfamethoxazole-trimethoprim | Pending |
| Tigecycline | Tigecycline | Pending |
| **Vancomycin** | Vancomycin | **Available** |

"Pending" entries require population of `co2e_per_dot_mt` from Supplementary
Table 6 of Hojat et al., OFID 2025. The supplementary Excel file is available
at [doi:10.1093/ofid/ofaf308](https://doi.org/10.1093/ofid/ofaf308).

---

## Citation

If using this calculator for research or quality improvement work, please cite:

> Hojat LS, Veltri C, Newman NJ, Ferreira RF, Moore VL, Higbee-Todd KJ,
> Singer ME, Lee AP, Spivak ES. Development of a Novel Carbon Emissions
> Estimation Tool for Disposable Waste Associated With Antimicrobial
> Packaging, Preparation, and Administration in the Hospital Setting.
> *Open Forum Infect Dis.* 2025;12(10):ofaf308.
> https://doi.org/10.1093/ofid/ofaf308

See also [CITATION.md](CITATION.md) for BibTeX and other formats.

---

## Contributing

Contributions are welcome. Priority areas:

- **Emissions factors**: adding or updating per-DOT CO2e values for existing
  or new antimicrobial agents, with documented sources
- **Additional drugs**: agents currently missing from the DOT calculator
- **Validation**: testing against institution-specific data
- **Documentation**: improving code comments, adding vignettes

Please open an issue before submitting a pull request for new drug entries,
as new factors require scientific accuracy review.

Contribution guidelines, including the emissions factor submission process
and scientific review pathway, are under development. See CONTRIBUTING.md
(coming soon).

---

## License

MIT License. See [LICENSE](LICENSE).

---

## Contact

Leila S. Hojat, MD, MS  
Division of Infectious Diseases, Emory University School of Medicine  
Medical Director, Antimicrobial Stewardship, Emory University Hospital Midtown 
Leila.Susan.Hojat@emory.edu
Leila.S.Hojat@gmail.com
