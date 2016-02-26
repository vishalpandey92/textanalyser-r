#getting required library for analysis

Needed <- c("tm", "SnowballCC", )   
install.packages(Needed, dependencies=TRUE)   #installing required pakages

cname <- file.path("C:", "texts")   #assigning the workspace
dir(cname) #to get all files in the directory
library(tm)   
docs <- Corpus(DirSource(cname))  #creating a corpus for effective evaluation
summary(docs) 
inspect(docs[1]) #to get the number of chr in the doc

#cleaning the data for effective word analysis
docs <- tm_map(docs, removePunctuation)   #removing all punctuations
inspect(docs[1]) #counting current chr to see that the function worked properly
docs <- tm_map(docs, removeNumbers)       #removing digits
inspect(docs[1]) #counting current chr to see that the function worked properly
docs <- tm_map(docs, tolower)             #converting the case
docs <- tm_map(docs, removeWords, stopwords("english"))   #removing stopwords
library(SnowballC)   
docs <- tm_map(docs, stemDocument)  # *Removing common word endings* (e.g., "ing", "es")
docs <- tm_map(docs, stripWhitespace) #remove spaces
docs <- tm_map(docs, PlainTextDocument)
dtm <- DocumentTermMatrix(docs) #creating the freq matrix
dtm 
freq <- colSums(as.matrix(dtm))
length(freq)
ord <- order(freq, decreasing = TRUE) #arranging words on the basis of freq
m <- as.matrix(dtm)   
dim(m)   
write.csv(m, file="dtm.csv")
print("Maximum occuring words", quote=FALSE)
freq[head(ord)] #getting max occuring words
print("Minimum occuring words", quote=FALSE)
freq[tail(ord)] #getting least occuring words

