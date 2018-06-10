

#'@param
#'@return Ran.
#'@examples
#'@export



library(dplyr)
library(stringr)
library(rvest)
library(tibble)


world_cup_rankings <- function()
{
  world_cup = 'https://en.wikipedia.org/wiki/FIFA_World_Rankings'

  world_cup_rankings <- read_html(world_cup) %>%
    html_nodes("table") %>%
    .[[1]] %>%
    html_table(trim = TRUE)

  world_cup_rankings <- as_tibble(world_cup_rankings)

  world_cup_rankings <- world_cup_rankings[, 3:4]
  world_cup_rankings <- world_cup_rankings[-c(1,2,3),]
  colnames(world_cup_rankings) <- c("Team", "Points")
  world_cup_rankings
}

world_cup_rankings()
