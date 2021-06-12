library(data.table)
library(magrittr)
library(lubridate)
library(ggplot2)

source("functions.R")

d = fread("data/results.csv") %>% 
    .[, date := ymd(date)] %>% 
    setorder(-date)
# -----------------------------------------------------------------------------    

## Tag 1 
italien = d %>% last_x_matches(ctr = "Italy", n = 10)

# Historische Begegnungen
italien$alle_spiele[(home_team == "Italy" & away_team == "Turkey") | (home_team == "Turkey" & away_team == "Italy"), .(date, home_team, away_team, home_score, away_score, ausgang)]

# Wann hat ITA ueberhaupt mal verloren?
italien$alle_spiele[ausgang == "verloren"]

## Tag 2
swi = d %>% last_x_matches(ctr = "Switzerland", write_name = "Schweiz", n = 10)
wales = d %>% last_x_matches(ctr = "Wales", write_name = "Wales",n = 10)


dae = d %>% last_x_matches(ctr = "Denmark", write_name = "Dänemark", n = 10)
fin = d %>% last_x_matches(ctr = "Finland", write_name = "Finnland", n = 10)


bel = d %>% last_x_matches(ctr = "Belgium", write_name = "Belgien", n = 10)
rus = d %>% last_x_matches(ctr = "Russia", write_name = "Russland", n = 10)

