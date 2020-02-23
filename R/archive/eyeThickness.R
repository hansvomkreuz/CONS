# FUNCTION: Calculate thickness -------------------------------------------
eyeThickness <- function(consData){
    firstLayer <- filter(consData,EyeLayer == "ILM") %>% 
        select(-c(1:2))
    lastLayer <- filter(consData,EyeLayer == "BM") %>% 
        select(-c(1:2))
    data <- lastLayer - firstLayer
    return(data)
}
