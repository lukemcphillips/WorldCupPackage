library(rvest)
library(tidyr)
library(tibble)
library(dplyr)

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
