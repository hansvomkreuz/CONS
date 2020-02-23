#Goal = bulk calculate the minimum rt values to determine the size of the spiral array

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

#extract ILM and BM values
ilm_row_nos <- c(2,36,70,104,138,172,206,240,274,308,342,376,410,444,478,512,546,580,614,648,682,716,750,784,818)
bm_row_nos <- c(32,66,100,134,168,202,236,270,304,338,372,406,440,474,508,542,576,610,644,678,712,746,780,814,848)
ilm<-lapply(list.data,"[", ilm_row_nos,)
bm<-lapply(list.data,"[", bm_row_nos,)

rt <- lapply(seq_along(bm), function(i) bm[[i]][i]-ilm[[i]][i])
do.call(cbind, lst)

matrix<-lapply(ilm, data.matrix())