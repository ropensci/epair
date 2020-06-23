# Experiment with replacing rvest function with modification function

source("epaGrabber/R/EPAGrabberUtility.R")

# Replace the rvest function, with a modified version
assignInNamespace("html_table.xml_node", modified.html_table.xml_node, ns = "rvest")

# Check the modification is present
rvest:::html_table.xml_node
