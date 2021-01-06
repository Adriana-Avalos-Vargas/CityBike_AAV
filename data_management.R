#Citybike data managing and cleaning

#Let's fix the working directory
setwd("tec_documentos_plataforma/tareas/tarea_15/data")

#Lets import data
JC-202011-citibike-tripdata
data <- read.csv("JC-202011-citibike-tripdata.csv", header = T, stringsAsFactors = F)
#Let's create a vector of dates
dates <- c(202011, 202010, 202009,202008,202007, 202006,202005,202004,202003,202002,202001,201912,201911)

#Import 12 files into a list
lista <- list()

for(i in 1:13){
  #Create a text chain with the name of eac file
  name_file <- paste0("JC-",dates[i],"-citibike-tripdata.csv")
  lista[[i]]<- read.csv(name_file, header = T, stringsAsFactors = F)
}

names_comparison <- c()

#Let's check the name of the features of each dataframe
for (i in 1:12) {
  print(length(colnames(lista[[i]])))
  print(length(colnames(lista[[i+1]])))
  names_comparison[i]<- names(lista[[i]])==names(lista[[i+1]])
}

#Let's call the comparison vector
names_comparison

#Since the 13 data frames has the same columns names it is posible to join them in one unique
#dataframe
data <- NULL

for (i in 1:length(lista)) {
  data <- rbind.data.frame(data, lista[[i]])
  
}

#Now lets remove duplcated data in the final dataframe
library(dplyr)

n <- nrow(data)

data <- data %>% distinct()

m <- nrow(data)

#Lets check how many rows we drop
print(paste("We drop", n-m, "repeated rows", sep=" "))

#Save the final dataframe
setwd("C:/Users/avalo/OneDrive/Documentos/tec_documentos_plataforma/tareas/tarea_15/CityBike_AAV")
write.csv(data, "citybike_data.csv")
