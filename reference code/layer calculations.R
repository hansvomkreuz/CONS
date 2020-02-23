#load libraries
library(tidyverse)
library(reticulate)

#set_wd
setwd("~/Google Drive/01 OPEN PROJECTS/RETINAL RESEARCH FELLOWSHIP/CONS/data_analysis/OCTs")

#mass import oct data
list.filenames<-list.files(pattern=".xls$") # list all csv files from the current directory
list.data<-list() # an empty list that will serve as a container to receive the incoming files
for (i in 1:length(list.filenames)) # create a loop to read in your data
{
  list.data[[i]]<-read_table2(list.filenames[i], col_names = FALSE, skip = 2)
}
names(list.data)<-list.filenames # add the names of your data to the list


#load files
od167 <- read_table2("~/Google Drive/01 OPEN PROJECTS/RETINAL RESEARCH FELLOWSHIP/CONS/data_analysis/OCTs/167od.xls", col_names = FALSE, skip = 2)
os167 <- read_table2("~/Google Drive/01 OPEN PROJECTS/RETINAL RESEARCH FELLOWSHIP/CONS/data_analysis/OCTs/167os.xls", col_names = FALSE, skip = 2)

#extract ILM and BM values
ilm_row_nos <- c(2,36,70,104,138,172,206,240,274,308,342,376,410,444,478,512,546,580,614,648,682,716,750,784,818)
nfl_row_nos <- c(5,39,73,107,141,175,209,243,277,311,345,379,413,447,481,515,549,583,617,651,685,719,753,787,821)
gcl_row_nos <- c(8,42,76,110,144,178,212,246,280,314,348,382,416,450,484,518,552,586,620,654,688,722,756,790,824)
ipl_row_nos <- c(11,45,79,113,147,181,215,249,283,317,351,385,419,453,487,521,555,589,623,657,691,725,759,793,827)
inl_row_nos <- c(14,48,82,116,150,184,218,252,286,320,354,388,422,456,490,524,558,592,626,660,694,728,762,796,830)
opl_row_nos <- c(17,51,85,119,153,187,221,255,289,323,357,391,425,459,493,527,561,595,629,663,697,731,765,799,833)
elm_row_nos <- c(20,54,88,122,156,190,224,258,292,326,360,394,428,462,496,530,564,598,632,666,700,734,768,802,836)
pr1_row_nos <- c(23,57,91,125,159,193,227,261,295,329,363,397,431,465,499,533,567,601,635,669,703,737,771,805,839)
pr2_row_nos <- c(26,60,94,128,162,196,230,264,298,332,366,400,434,468,502,536,570,604,638,672,706,740,774,808,842)
rpe_row_nos <- c(29,63,97,131,165,199,233,267,301,335,369,403,437,471,505,539,573,607,641,675,709,743,777,811,845)
bm_row_nos <- c(32,66,100,134,168,202,236,270,304,338,372,406,440,474,508,542,576,610,644,678,712,746,780,814,848)

#extract ilm and bm
od167_ilm <- od167 %>% 
  slice(ilm_row_nos)
od167_bm <- od167 %>% 
  slice(bm_row_nos)

#convert to matrix
bm<-data.matrix(od167_bm)
ilm<-data.matrix(od167_ilm)

#subtract ilm and bm matricies
rt<-bm-ilm

#identify index of lowest value
min_index<-which(rt == min(rt, na.rm = TRUE), arr.ind = TRUE)
min_index

#add index observations to create wind pattern
X2<-c(min_index[1,1],min_index[1,2]+1)
X3<-c(min_index[1,1]-1,min_index[1,2]+1)
X2
index<-rbind(min_index,X2,X3)
index

#spiral function at dimensions 25*512
source_python("~/Google Drive/01 OPEN PROJECTS/RETINAL RESEARCH FELLOWSHIP/CONS/data_analysis/CONS/spiral.py")
spiral(25, 512)

cords <- read_csv("~/Google Drive/01 OPEN PROJECTS/RETINAL RESEARCH FELLOWSHIP/CONS/data_analysis/CONS/coordinates.csv")
cords$new = as.numeric(gsub("[\\(),]","",cords$`0)`))



#extraction using index
rt[as.matrix(index)]