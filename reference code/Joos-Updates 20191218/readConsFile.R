# FUNCTION: Reading a CONS file -------------------------------------------
readConsFile <- function(path,fileName){
    data <- read_table2(file = file.path(path,fileName),col_names = F,skip = 2)
    data <- data[-which(rowSums(is.na(data)) == ncol(data)),]
    colnames(data) <- paste0('VL',1:ncol(data))
    data <- rbind(data,data[23,])
    data <- cbind(LineLayer = 1:23,HL = 1,data) %>% 
        mutate(
            RN = row_number()
            ,HL = as.integer(RN/23) + 1
            ,IsHeader = LineLayer%%2) %>% 
        filter(
            LineLayer < 23
            ,IsHeader == 0)
    data <- cbind(EyeLayer = c('ILM','NFL','GCL','IPL','INL','OPL','ELM','PR1','PR2','RPE','BM'),data) %>% 
        select(-c(RN,IsHeader,LineLayer)) %>% 
        mutate_at(vars(matches("VL")), as.integer) %>% 
        as_tibble()
    return(data)
}