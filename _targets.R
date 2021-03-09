## Load your packages, e.g. library(targets).
source("./packages.R")
source("R/functions.R")
options(tidyverse.quiet = TRUE)
options(tidyverse.quiet = TRUE)
tar_option_set(packages = c("biglm", "tidyverse"))
list(
  tar_target(
    raw_data_file,
    "data/raw_data.csv",
    format = "file"
  ),
  tar_target(
    raw_data,
    read_csv(raw_data_file, col_types = cols())
  ),
  tar_target(
    data,
    raw_data %>%
      mutate(Ozone = replace_na(Ozone, mean(Ozone, na.rm = TRUE)))
  ),
  tar_target(hist, create_plot(data)),
  tar_target(fit, biglm(Ozone ~ Wind + Temp, data))
)

# ## Load your R files
# lapply(list.files("./R", full.names = TRUE), source)
# 
# ## tar_plan supports drake-style targets and also tar_target()
# tar_plan(
# 
# # target = function_to_make(arg), ## drake style
# 
# # tar_target(target2, function_to_make2(arg)) ## targets style
# 
# )
