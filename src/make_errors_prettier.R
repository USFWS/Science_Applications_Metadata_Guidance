make_errors_prettier <- function() {
  if (exists('HALT_ERROR', inherits = TRUE)) rm(HALT_ERROR)
  
  knitr::knit_hooks$set(
    error = function(x, options) {
      paste('\n\n<div class="alert alert-danger">',
            gsub('##', '\n', gsub('^##\ Error', '**Error**', x)),
            '</div>', sep = '\n')
      HALT_ERROR <<- x
      knitr::knit_exit()
    },
    warning = function(x, options) {
      paste('\n\n<div class="alert alert-warning">',
            gsub('##', '\n', gsub('^##\ Warning:', '**Warning**', x)),
            '</div>', sep = '\n')
    },
    message = function(x, options) {
      paste('\n\n<div class="alert alert-info">',
            gsub('##', '\n', x),
            '</div>', sep = '\n')
    }
  )
  
  knitr::knit_hooks$set(chunk = function(x, options) {
    if (exists('HALT_ERROR') && length(HALT_ERROR) > 0) {
      paste0(x,
             paste('\n\n<div class="alert alert-danger">',
            gsub('##', '\n', gsub('^##\ Error', '**Error**', HALT_ERROR)),
            '</div>', sep = '\n'))
    } else { 
      x
    }
  })
}
