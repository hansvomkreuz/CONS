# FUNCTION: Tidy CONS data, removing unnecessary rows ---------------------
#' Standardise the number of horizontal layers into 25 rows
#' Currently, able to take into account 25, 49, and 97 rows at the moment

tidyConsData <- function(consData){
    columnNames <- colnames(consData)
    if('HL' %in% columnNames){
        layers <- consData %>% 
            pull(HL) %>% 
            max
        if(layers <= 30){
            consData <- consData %>% 
                filter(HL <= 25)
        }
        if(between(layers,49,50)){
            consData <- consData %>% 
                filter(HL%%2 == 1)
        }
        if(between(layers,73,75)){
            consData <- consData %>% 
                filter(HL%%3 == 1)
        }
        if(between(layers,97,100)){
            consData <- consData %>% 
                filter(HL%%4 == 1)
        }
    } else {
        cat("Looks like the CONS data provided is incorrect. It should contain HL variable.\n")
        cat("No action taken.\n")
    }
    return(consData)
}