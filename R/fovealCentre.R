# FUNCTION: Find foveal centre from retinal thickness values -------------------------------------------
fovealCentre <- function(consData){
    data <- eyeLayerThickness(consData,firstLayer = "ILM",lastLayer = "BM") %>% 
        select(-c(1:5))
    coordinate <- which(data == min(data, na.rm = TRUE), arr.ind = TRUE)
    return(coordinate)
}
