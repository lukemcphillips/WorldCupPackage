#' @param country Country whose roster to return
#' @return The roster of the the specified country in a list broken down by positions
#' @examples

#' @export

library(rvest)
library(tidyr)
library(tibble)
library(dplyr)


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

