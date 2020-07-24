# Get exact data used in published paper

library(rvest)
library(jsonlite)
library(httr)
source("Utility.R")


# Authentication
set.email("glo003@bucknell.edu")
set.key("goldram72")
create.authentication()

# Variables used in paper
# - Start on July 6, 2016 end on August 5, 2016
# - State is CT 
# - Parameter is O3
paper.variables <- list( 'bdate' = '20160706',
                   'edate' = '20160805',
                   'state' = '09',
                   'param' = '44201')

# Finest grain data obtained by the EPA
state.endpoint <- 'sampleData/byState'    

# Setup the call
base.call <- create.base.call( state.endpoint )
call <- add.variables( base.call, paper.variables )
call

# Get the data
results <- perform.call( call )
results$Header
head(results$Data)

###### 



##### Determine the parameter code of O3
classes.endpoint <- 'list/classes'
parameter.endpoint <- 'list/parametersByClass'

classes.call <- create.base.call( classes.endpoint )
class.result <- perform.call( classes.call )
class.result

# Error when accessing a call with a space in it example: AQI POLLUTANTS
pc <- 'ALL'
base.call <- create.base.call( parameter.endpoint  )
call <- add.variable( base.call, pc)
call

result <- perform.call( call )
result$Header
param.codes <- result$Data
param.codes[which(param.codes$value_represented == 'Ozone'),]
#      code value_represented
# 781 44201             Ozone


