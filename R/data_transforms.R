#' Replace all characters entries in data frame
#' 
#' @param df Data frame containing character entries
#' @param pattern Pattern to use for matching
#' @param replacement Replacement of entries matching pattern
#'
#' @return A data frame with entries following the pattern being replaced
#' by replacement
#'
#' @examples
#' df <- data.frame(c("1", "2", "3", "4"))
#' modified.df <- epair:::string.replacer(df, "1", "One")
#' modified.df
string.replacer <- function(df, pattern, replacement) {
  modified.df <- lapply(df,
                        gsub,
                        pattern = pattern,
                        replacement = replacement,
                        fixed = TRUE)
  return(as.data.frame(modified.df))
}

#' Replace every string entry in a list 
#'
#' @param entry.list List containing character entries
#' @param pattern Pattern to replace
#' @param replacement Replacement for entries following the pattern
#'
#' @return A list with entries matching the pattern replaced by replacement
#'
#' @examples
#' services <- list("\t Some text from the table")
#' services <- epair:::list.string.replacer(services, "\t", "")
#' services
list.string.replacer <- function(entry.list, pattern, replacement) {
  new.list <- rapply(entry.list, 
                     gsub, 
                     pattern = pattern, 
                     replacement = replacement, 
                     fixed = TRUE,
                     how = "replace")
  return(new.list)
}

#' Remove tabs, new lines, and empty spaces from entries in a data frame
#'
#' @param df Data frame to remove tabs, new lines, and empty spaces from
#'
#' @return Data frame without tabs, new lines, and empty spaces
#'
#' @examples
#' service <- c("Sign up")
#' description <- c("Email will\r\n\t\t\t\t\t\t\t be sent to the registered
#' address from aqsdatamart@epa.gov.")
#' 
#' og.df <- data.frame(service, description)
#' clean.df <- epair:::remove.escapes.spaces(og.df)
#' clean.df
remove.escapes.spaces <- function(df) {
  clean.df <- string.replacer(df, "\t", "")
  clean.df <- string.replacer(clean.df, "\r\n", "")
  clean.df <- string.replacer(clean.df, "   ", "")
  return(clean.df)
}

#' Remove tabs, new lines, and empty spaces from entries in a list
#'
#' @param a.list List to remove entries from.
#'
#' @return A list without tabs, new lines, and empty spaces
#'
#' @examples
#' service <- c("Sign up")
#' description <- c("Email will\r\n\t\t\t\t\t\t\t be sent to the registered
#' address from aqsdatamart@epa.gov.")
#' 
#' og_list <- list("service" = service, "description" = description)
#' clean <- epair:::remove.escapes.spaces(og_list)
#' clean
list.remove.escapes.spaces <- function(a.list) {
  new.list <- list.string.replacer(a.list, "\t", "")
  new.list <- list.string.replacer(new.list, "\r\n", "")
  new.list <- list.string.replacer(new.list, "   ", "")
  return(new.list)
}

#' Transpose a data frame
#'
#' @param df Data frame to be transposed
#'
#' @return The transposed data frame. First variable entries become 
#' column names.
#'
#' @examples
#' service <- c("Sign up")
#' description <- c("Email will\r\n\t\t\t\t\t\t\t be sent to the registered 
#' address from aqsdatamart@epa.gov.")
#' df <- data.frame(service, description)
#' t.df <- epair:::get.transpose(df)
#' t.df
get.transpose <- function(df) {
  t.df <-  t(df)
  t.names <- c()
  for(i in seq_len(nrow(df))) {
    t.names <- c(t.names, df[i, 1])
  }
  colnames(t.df) <- t.names
  return(as.data.frame(t.df, stringsAsFactors = FALSE))
}
