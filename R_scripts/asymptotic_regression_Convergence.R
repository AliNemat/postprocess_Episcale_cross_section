## input is output of Matlab code which gives a txt file 
## Matlab output contains two rows first row the index of written file by cplusplus code ( In here every 300 seconds one file is written
## second row is either basal or apical curvature.
## the consequence is as following Cplusplus GPU code (output: ECMlocation.txt) --> Matlab (output: basal_curve)-->R script plots asymtotic regression

setwd("/home/ali1363/Public/Episcale_CrossSection/R-scripts/R")
infile <- paste("basal_curve_0202_June16th2020.txt",sep="") 


df <- read.table(infile, sep = "",header = FALSE)

ID<-df$V1
ID2<-df$V2
Time<-df$V1
Curve<-df$V2
pdf("Convergence_basal_June16th2020.pdf",width=12, height=6, useDingbats=FALSE)

plot (Time*300, Curve, col='blue')
#fit <- lm(Curve~log(Time))
#fit<-lm(Curve ~ poly(Time, 2, raw=TRUE))
XY<-sortedXyData(Time, Curve)
fit<-NLSstAsymptotic (XY)
#points(Time, fitted(fit), col='red', pch=20)

x<-vector()
y<-vector()
for(i in 0:2000) {
  
 x[i]<- i*300
 y[i]<-  fit[1] + fit[2]*(1-exp(-exp(fit[3]) * i)) 
}

lines (x,y)

dev.off()

#y[i]<-fit$coefficients[1]+ fit$coefficients[2]*i + fit$coefficients[3]*i*i +  fit$coefficients[4]*i*i*i
#y[i]<-fit$coefficients[1]+ fit$coefficients[2]*log (i) 
#z[i]<- 0.001 
