

last_x_matches <- function(d, ctr = "Austria", write_name = "Österreich", n = 20){

subs1 = d[(home_team == ctr | away_team == ctr),] %>% 
    .[, ausgang := "unentschieden"] %>% 
    .[, ausgang := ifelse((home_score > away_score) & home_team == ctr | (home_score < away_score) & home_team != ctr, "gewonnen", ausgang)] %>% 
    .[, ausgang := ifelse((home_score < away_score) & home_team == ctr | (home_score > away_score) & home_team != ctr, "verloren", ausgang)] %>% 
    .[, ausgang := factor(ausgang, levels = c("verloren", "unentschieden", "gewonnen"))]


bewerbs_spiele <- subs1[tournament != "Friendly"] %>% 
    .[1:n,]

bewerbs_spiele_ausw <- subs1[tournament != "Friendly"] %>% 
    .[1:n, .(home_team, away_team, home_score, away_score, ausgang)]


lost_against = bewerbs_spiele[ausgang == "verloren", .(home_team, away_team, tournament)]

sum_win_lose <- bewerbs_spiele[, .N, keyby = ausgang]

zu0_gewonnen <- bewerbs_spiele[ausgang == "gewonnen" & (home_score == 0 | away_score == 0), .N]

statement_1 <- paste(write_name, "hat von den letzten", n, "Spielen", sum_win_lose[ausgang == "gewonnen",N], "gewonnen")
statement_2 <- paste(write_name, "hat von den letzten", n, "Spielen", zu0_gewonnen, "zu Null gewonnen")


list(alle_spiele = subs1, 
     bewerbs_spiele = bewerbs_spiele,
     bewerbs_spiele_ausw = bewerbs_spiele_ausw,
     sum_win_lose = sum_win_lose,
     lost_against = lost_against,
     zu0_gewonnen = zu0_gewonnen,
     statement_1 = statement_1,
     statement_2 = statement_2
     )
}
