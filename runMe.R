# Compressive Optic Neuropathy Study (CONS) -------------------------------
#' This is the main code to read and process the eye data for the CONS study
#' This code does the following:
#' 1. loads the required libraries: tidyverse and tictoc
#' 2. loads and calls on the CONS function
#' 
#' These are the parameters of the CONS function:
#' 1. codeDir is where the R codes are stored, to be loaded, and called
#' 2. dataDir is where the .xls files are stored
#' 3. imageDir is where the images are saved for each of the .xls filed processed

# Load libraries ----------------------------------------------------------
rm(list = ls())
library(tidyverse)
library(tictoc)
library(pryr)

# Load all R codes --------------------------------------------------------
codeDir <- "./CONS/R"
list.files(path = codeDir,pattern = ".R$") %>% 
    walk(
        function(x){
            fileName <- file.path(codeDir,x)
            source(fileName)
        })

# Read files --------------------------------------------------------------
eyeDataInitial <- CONS(dataDir = "/Users/GiusseppeMac/Downloads/Joos Meyer - CONS - DONT DELETE/all_data", imageDir = "./images")

# Create merged files -----------------------------------------------------
mergePatientDetails(eyeDataInitial = "/Users/GiusseppeMac/Downloads/Joos Meyer - CONS - DONT DELETE/all_data/eyeDataInitial.rds")
mergeScanData(eyeDataInitial = "/Users/GiusseppeMac/Downloads/Joos Meyer - CONS - DONT DELETE/all_data/eyeDataInitial.rds")
mergeGclMatrix(eyeDataInitial = "/Users/GiusseppeMac/Downloads/Joos Meyer - CONS - DONT DELETE/all_data/eyeDataInitial.rds")
mergeCleanGclArray(eyeDataInitial = "/Users/GiusseppeMac/Downloads/Joos Meyer - CONS - DONT DELETE/all_data/eyeDataInitial.rds")

# Create index data -------------------------------------------------------
indexData <- indexGenerator(eyeDataInitial = "/Users/GiusseppeMac/Downloads/Joos Meyer - CONS - DONT DELETE/all_data/eyeDataInitial.rds")
write.csv(indexData,file = "./indexData.csv")

# Example: Select GCL array given index -----------------------------------
mergedCleanedGclArray_13 <- readRDS("~/Downloads/Joos Meyer - CONS - DONT DELETE/all_data/mergedCleanedGclArray_13.rds")
arrayIndex <- c(
    888	,887	,886	,885	,884	,883	,882	,881	,880	,879	,878	,877	,876	,875	,874
    ,773	,772	,771	,770	,769	,768	,767	,766	,765	,764	,763	,762	,761	,760	,873
    ,666	,665	,664	,663	,662	,661	,660	,659	,658	,657	,656	,655	,654	,759	,872
    ,567	,566	,565	,564	,563	,562	,561	,560	,559	,558	,557	,556	,653	,758	,871
    ,476	,475	,474	,473	,472	,471	,470	,469	,468	,467	,466	,555	,652	,757	,870
    ,393	,392	,391	,390	,389	,388	,387	,386	,385	,384	,465	,554	,651	,756	,869
    ,318	,317	,316	,315	,314	,313	,312	,311	,310	,383	,464	,553	,650	,755	,868
    ,251	,250	,249	,248	,247	,246	,245	,244	,309	,382	,463	,552	,649	,754	,867
    ,192	,191	,190	,189	,188	,187	,186	,243	,308	,381	,462	,551	,648	,753	,866
    ,141	,140	,139	,138	,137	,136	,185	,242	,307	,380	,461	,550	,647	,752	,865
    ,98	,97	,96	,95	,94	,135	,184	,241	,306	,379	,460	,549	,646	,751	,864
    ,63	,62	,61	,60	,93	,134	,183	,240	,305	,378	,459	,548	,645	,750	,863
    ,36	,35	,34	,59	,92	,133	,182	,239	,304	,377	,458	,547	,644	,749	,862
    ,17	,16	,33	,58	,91	,132	,181	,238	,303	,376	,457	,546	,643	,748	,861
    ,6	,15	,32	,57	,90	,131	,180	,237	,302	,375	,456	,545	,642	,747	,860    
)
eyeSection <- mergedCleanedGclArray_13[,c(1:3,arrayIndex)]

