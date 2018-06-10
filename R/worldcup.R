# This is the worldcup package.

library(dplyr)
library(stringr)
library(rvest)
library(tibble)


#------------------------------------


world_cup_brackets_func <- function()
{
  world_cup_brackets = 'https://www.independent.co.uk/sport/football/world-cup/world-cup-2018-full-schedule-groups-fixtures-kick-off-times-venues-matches-wallchart-a8087881.html'

  world_cup_groupstage <- read_html(world_cup_brackets) %>%
    html_nodes("table") %>%
    .[[1]] %>%
    html_table(trim = TRUE)

  world_cup_groupstage <- as_tibble(world_cup_groupstage)
  world_cup_groupstage <- world_cup_groupstage[1:50,1:4]
}


#---------------------------------------
world_cup_rankings <- function()
{
  world_cup = 'https://en.wikipedia.org/wiki/FIFA_World_Rankings'

  world_cup_rankings <- read_html(world_cup) %>%
    html_nodes("table") %>%
    .[[1]] %>%
    html_table(trim = TRUE)

  world_cup_rankings <- as_tibble(world_cup_rankings)
  print(world_cup_rankings <- world_cup_rankings[, 3:4])
}



#---------------------------------------------------------
#rosters function

library(rvest)
library(tidyr)
library(tibble)
library(dplyr)


country_squad <- function(country) {
  squads <- "https://www.cbssports.com/soccer/world-cup/news/world-cup-2018-every-squad-including-argetina-brazil-spain-england-france-and-germany/"
  team_rosters <- read_html(squads)

  team_rosters <- team_rosters %>%
    html_nodes(xpath = "//p | //strong") %>%
    html_text



  team_roster <- team_rosters[-c(1, 2, 3, 4, 5, 6, 7, 8, 216)]
  (final_rosters <- lapply(1:33, function(k) {
    for (value in 1:9) {
      if (value == 1) {
        roster <- c(team_roster[value + ((k-1)*9)])
      }
      else {
        roster <- c(roster, team_roster[value + ((k-1)*9)])
      }
    }
    roster
  }))


  final_rosters <- final_rosters[-33]


  names(final_rosters) <- c("Argentina", "Australia", "Belgium", "Brazil", "Colombia", "Costa Rica", "Croatia", "Denmark", "Egypt", "England", "France", "Germany", "Iceland", "Iran", "Japan",  "Mexico", "Morocco",  "Nigeria", "Panama", "Peru", "Poland", "Portugal", "Russia", "Saudi Arabia", "Senegal", "Serbia", "South Korea", "Spain", "Sweden", "Switzerland", "Tunisia", "Uruguay")


  for (number in 1:32) {
    if(number == 1) {
      cropped_rosters <- c(final_rosters[[number]][-c(3,5,7,9)])
    }
    else {
      cropped_rosters <- c(cropped_rosters, final_rosters[[number]][-c(3,5,7,9)])
    }

  }

  cropped_sorted <- lapply(1:32, function(p) {
    for (value in 1:5) {
      if (value == 1) {
        roster <- c(cropped_rosters[value + ((p-1)*5)])
      }
      else {
        roster <- c(roster, cropped_rosters[value + ((p-1)*5)])
      }
    }
    roster
  })

  names(cropped_sorted) <- c("Argentina", "Australia", "Belgium", "Brazil", "Colombia", "Costa Rica", "Croatia", "Denmark", "Egypt", "England", "France", "Germany", "Iceland", "Iran", "Japan",  "Mexico", "Morocco",  "Nigeria", "Panama", "Peru", "Poland", "Portugal", "Russia", "Saudi Arabia", "Senegal", "Serbia", "South Korea", "Spain", "Sweden", "Switzerland", "Tunisia", "Uruguay")
  # cropped_sorted["Uruguay"]
  cropped_sorted[country]

}



#---------------------------------------------------
#group_data function
group_data_function <- function()
{
  the_url_3 <- "https://en.wikipedia.org/wiki/2018_FIFA_World_Cup"
  group_data <- read_html(the_url_3)

  all_groups <- lapply(5:12, function(n) {

    group_data_final <- group_data %>%
      html_nodes(css = ".wikitable") %>%
      html_table(fill = TRUE) %>%
      .[[n]]

    group_data_final
    group_data_final <- as_tibble(group_data_final)
  })

  return(all_groups)
}

#-------------------------------------------------
# world cup simulator
#take one: the country with the higher ranking wins.









