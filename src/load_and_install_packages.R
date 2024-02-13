#' Load and offer to install packages
#'
#' Given a list of packages:
#' * Check if they're installed
#' * Offer to install missing
#' * Load packages
#'
#' This function will try to load a specified package or list of packages.  If a
#' package isn't already installed, it will offer to install it.  This part only
#' works on Windows currently.  If any package is missing and cannot be
#' installed, it will halt.
#'
#' @param required_packages A character vector of package names
#'
#' @return (invisible) The list of packages loaded
#'
#' @importFrom methods is
#' @importFrom utils install.packages installed.packages str winDialog
#'
#' @export
#'
#' @examples
#' load_and_install_packages("datasets")
#' load_and_install_packages(c("datasets", "graphics"))
#'
load_and_install_packages <- function(required_packages) {
  # Check which required packages are installed, so we can prompt to install any
  # missing ones
  installed_req_packages <- required_packages %in% rownames(installed.packages())

  if (any(installed_req_packages == FALSE)) {
    missing_packages <- required_packages[!installed_req_packages]

    # Throw an error about missing packages
    warning("Required packages are not installed: ", toString(missing_packages), sep = "")

    # Ask what the user wants to do - it's rude to install without permission
    user_response <- winDialog(
      type = "yesno",
      message = paste(
        "Some required package(s) are not installed: \n\n",
        toString(missing_packages),
        "\n\nDo you want to install missing packages and continue?"
      )
    )

    if (user_response == "YES") {
      message("Installing missing packages...")
      install.packages(missing_packages)

      # Check for successful installation, and stop gracefully if still missing
      installed_req_packages <- required_packages %in% rownames(installed.packages())
      if (any(installed_req_packages == FALSE)) {
        stop("Package installation failed.  Still missing package(s) ", missing_packages, ". Script cannot continue.")
      }
    } else {
      stop("Missing package(s) ", missing_packages, " are not installed. Script cannot continue.")
    }
  }

  # Load packages (using library() so it'll fail immediately on missing packages)
  lapply(required_packages, library, character.only = TRUE)

  invisible(required_packages)
}
