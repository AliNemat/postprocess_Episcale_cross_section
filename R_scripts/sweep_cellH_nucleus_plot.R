
#setwd("C:/Users/Shixin Xu/Ali_Files/UCR/Research/Cell height/R")
setwd("/home/ali1363/Public/Episcale_CrossSection/R-scripts/R")

readECMData=0 #readContractionData=1
plotNuc=1 # plot height=0

for(i in 0:3) {
  print (i) 
  if (readECMData==1) {
    #if (i==0 || i==1 || i==2 || i==3) {
      infile <- paste("R_detailedStat_N01G0",i,"_168.txt",sep="") 
    #}
    #else {
    #  infile <- paste("R_detailedStat_N02G0",i-1,"_150.txt",sep="")
    #}
  }
  else {   # readContractionData
    if (i==0 ) {
      infile <- paste("R_detailedStat_N01G0",i,"_168.txt",sep="") 
    }
    else {
      infile <- paste("R_detailedStat_N02G0",i-1,"_168.txt",sep="")
    }
  }
  print (infile) 
  df <- read.table(infile, sep = '\t' ,header = FALSE)
  print (df$V1)   
  #ID<-df$V1
  perim<-df$V1
  centerX<-df$V2
  centerY<-df$V3
  #centerZ<-df$V4
  
  basalX<-df$V4
  basalY<-df$V5
  #basalZ<-df$V7
  
  apicalX<-df$V6
  apicalY<-df$V7
  #apicalZ<-df$V11
  
  nucX<-df$V8
  nucY<-df$V9
  #nucZ<-df$V14
 
  cellLen<-sqrt( (basalX-apicalX)*(basalX-apicalX) + 
                (basalY-apicalY)*(basalY-apicalY) ) 
               # (basalZ-apicalZ)*(basalZ-apicalZ) )
 
  nuclLen<-sqrt(   (basalX-nucX)*(basalX-nucX) + 
                  (basalY-nucY)*(basalY-nucY)  )
                #  (basalZ-nucZ)*(basalZ-nucZ) )
  nucPercent= nuclLen/cellLen
 
  assign (paste("Sim",i,sep="") , data.frame (perim, centerX , centerY ,  
                                             basalX,   basalY,   
                                             apicalX, apicalY, cellLen, nucPercent)
  )

}
print (Sim0)
print ("simulation daat 1")
print (Sim1)
print ("simulation daat 2")
print (Sim2)
print ("simulation daat 3")
print (Sim3)
infileExp <- paste("ThicknessAndNucleus_Exp_Dec19th2018.txt",sep="")
df2<- read.table(infileExp, sep = '\t',header = TRUE)
                    

nucPercentSweepFinal<-list (Sim0$nucPercent, Sim1$nucPercent,
                            Sim2$nucPercent, Sim3$nucPercent, 
                            df2$Nucleus_Position)

cellLenSweepFinal<-list    (Sim0$cellLen, Sim1$cellLen,
                            Sim2$cellLen, Sim3$cellLen, 
                            df2$Cell_Thickness)
#cellLenSweepFinalNoExp<-list    (Sim0$cellLen, Sim1$cellLen,
#                            Sim2$cellLen, Sim3$cellLen) 


if (readECMData==1) {
  if (plotNuc==1) {
    plot1<-boxplot (nucPercentSweepFinal, ylab ="Nucleus Relative position (%)", 
                    xlab="ECM passive tension",
                    names=c("zero (control)","uniform","Medium","High","Experiment")  )
  }
  else { # plot height
    plot2<-boxplot (cellLenSweepFinal, ylab ="Height of pouch cells (micro meter)", 
                    xlab="ECM passive tension",
                    names=c("zero (control)","uniform","Medium","High","Experiment") )
    #plot2<-boxplot (cellLenSweepFinalNoExp, ylab ="Height of pouch cells (micro meter)", 
    #                xlab="ECM passive tension",
    #                names=c("zero (control)","uniform","Medium","High") )
  }
  

}else { # read contract
  if (plotNuc==1) {
    plot1<-boxplot (nucPercentSweepFinal, ylab ="Nucleus Relative position (%)", 
                    xlab="Actinomyosin contractility level ",
                    names=c("zero (control)","Low","Medium","High","Experiment") )
  }
  else { # plot height
    plot2<-boxplot (cellLenSweepFinal, ylab ="Height of pouch cells (micro meter)", 
                    xlab="Actinomyosin contractility level",
                    names=c("Zero (control)","Low","Medium","High","Experiment ") )
    #plot2<-boxplot (cellLenSweepFinalNoExp, ylab ="Height of pouch cells (micro meter)", 
     #               xlab="Actinomyosin contractility level",
    #                names=c("Zero (control)","Low","Medium","High") )
  }
  
  
}

par(cex.lab=1.5) # is for y-axis
par(cex.axis=1.5) 

if (readECMData==1) {

pdf("CellH_ECM_Exp_June2nd2020.pdf",width=9.6 , height=12, useDingbats=FALSE, bg="white")

  boxplot (cellLenSweepFinal, ylab ="Height of pouch cells (micro meter)", 
           xlab="ECM passive tension",
           names=c("zero (control)","uniform","Medium","High","Experiment") )

dev.off()
}else {

pdf("CellH_Contract_Exp_June2nd2020.pdf",width=9.6, height=12, useDingbats=FALSE, bg="white")

boxplot (cellLenSweepFinal, ylab ="Height of pouch cells (micro meter)", 
         xlab="Actinomyosin contractility level",
         names=c("Zero (control)","Low","Medium","High","Experiment ") )

dev.off()
}

