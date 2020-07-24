# Find a way to include service descriptions for each service. 

library(rvest)
source("Utility.R")

# if (j+k > nrow(out)) break;
# Should go into xml_node to actually work.
fixInNamespace("html_table.xml_node", "rvest")

# Fill up SERVICE.NAMES
get.service.names()

# Fill up the global variable SERVICES
# -- this will now contain complete information regarding which services to use
get.services()

# Experiment with SERVICES to determine what service is needed
SERVICES
