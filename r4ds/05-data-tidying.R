# 5 Data Tidying ----------------------------------------------------------

library(tidyverse)


# 5.1 Tidy Data -----------------------------------------------------------

table1 # tidy data
table2 # untidy data
table3 # untidy data


# 5.2 Lengthening Data ----------------------------------------------------

billboard_longer <- billboard |> 
  pivot_longer(
    cols = starts_with("wk"), # specifies columns to be pivoted
    names_to = "week", # names the variable stored in column names
    values_to = "rank", # names the variable stored in cell values
    values_drop_na = TRUE # removes "empty observations"
  ) |> 
  mutate(
    week = parse_number(week) # extracts number from value
  )

who2 |> 
  pivot_longer(
    cols = !(country:year), # select columns
    names_to = c("diagnosis", "gender", "age"), # create new col names
    names_sep = "_", # split original col names at "_" delimiter
    values_to = "count", # create column for values
    values_drop_na = TRUE
  )

household |> 
  pivot_longer(
    cols = !family, # select columns
    names_to = c(".value", "child"), # "."-> first component becomes a variable name
    names_sep = "_", # split original col names at "_" delimiter 
    values_drop_na = TRUE
  )


# 5.3 Widening Data -------------------------------------------------------

cms_patient_experience |> 
  pivot_wider(
    id_cols = starts_with("org"), # select columns
    names_from = measure_cd, # select values to convert to columns
    values_from = prf_rate # select column to convert to values
  )
