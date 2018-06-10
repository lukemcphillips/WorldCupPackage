

#'@param
#'@return Schedule of group stage games.
#'@examples
#'@export


library(rvest)
library(tidyr)
library(tibble)
library(dplyr)

world_cup_brackets_func <- function()
{
  world_cup_brackets <- 'https://www.independent.co.uk/sport/football/world-cup/world-cup-2018-full-schedule-groups-fixtures-kick-off-times-venues-matches-wallchart-a8087881.html'
  world_cup_groupstage <- read_html(world_cup_brackets) %>%
    html_nodes("table") %>%
    .[[1]] %>%
    html_table(trim = TRUE)
  world_cup_groupstage <- as_tibble(world_cup_groupstage)
  world_cup_groupstage <- world_cup_groupstage[1:50,1:4]
  colnames(world_cup_groupstage) <- c("Date", "Match", "Venue", "Kick-off (BST)")
  world_cup_groupstage <- world_cup_groupstage[-c(1,2),]
  world_cup_groupstage

}

