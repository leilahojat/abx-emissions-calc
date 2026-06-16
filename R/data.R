# =============================================================================
# Antimicrobial Carbon Emissions Calculator
# File: R/data.R
#
# Two data frames used by the Antimicrobial Carbon Emissions calculator:
#   antimicrobial_factors  -- CO2e per day of therapy (DOT) for each drug
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
#   Emissions factors: Antimicrobial_Emissions_Calculator Reference tab 
#   (Supplementary data from Hojat et al. OFID 2025)
#
# GHG equivalency factors source:
#   U.S. EPA GHG Emission Factors Hub (2024)
#   https://www.epa.gov/climateleadership/ghg-emission-factors-hub
# =============================================================================


# ------------------------------------------------------------------------------
# antimicrobial_factors
# ------------------------------------------------------------------------------
# drug_name       : Drug name as used in the calculator
# nhsn_name       : Name as it appears in NHSN antimicrobial use (AU) data
# route           : Route of administration ("IV" or "PO")
# co2e_per_dot_mt : CO2-equivalent GHG emissions per day of therapy (DOT),
#                   in metric tons CO2e. Based on average materials at two
#                   large academic medical centers (Cleveland, OH and
#                   Salt Lake City, UT).
# source          : Primary source


antimicrobial_factors <- data.frame(
  drug_name = c(
    "Acyclovir",
    "Amikacin",
    "Amphotericin B liposomal",
    "Ampicillin",
    "Ampicillin/sulbactam",
    "Azithromycin",
    "Aztreonam",
    "Caspofungin",
    "Cefazolin",
    "Cefepime",
    "Cefiderocol",
    "Cefoxitin",
    "Ceftaroline",
    "Ceftazidime",
    "Ceftazidime/avibactam",
    "Ceftolozane/tazobactam",
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
    "Imipenem/cilastatin",
    "Isavuconazonium",
    "Levofloxacin",
    "Linezolid",
    "Meropenem",
    "Meropenem/vaborbactam",
    "Metronidazole",
    "Micafungin",
    "Minocycline",
    "Nafcillin",
    "Penicillin",
    "Pentamidine",
    "Piperacillin/tazobactam",
    "Posaconazole",
    "Remdesivir",
    "Rifampin",
    "Sulfamethoxazole/trimethoprim",
    "Tigecycline",
    "Vancomycin"
  ),
  
  nhsn_name = c(
    "ACYCLOVIR",
    "AMIKACIN",
    "AMPHOTERICIN B LIPOSOMAL",
    "AMPICILLIN",
    "AMPICILLIN/SULBACTAM",
    "AZITHROMYCIN",
    "AZTREONAM",
    "CASPOFUNGIN",
    "CEFAZOLIN",
    "CEFEPIME",
    "CEFIDEROCOL",
    "CEFOXITIN",
    "CEFTAROLINE",
    "CEFTAZIDIME",
    "CEFTAZIDIME/AVIBACTAM",
    "CEFTOLOZANE/TAZOBACTAM",
    "CEFTRIAXONE",
    "CEFUROXIME",
    "CIPROFLOXACIN",
    "CLINDAMYCIN",
    "COLISTIMETHATE",
    "DAPTOMYCIN",
    "DOXYCYCLINE",
    "ERTAPENEM",
    "ERYTHROMYCIN",
    "FLUCONAZOLE",
    "GANCICLOVIR",
    "GENTAMICIN",
    "IMIPENEM/CILASTATIN",
    "ISAVUCONAZONIUM",
    "LEVOFLOXACIN",
    "LINEZOLID",
    "MEROPENEM",
    "MEROPENEM/VABORBACTAM",
    "METRONIDAZOLE",
    "MICAFUNGIN",
    "MINOCYCLINE",
    "NAFCILLIN",
    "PENICILLIN",
    "PENTAMIDINE",
    "PIPERACILLIN/TAZOBACTAM",
    "POSACONAZOLE",
    "REMDESIVIR",
    "RIFAMPIN",
    "SULFAMETHOXAZOLE/TRIMETHOPRIM",
    "TIGECYCLINE",
    "VANCOMYCIN"
  ),
  
  route = rep("IV", 47),
  co2e_per_dot_mt = c(
    3.10863593E-05,       # Acyclovir           
    2.80184602E-05,       # Amikacin            
    1.80525618E-04,       # Amphotericin B lip. 
    4.35468662E-05,       # Ampicillin          
    3.56339690E-05,       # Ampicillin/sul.     
    1.47005147E-05,       # Azithromycin        
    2.92184578E-05,       # Aztreonam           
    1.57622917E-05,       # Caspofungin         
    1.72825650E-05,       # Cefazolin           
    2.96338545E-05,       # Cefepime            
    3.72227775E-05,       # Cefiderocol         
    3.93990285E-05,       # Cefoxitin           
    3.01575800E-05,       # Ceftaroline         
    3.97428219E-05,       # Ceftazidime         
    2.99623882E-05,       # Ceftazidime/avi.    
    3.70235910E-05,       # Ceftolozane/tazo.   
    1.10107340E-05,       # Ceftriaxone         
    1.84975475E-05,       # Cefuroxime          
    2.91381840E-05,       # Ciprofloxacin       
    2.31142847E-05,       # Clindamycin         
    2.50356217E-05,       # Colistimethate      
    2.06897010E-05,       # Daptomycin          
    2.02200883E-05,       # Doxycycline         
    1.10432120E-05,       # Ertapenem           
    3.11518319E-05,       # Erythromycin        
    4.60988089E-05,       # Fluconazole         
    2.40647597E-05,       # Ganciclovir         
    2.49247054E-05,       # Gentamicin          
    8.33154427E-05,       # Imipenem/cilastatin 
    3.72358637E-05,       # Isavuconazonium     
    2.50961215E-05,       # Levofloxacin        
    1.07943820E-04,       # Linezolid           
    3.09716583E-05,       # Meropenem           
    6.13156657E-05,       # Meropenem/vabor.    
    6.67585539E-05,       # Metronidazole       
    8.22709120E-06,       # Micafungin          
    1.66097297E-05,       # Minocycline         
    5.60007197E-05,       # Nafcillin           
    4.19661987E-05,       # Penicillin          
    1.49881367E-05,       # Pentamidine         
    3.69922605E-05,       # Piperacillin/tazo.  
    1.49209606E-05,       # Posaconazole        
    4.21235092E-05,       # Remdesivir          
    5.37585630E-05,       # Rifampin            
    4.88972277E-05,       # SMX/TMP             
    1.76439567E-05,       # Tigecycline         
    2.56481485E-05        # Vancomycin         
  
  ),
  
  waste_kg_per_dot = c(
    0.346,       # Acyclovir           
    0.295,       # Amikacin            
    0.792,       # Amphotericin B lip. 
    0.531,       # Ampicillin          
    0.367,       # Ampicillin/sul.     
    0.195,       # Azithromycin        
    0.332,       # Aztreonam           
    0.211,       # Caspofungin         
    0.207,       # Cefazolin           
    0.258,       # Cefepime            
    0.347,       # Cefiderocol         
    0.471,       # Cefoxitin           
    0.386,       # Ceftaroline         
    0.460,       # Ceftazidime         
    0.377,       # Ceftazidime/avi.    
    0.404,       # Ceftolozane/tazo.   
    0.172,       # Ceftriaxone         
    0.292,       # Cefuroxime          
    0.189,       # Ciprofloxacin       
    0.167,       # Clindamycin         
    0.279,       # Colistimethate      
    0.239,       # Daptomycin          
    0.265,       # Doxycycline         
    0.206,       # Ertapenem           
    0.412,       # Erythromycin        
    0.188,       # Fluconazole         
    0.261,       # Ganciclovir         
    0.364,       # Gentamicin          
    0.797,       # Imipenem/cilastatin 
    0.226,       # Isavuconazonium     
    0.170,       # Levofloxacin        
    0.277,       # Linezolid           
    0.444,       # Meropenem           
    0.821,       # Meropenem/vabor.    
    0.261,       # Metronidazole       
    0.195,       # Micafungin          
    0.263,       # Minocycline         
    0.325,       # Nafcillin           
    0.210,       # Penicillin          
    0.176,       # Pentamidine         
    0.194,       # Piperacillin/tazo.  
    0.227,       # Posaconazole        
    0.271,       # Remdesivir          
    0.393,       # Rifampin            
    0.453,       # SMX/TMP             
    0.251,       # Tigecycline         
    0.282        # Vancomycin         
  ),
  
  
  stringsAsFactors = FALSE
)

# Convenience column: kg CO2e per DOT (multiply metric tons by 1000)
antimicrobial_factors$co2e_per_dot_kg <- 
  antimicrobial_factors$co2e_per_dot_mt * 1000


# ------------------------------------------------------------------------------
# ghg_factors
# ------------------------------------------------------------------------------
# GHG equivalency conversion factors from U.S. EPA Emission Factors Hub (2024).
# mt_co2e_per_unit : how many metric ton CO2e per 1 unit


ghg_factors <- data.frame(
  equivalency = c(
    "Miles driven (average passenger car)",
    "Gallons of gasoline consumed",
    "Pounds of coal burned",
    "Smartphones charged"
  ),
  mt_co2e_per_unit = c(
    0.000391,    # metric ton CO2e per mile driven
    0.008887,    # metric ton CO2e per gallon of gas consumed
    0.000907,    # metric ton CO2e per pound of coal burned
    0.0000151    # metric ton CO2e per smartphone charged
  ),
  unit = c(
    "miles",
    "gallons",
    "pounds",
    "phones"
  ),

  stringsAsFactors = FALSE
)



