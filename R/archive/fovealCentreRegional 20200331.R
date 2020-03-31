# FUNCTION: Find foveal centre from retinal thickness values -------------------------------------------
#' The 'regional' function is a limited version of the original 'fovealCentre' function
#' This function looks at minimum value within a section of the eye:
#' a. 6th to 20th horizontal layers
#' b. 157th to 356th vertical layers
fovealCentreRegional <- function(consData){
    data <- consData %>% 
        mutate(HL = dense_rank(HL)) %>% 
        filter(between(HL,6,20)) %>% 
        select(c(1:7,164:363)) %>% # representing the 157th to 356th vertical layers
        eyeLayerThickness(firstLayer = "ILM",lastLayer = "BM") %>% 
        select(-c(1:5))
    coordinate <- which(data == min(data, na.rm = TRUE), arr.ind = TRUE)
    coordinate[,1] <- coordinate[,1] + 5
    coordinate[,2] <- coordinate[,2] + 156
    return(coordinate)
}
