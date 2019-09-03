#### This script builds the README.md

library(tidyverse)
library(glue)

## Params

loc_data <- "talks_table.csv"

## Process

data <- read_csv(loc_data,  locale = locale(encoding = 'latin1'), na = character())

## Print
sink('README.md')

cat("## Building this document\n\n")
cat("To build this README, run `build_readme.R`. Talks data is in csv `talks_table.csv`\n\n")


cat("## Workshops\n\n")
data %>%
  filter(Type == 'workshop') %>%
  glue_data(
    "<strong>{Name}</strong> (<i>{Affaliation}</i>), {Title}",
    "<details><summary>Abstract</summary>",
    "</p>{Abstract}</p><br>[Link to Workshop Material]({Slides})",
    "</details><br>"
  )

cat("\n\n## Talks\n\n")
cat("In alphabetical order.\n\n")
data %>%
  filter(Type == 'talk') %>%
  arrange(Name) %>%
  glue_data(
    "<strong>{Name}</strong> (<i>{Affaliation}</i>), {Title}",
    "<details><summary>Abstract</summary>",
    "</p>{Abstract}</p><br>[Slides]({Slides})",
    "</details><br>"
  )
sink()

