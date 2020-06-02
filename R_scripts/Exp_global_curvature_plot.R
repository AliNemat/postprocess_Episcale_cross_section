
setwd("C:/Users/Shixin Xu/Ali_Files/UCR/Jamison/Curvature comparison")

infile <- paste("GlobalCurvature_","Pouch.txt",sep="") 
infile2 <- paste("GlobalCurvature_","Peripodium.txt",sep="") 

df <- read.table(infile, header = TRUE)
df2 <- read.table(infile2,header = TRUE)

boxplot (df$globalCurvature_Pouch, df2$GlobalCurvature_Peripodium, ylab ="Global Curvature (1/micro meter)", 
         names=c("Pouch cells","Peripodium cells") )

