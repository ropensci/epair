# Revamp, rewrite, innovate a method for populating tables

tbls <- get.all.tables()

tbls[[5]]$Endpoint

## Solution using hard coded table structure

# Split into tables having multiple examples and those having only one
# --> Anyone before the 4 is unnecessary
# - Meta data is the only table having the third-ish entry down as multiple
multiple.example.tables <- list( tbls[[4]],
                                 tbls[[6]],
                                 tbls[[7]],
                                 tbls[[8]],
                                 tbls[[9]],
                                 tbls[[10]], 
                                 tbls[[11]], 
                                 tbls[[12]],
                                 tbls[[13]],
                                 tbls[[14]],
                                 tbls[[15]])


# Issue with classes not showing
multiple.example.tables$daily.table$Endpoint

# -- And all easier to manage if you isolate tbls[[5]]