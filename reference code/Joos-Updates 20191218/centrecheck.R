# FUNCTION: display heatmap of retinal thickness to manually check foveal centre -------------------------------------------
centrecheck <- function(consData){
  firstLayer <- filter(consData,EyeLayer == "ILM") %>% 
    select(-c(1:2))
  lastLayer <- filter(consData,EyeLayer == "BM") %>% 
    select(-c(1:2))
  data <- lastLayer - firstLayer
  heatmap <- heatmap(as.matrix(data), Colv = NA, Rowv = NA, scale = "column")
  return(heatmap)
}

#testing
#centrecheck(testConsData)