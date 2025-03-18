# 1 Data Visualization ---------------------------------------------------

library(tidyverse)
library (palmerpenguins)
library(ggthemes)


# 1.2 First Steps ---------------------------------------------------------

glimpse(penguins) # view dataset in console
View(penguins) # open dataset in viewer
?penguins # learn more about the dataset

ggplot(
  penguins, # identify the dataset
  aes(x = flipper_length_mm,
      y = body_mass_g) # map variables (global)
) +
  geom_point(aes(color = species,
                 shape = species)) + # add object to represent data (local)
  geom_smooth(method = "lm") + # add another object (local)
  labs(
    title = "Body mass and flipper length",
    subtitle = "Diemnsions for Adelie, Chinstrap, and Gentoo Penguins",
    x = "Flipper length (mm)",
    y = "Body mass (g)",
    color = "Species",
    shape = "Species"
  ) + # add labels
  scale_color_colorblind() # use a default palette


# 1.2.1 Exercises ---------------------------------------------------------

ggplot(
  penguins,
  aes(x = bill_length_mm, y = bill_depth_mm)
) +
  geom_point(aes(color = species,
                 shape = species),
             na.rm = TRUE) # remove NA values

ggplot(
  penguins,
  aes(x = species, y = bill_depth_mm, fill = species)
) +
  geom_boxplot() + 
  labs(
    caption = "Data comes from the palmerpenguins package"
  )

ggplot(
  penguins,
  aes(x = flipper_length_mm, y = body_mass_g)
) +
  geom_point(aes(color = bill_depth_mm)) +
  geom_smooth()

ggplot(
  penguins,
  aes(x = flipper_length_mm, y = body_mass_g, color = island)
) +
  geom_point() +
  geom_smooth(se = FALSE)

# 1.4.1 Exercises ---------------------------------------------------------

ggplot(penguins, aes(y = species)) +
  geom_bar()

ggplot(penguins, aes(x = species)) +
  geom_bar(fill = "red")

ggplot(diamonds, aes(x = carat)) +
  geom_histogram(binwidth = 0.1)


# 1.5 Visualizing Relationships -------------------------------------------

# Numerical + Categorical
ggplot(penguins, aes(x = species, y = body_mass_g)) + 
  geom_boxplot()

ggplot(penguins, aes(x = body_mass_g, color = species)) + 
  geom_density(linewidth = 0.75)

ggplot(penguins, aes(x = body_mass_g, color = species, fill = species)) + 
  geom_density(alpha = 0.5)

# Categorical + Categorical
ggplot(penguins, aes(x = island, fill = species)) + 
  geom_bar(position = "fill")

# Numerical + Numerical
ggplot(penguins, aes(x = flipper_length_mm, y = body_mass_g)) + 
  geom_point()

# Three or More Variables
ggplot(penguins, aes(x = flipper_length_mm, y = body_mass_g)) +
  geom_point(aes(color = species, shape = species)) +
  facet_wrap(~island)


# 1.5.1 Exercises ---------------------------------------------------------

ggplot(mpg, aes(x = hwy, y = displ, color = cty, size = cty)) +
  geom_point() 

ggplot(mpg, aes(x = hwy, y = displ, color = drv, shape = drv)) + 
  geom_point()

ggplot(penguins, aes(x = bill_depth_mm, y = bill_length_mm, color = species)) +
  geom_point()

ggplot(penguins, aes(x = island, fill = species)) +
  geom_bar(position = "fill")

ggplot(penguins, aes(x = species, fill = island)) +
  geom_bar(position = "fill")


# 1.6 Saving Plots --------------------------------------------------------

ggplot(mpg, aes(x = cty, y = hwy)) + 
  geom_point()

ggsave("mpg-plot.png")
