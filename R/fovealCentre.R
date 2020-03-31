# FUNCTION: Find foveal centre from retinal thickness values -------------------------------------------
#' Merging fovealCentre and fovealCentreRegional functions into one
#' The 'regional' function is a limited version of the original 'fovealCentre' function
#' This function looks at minimum value within a section of the eye:
#' a. 6th to 20th horizontal layers
#' b. 157th to 356th vertical layers
fovealCentre <- function(consData,regionalEyeCenter = TRUE){
    if(regionalEyeCenter){
        data <- consData %>% 
            mutate(HL = dense_rank(HL)) %>% 
            filter(between(HL,6,20)) %>% 
            select(c(1:7,164:363))
    } else {
        data <- consData
    }
    data <- eyeLayerThickness(data,firstLayer = "ILM",lastLayer = "BM") %>% 
        select(-c(1:5))
    coordinate <- which(data == min(data, na.rm = TRUE), arr.ind = TRUE)
    if(regionalEyeCenter){
        coordinate[,1] <- coordinate[,1] + 5
        coordinate[,2] <- coordinate[,2] + 156
    }
    return(coordinate)
}
