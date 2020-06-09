# Fix issue with repeated variables in certain variables

# Example of issue 
services$List$Filter$States
services$List$Filter$`CBSAs (Core Based Statistical Areas)`
services$List$Filter$`Sites by County`

# 1. Determine if this results from table structure or from 
#    processing

tbls <- get.all.tables()
tbls[5]
# --> Looks like processing

# 2. Set a breakpoint

###### Take on breaks here

# Fix issue with repeated variables in certain variables

# Example of issue 

# 1. Determine if this results from table structure or from 
#    processing

tbls <- get.all.tables()
listing.service <- tbls[[5]]
# --> Looks like processing

# 2. Set a breakpoint

# 3. Track
processed.services <- populate.service.list( listing.service )
# --> Possible that the initial problem with the param classes filter name 
#     contributes to losing info. 