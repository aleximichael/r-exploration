# 3 Data Transformation ---------------------------------------------------

library(tidyverse)
library(nycflights13)

# 3.1 Flights Overview ----------------------------------------------------

?flights
glimpse(flights)
View(flights)

flights |> # shortcut: Command + Shift + M 
  filter(dest == "IAH") |> 
  group_by(year, month, day) |> 
  summarize(
    arr_delay = mean(arr_delay, na.rm = TRUE)
  )


# 3.2 Rows ----------------------------------------------------------------

# filter(): Changes the rows present
# arrange(): Changes the order of the rows
# distinct(): Finds rows with unique values
# count(): Counts the number of occurrences
# nrow(): Counts the number of rows

flights |> 
  filter(dep_delay > 120)

flights |> 
  filter(month == 1 & day == 1)

flights |> 
  filter(month %in% c(1,2)) 

flights |>
  arrange(year, month, day, dep_time)

flights |> 
  arrange(desc(dep_delay))

flights |> 
  distinct()

flights |> 
  distinct(origin, dest, .keep_all = TRUE)

flights |> 
  count(origin, dest, sort = TRUE)


# 3.2.1 Exercises ---------------------------------------------------------

flights |> 
  filter(arr_delay >= 120)

flights |> 
  filter(dest %in% c("IAH", "HOU"))

flights |> 
  filter(carrier %in% c("UA", "AA", "DL"))

flights |> 
  filter(month %in% c(7, 8, 9))

flights |> 
  filter(arr_delay >= 120 & dep_delay <= 0)

flights |> 
  filter(dep_delay >= 60 & dep_delay - arr_delay > 30)

flights |> 
  arrange(desc(dep_delay)) |> 
  arrange(sched_dep_time)

flights |> 
  arrange(desc(distance / (air_time / 60)))

flights |> 
  distinct(year, month, day) |> 
  nrow()

flights |> 
  arrange(desc(distance))


# 3.3 Columns -------------------------------------------------------------

# mutate(): Creates new columns from existing columns
# select(): Changes the columns present
# rename(): Changes the names of the columns
# relocate(): Changes the positions of the columns

# .before: adds column before 
# .after: adds column after
# .keep: controls which variables to keep
# .ignore.case: case sensitivity

# janitor::clean_names()
# starts_with()
# ends_with()
# contains()
# num_range()
# any_of()

flights |> 
  mutate(
    gain = dep_delay - arr_delay,
    speed = distance / air_time * 60,
    .before = 1
  )

flights |> 
  mutate(
    gain = dep_delay - arr_delay,
    hours = air_time / 60,
    gain_per_hour = gain / hours,
    .keep = "used"
  )

flights |> 
  select(year, month, day)

flights |> 
  select(year:day)

flights |> 
  select(tail_num = tailnum) # rename variable as you select

flights |> 
  rename(tail_num = tailnum) # rename variable without selecting

flights |> 
  relocate(time_hour, air_time)

flights |> 
  relocate(starts_with("arr"), .before = dep_time)

# 3.3.1 Exercises ---------------------------------------------------------

flights |> 
  select(dep_time, dep_delay, arr_time, arr_delay)

flights |> 
  select(starts_with("dep"), starts_with("arr"))

flights |> 
  select(any_of(c("year", "month", "day", "dep_delay", "arr_delay")))

flights |> 
  select(contains("TIME", ignore.case = FALSE)) # by default: ignores case

flights |> 
  relocate(air_time_min = air_time, .before = 1)


# 3.4 The Pipe ------------------------------------------------------------

flights |> 
  filter(dest == "IAH") |> 
  mutate(speed = distance / air_time * 60) |> 
  select(year:day, dep_time, carrier, flight, speed) |> 
  arrange(desc(speed))


# 3.5 Groups --------------------------------------------------------------

# group_by(): subsequent operations work on each group
# summarize(): output is a single row per group (default: peels off last group)
# n(): counts the number of rows in each group
# ungroup(): removes all groups
# .by: argument that groups within a single operation

# slice_head(n = 1): first row from each group
# slice_tail(n = 1): last row in each group
# slice_min(x, n = 1): row with smallest value in column x 
# slice_max(x, n = 1): row with largest value in column x
# slice_sample(x, n = 1): random row
# slice_[...](negative value): sorts but doesn't slice

flights |> 
  group_by(month) |> # groups all data by month
  summarize(
    avg_delay = mean(dep_delay, na.rm = TRUE) # calculates the average delay per month
  )

flights |> 
  group_by(dest) |> 
  slice_max(arr_delay, n = 1, with_ties = FALSE) |> # remove duplicate tie values 
  relocate(dest)

flights |> 
  group_by(year, month, day) |> 
  summarize(n = n(), .groups = "keep") # keep all groups

flights |> 
  summarize(
    delay = mean(dep_delay, na.rm = TRUE), 
    n = n(),
    .by = c(origin, dest)
  )


# 3.5.1 Exercises ---------------------------------------------------------

flights |> 
  group_by(carrier) |> 
  summarize(
    avg_dep_delay = mean(dep_delay, na.rm = TRUE)
  ) |> 
  arrange(desc(avg_dep_delay))

flights |> 
  group_by(dest) |> 
  summarize(
    avg_dep_delay = mean(dep_delay, na.rm = TRUE)
  ) |> 
  arrange(desc(avg_dep_delay))

flights |> 
  group_by(hour) |> 
  summarize(
    avg_dep_deplay = mean(dep_delay, na.rm = TRUE)
  ) |> 
  ggplot(
    aes(x = hour, y = avg_dep_deplay)
  ) +
  geom_smooth()

flights |> 
  slice_min(dep_delay, n = -1) # negative value: sorts but doesn't slice

df <- tibble(
  x = 1:5,
  y = c("a", "b", "a", "a", "b"),
  z = c("K", "K", "L", "L", "K")
)

df |> group_by(y)
df |> arrange(y)
df |> 
  group_by(y) |> 
  summarize(mean_x = mean(x))
df |> 
  group_by(y, z) |> 
  summarize(mean_x = mean(x))
df |> 
  group_by(y, z) |> 
  summarize(
    mean_x = mean(x),
    .groups = "drop"
    )
df |> 
  group_by(y, z) |> 
  mutate(mean_x = mean(x))


# 3.6 Case Study ----------------------------------------------------------

batters <- Lahman::Batting |> 
  group_by(playerID) |> 
  summarize(
    performance = sum(H, na.rm = TRUE) / sum(AB, na.rm = TRUE),
    n = sum(AB, na.rm = TRUE)
  )

batters |> 
  filter(n > 100) |> 
  ggplot(aes(x = n, y = performance)) +
  geom_point(alpha = 1/10) +
  geom_smooth(se = FALSE)
