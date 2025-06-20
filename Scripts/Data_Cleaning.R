# Load necessary libraries
library(dplyr)
library(janitor)
library(lubridate)
library(skimr)

# Import Data
df_raw = read.csv('Data/Raw/Hospital_ER.csv')

# Clean column names
df = df_raw %>%
  clean_names()

# Convert date column to date object
df$date = as_datetime(df$date)

# Remove Duplicates
df = distinct(df)

# Impute missing values
sum(is.na(df$patient_sat_score))
df$patient_sat_score[is.na(df$patient_sat_score)] = median(df$patient_sat_score, na.rm = TRUE)

# Save cleaned data file
write.csv(df, 'Data/Cleaned/Hospital_ER_Cleaned.csv', row.names = FALSE)