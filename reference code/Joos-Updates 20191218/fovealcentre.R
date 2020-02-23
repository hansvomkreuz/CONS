# FUNCTION: Find foveal centre from retinal thickness values -------------------------------------------
fovealcentre <- function(consData){
    firstLayer <- filter(consData,EyeLayer == "ILM") %>% 
        select(-c(1:2))
    lastLayer <- filter(consData,EyeLayer == "BM") %>% 
        select(-c(1:2))
    data <- lastLayer - firstLayer
    mincoordinate <- which(data == min(data, na.rm = TRUE), arr.ind = TRUE)
    return(mincoordinate)
}
