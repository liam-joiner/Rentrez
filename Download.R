#install and load the package onto R
install.packages("rentrez")
install.packages("seqinr")
library(rentrez)
library(dplyr)
library(seqinr)
library(ggplot2)

#set the vector containing the ascension numbers of the Borreliella 16S sequences that are to be retreived
ncbi_ids <- c("HQ433692.1","HQ433694.1","HQ433691.1")

#create vector Bburg that used entrez_fetch function to pull complete representation of record from the NCBI database
#inside the function there are three elements: 1. the database we wish to pull from 2. the ascension numbers of the sequences 3. specify the format of the retreived information
Bburg<-entrez_fetch(db = "nuccore", id = ncbi_ids, rettype = "fasta")

#creation of vector with 3 components, each a different sequence
Sequences<-strsplit(Bburg, ".>", fixed = FALSE)               

#use seqinr and write.fasta to create csv file containg the output vector
write.fasta(sequences=Sequences,names=Sequences, file.out="Sequences")

#take data from GC content, and trim what is not needed
X<-read.csv("GC_content.csv")
select(X, G, C, Species)

#create scatterplot
cols<-c("A" = "red","B" = "blue","C" = "green")

Z<-ggplot(data=X, aes( x=G, y=C,  color=Species, shape=Species))  +
  geom_point()
Z + labs(x="%G", y="%C", title="Percentage of Guanune and Cytosine in Nucleotide Sequences") 
Z + scale_color_manual(values=cols)










