# compress Federal RePORTER raw dataset in order to post it on UVA Dataverse

library(readr)

#
# Raw data --------------------------------------------
#

# read in raw data

FR_raw <- read_csv("data/prd/Federal_RePORTER/FR-2021DEC/FR_raw_2021DEC17.csv", 
                   col_types = cols(.default = "c", FY_TOTAL_COST = "n", FY_TOTAL_COST_SUB_PROJECTS = "n"))

file.size("data/prd/Federal_RePORTER/FR-2021DEC/FR_raw_2021DEC17.csv")/1000000000   # 4.7 GB


# compress

write_csv(FR_raw, xzfile("FR_raw_data.csv.xz", compression = 9))

file.size("FR_raw_data.csv.xz")/1000000000   # 0.8 GB


# check if compressed file is the same data as FR_raw

temp <- read_csv(xzfile("FR_raw_data.csv.xz"), 
                 col_types = cols(.default = "c", FY_TOTAL_COST = "n", FY_TOTAL_COST_SUB_PROJECTS = "n"))

identical(as.data.frame(FR_raw), as.data.frame(temp))  # TRUE

