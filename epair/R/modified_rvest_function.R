#### Function from rvest. 
#### Modified line 63 to allow for multi indexed html table grabbing. 

#' Modified html_table.xml_node 
#' 
#' See original specs for html_table.xml_node in rvest package. Modification done 
#' to allow for more flexible table scraping in websites.
#'
#' @param x 
#' @param header 
#' @param trim 
#' @param fill 
#' @param dec 
#'
#' @return
#' @export
#'
#' @examples
modified.html_table.xml_node <- function (x, header = NA, trim = TRUE, fill = FALSE, dec = ".") 
{
  stopifnot(html_name(x) == "table")
  rows <- html_nodes(x, "tr")
  n <- length(rows)
  cells <- lapply(rows, "html_nodes", xpath = ".//td|.//th")
  ncols <- lapply(cells, html_attr, "colspan", default = "1")
  ncols <- lapply(ncols, as.integer)
  nrows <- lapply(cells, html_attr, "rowspan", default = "1")
  nrows <- lapply(nrows, as.integer)
  p <- unique(vapply(ncols, sum, integer(1)))
  maxp <- max(p)
  if (length(p) > 1 & maxp * n != sum(unlist(nrows)) & maxp * 
      n != sum(unlist(ncols))) {
    if (!fill) {
      stop("Table has inconsistent number of columns. ", 
           "Do you want fill = TRUE?", call. = FALSE)
    }
  }
  values <- lapply(cells, html_text, trim = trim)
  out <- matrix(NA_character_, nrow = n, ncol = maxp)
  for (i in seq_len(n)) {
    row <- values[[i]]
    ncol <- ncols[[i]]
    col <- 1
    for (j in seq_len(length(ncol))) {
      out[i, col:(col + ncol[j] - 1)] <- row[[j]]
      col <- col + ncol[j]
    }
  }
  for (i in seq_len(maxp)) {
    for (j in seq_len(n)) {
      rowspan <- nrows[[j]][i]
      colspan <- ncols[[j]][i]
      if (!is.na(rowspan) & (rowspan > 1)) {
        if (!is.na(colspan) & (colspan > 1)) {
          nrows[[j]] <- c(utils::head(nrows[[j]], i), 
                          rep(rowspan, colspan - 1), utils::tail(nrows[[j]], 
                                                                 length(rowspan) - (i + 1)))
          rowspan <- nrows[[j]][i]
        }
        for (k in seq_len(rowspan - 1)) {
          # Modification to rvest original
          if (j+k > nrow(out)) break;
          # Modification to rvest original
          l <- utils::head(out[j + k, ], i - 1)
          r <- utils::tail(out[j + k, ], maxp - i + 1)
          out[j + k, ] <- utils::head(c(l, out[j, i], 
                                        r), maxp)
        }
      }
    }
  }
  if (is.na(header)) {
    header <- all(html_name(cells[[1]]) == "th")
  }
  if (header) {
    col_names <- out[1, , drop = FALSE]
    out <- out[-1, , drop = FALSE]
  }
  else {
    col_names <- paste0("X", seq_len(ncol(out)))
  }
  df <- lapply(seq_len(maxp), function(i) {
    utils::type.convert(out[, i], as.is = TRUE, dec = dec)
  })
  names(df) <- col_names
  class(df) <- "data.frame"
  attr(df, "row.names") <- .set_row_names(length(df[[1]]))
  if (length(unique(col_names)) < length(col_names)) {
    warning("At least two columns have the same name")
  }
  df
}