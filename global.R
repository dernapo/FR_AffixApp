library(tm)
library(wordcloud)
library(memoise)
library(data.table)

DT<-fread("afnic2.csv") #file contains just domains with registration date on 2015

getTermMatrix <- memoise(function (n=5, Data=DT, type="prefix", day="2015-02-03") {
  
  x<-Data[Datedecreation==day]$Sld
  #text<-list_affix.(x, type=type, n=n)
  if (type=="suffix") {
    text<-substr(x, nchar(x)-n+1, nchar(x))
  }
    
    else text<-substr(x, 0, n)
  
  myCorpus <- Corpus(VectorSource(text))
  tdm <- TermDocumentMatrix(myCorpus, control = list(minWordLength = 1))
  
  m <- as.matrix(tdm)
  sort(rowSums(m), decreasing = TRUE)
  
 })
 

# #############################
# ### Load data 
# ### Data source: Afnic
# #############################
# 
# 
# library(data.table)
# 
# 
# # Load data
# temp <- tempfile()
# download.file("https://www.afnic.fr/data/opendata/201602_OPENDATA_A-NomsDeDomaineEnPointFr.zip",temp)
# DT <- as.data.table(read.csv2(unz(temp, "201602_OPENDATA_A-NomsDeDomaineEnPointFr.csv"), header=TRUE))
# unlink(temp)
# rm(temp)
# 
# setnames(DT, gsub("\\.", "", colnames(DT))) #Remove dots from colnames
# setnames(DT, iconv(colnames(DT), to="ASCII//TRANSLIT") )
# 
# 
# DT<-DT[, c("Nomdedomaine", "Datedecreation"), with=FALSE ] #subset data
# DT[, Nomdedomaine:=as.character(Nomdedomaine)]
# DT[, Datedecreation:=as.Date(Datedecreation, "%d-%m-%Y")]
# 
# DT[, Domlength:=nchar(Nomdedomaine)]
# 
# DT[, Sld:=gsub("\\..*$", "", Nomdedomaine)]
# 
# setkey(DT, Nomdedomaine)
# DT<-DT[-grep ("^xn--", Nomdedomaine)]
