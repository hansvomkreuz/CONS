# FUNCTION: Set R, data, and image directories ----------------------------
createDirectory <- function(dir){
    if (file.exists(dir)){
        cat(dir,"directory already exists.\n")
    } else {
        cat(dir,"directory does not exist. Creating",dir,"directory.\n")
        dir.create(file.path(dir))
    }
}
