# FUNCTION: Display heatmap of retinal thickness --------------------------
# Render eye image of retinal thickness to manually check foveal centre
renderEyeImage <- function(consData,imageDirectory = "./image"){
  center <- fovealCentre(consData)
  consFileName <- consData %>% 
    pull(FileName2) %>% 
    unique()
  imageLabel <- paste0(consFileName,": (",center[1,1],",",center[1,2],")")
  imageFileName <- file.path(imageDirectory,paste0(consFileName,".jpg"))
  data <- eyeLayerThickness(consData,firstLayer = "ILM", lastLayer = "BM") %>% 
    select(-c(1:5))
  heatmap <- heatmap(as.matrix(data), Colv = NA, Rowv = NA, scale = "column", main = imageLabel)
  # heatmap(as.matrix(data), Colv = NA, Rowv = NA, scale = "column", main = imageLabel)
  dev.copy(jpeg,filename = imageFileName);
  dev.off ()
}
