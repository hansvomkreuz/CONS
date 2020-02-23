# FUNCTION: Calculate GCL thickness ----------------------------------------
gclThickness <- function(consData){
  data <- eyeLayerThickness(consData,firstLayer = "NFL", lastLayer = "GCL")
  return(data)
}
