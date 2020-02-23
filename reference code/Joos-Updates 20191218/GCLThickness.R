# FUNCTION: Calculate GCL thickness ----------------------------------------
GCLThickness <- function(consData){
  firstLayer <- filter(consData,EyeLayer == "NFL") %>% 
    select(-c(1:2))
  lastLayer <- filter(consData,EyeLayer == "GCL") %>% 
    select(-c(1:2))
  data <- lastLayer - firstLayer
  return(data)
}
