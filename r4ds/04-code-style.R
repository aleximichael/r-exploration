# 4 Code Style ------------------------------------------------------------

library(tidyverse)
library(nycflights13)

# Note: Install the "Styler" package

# 4.1 Names ---------------------------------------------------------------

# Use snake_case
# Use common prefixes (helps with auto complete)

short_times <- flights |> 
  filter(air_time < 60)

short_distances <- flights |> 
  filter(distance < 100)


# 4.2 Spaces --------------------------------------------------------------

# Add spaces to increase clarity

z <- (a + b)^2 / d


# 4.3 Pipes ---------------------------------------------------------------

# Pipes should be the last thing on a line
# Arguments should be on new lines
# Don't have pipes longer than 10 - 15 lines (break them into smaller tasks)
# Same rules apply to the "+" for ggplot

flights |> 
  group_by(tailnum) |> 
  summarize(
    delay = mean(arr_delay, na.rm = TRUE),
    n = n()
  )


# 4.4 Comments ------------------------------------------------------------

# Use section comments to break up your file
# Shortcut: Command + Shift + R


# 4.5 Exercises -----------------------------------------------------------

flights |> 
  filter(dest == "IAH") |>
  group_by(year, month, day) |>
  summarize(
    n = n(),
    delay = mean(arr_delay, na.rm=TRUE)
  ) |>
  filter(n > 10)

flights |>
  filter(
    carrier == "UA",
    dest %in% c("IAH", "HOU"),
    sched_dep_time > 0900,
    sched_arr_time < 2000
  ) |>
  group_by(flight) |>
  summarize(
    delay = mean(arr_delay, na.rm=TRUE),
    cancelled = sum(is.na(arr_delay)),
    n = n()
  ) |>
  filter(n > 10)