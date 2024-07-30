# Utility code

pacman::p_load(stringr)

## Find and Replace String in Files --------------------------------------------

files_list <- list.files("content", recursive = TRUE, full.names = TRUE)
str_old <- "Contact Entry Guidance"
str_new <- "Contact Records"

for (i in files_list){
  text_i <- readLines(i)
  text_i_updated <- str_replace_all(text_i, str_old, str_new)
  if(any(text_i != text_i_updated)){
    print(i)
    writeLines(text_i_updated, i)  
  }
}

## Find and Replace File Names --------------------------------------------

files_list <- list.files("content", recursive = TRUE, full.names = TRUE)
str_old <- "sa_science_catalog"
str_new <- "science_catalog"

for (i in files_list){
  filename_i <- i
  filename_i_updated <- str_replace_all(filename_i, str_old, str_new)
  if(filename_i != filename_i_updated){ 
    print(i)
    file.rename(filename_i, filename_i_updated)  
  }
}


