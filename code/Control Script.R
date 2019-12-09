#' The object of this code is to pull a set of data into R, generate xmr data, and then create separte reports for each 'Program' in the dataset. 
#' 
#' This workflow was developed for our Program Review process, but generally speaking it can automate any reporting task wherein you want to create the same report for multiple entities. 

library(tidyverse) # generic R utilities
library(rmarkdown) # reporting package
library(glue)      # strings + data
library(xmrr)      # creates xmr data and charts

# loads in previously saved data 
# this data must be in 'tidy' format to use with `xmrr`
all_data = read_csv("data/all_data.csv") # loads data

# This section creates xmr data for each `Program` and `Measure`
xmr_data = all_data %>% 
  group_by(Program, Measure) %>% 
  xmr2(measure = Value)

# This gives us a list of all programs in the data
# the vector given by this snippet defines which programs have a report generated for them
prgs = xmr_data$Program %>% 
  unique %>%
  as.character

# This loops through each program name, supplying the program name to the `RMarkdown` template
# Specific rendering options can be specified here, or in the template itself. 
for(prg in prgs){
  rmarkdown::render(input = "code/Report Template.Rmd", # where to find the template
                    output_file = glue::glue("output/{prg}.html")
  )
}
