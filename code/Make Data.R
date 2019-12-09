#' In practice, this file does not exist and instead you have a real dataset of all your programs and measures in one tidy-format. 

library(tidyverse) # generic R utilities

programs = c("Basket Weaving", 
             "Printing Press Operator", 
             "Woodcutter")

retention = expand.grid(Program = programs, Year = 2001:2010) %>% 
  as_tibble() %>% 
  group_by(Program) %>% 
  mutate(Value = c(runif(n = 5, 0.2, 0.4), runif(n = 5, 0.4, 0.6)),
         Measure = "Retention Rate")

enrolment = expand.grid(Program = programs, Year = 2001:2010) %>% 
  as_tibble() %>% 
  group_by(Program) %>% 
  mutate(Value = c(runif(n = 7, 100, 200), runif(n = 3, 300, 700)),
         Value = round(Value, 0),
         Measure = "Enrolment")

all_data = bind_rows(retention, enrolment) %>% 
  ungroup %>% 
  select(Program, Measure, Year, Value)

write_csv(all_data, "data/all_data.csv", na = "")


