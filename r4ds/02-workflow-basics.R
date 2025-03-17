# 2 Workflow Basics -------------------------------------------------------

library(tidyverse)

# 2.1 Basic R Code --------------------------------------------------------

1 / 200 * 30 # basic math

x <- 3 * 4 # object creation (Option + Minus)

primes <- c(2, 3, 5) # combine into vector

this_is_a_long_name <- 1.2 # use snake_case for objects

seq(1, 10) # create a sequence of numbers


# 2.1.1 Exercises ---------------------------------------------------------

ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point() +
  geom_smooth(method = "lm")

