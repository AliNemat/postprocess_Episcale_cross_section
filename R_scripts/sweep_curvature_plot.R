require (ggplot2)
attach (SweepStudy_Dec6th2018)
InputAndCurv=data.frame (SweepStudy_Dec6th2018)

apicalCurveContractSim=c( InputAndCurv [1:4,8])
apicalCurveECMSim=c( InputAndCurv [1,8],InputAndCurv [5,8],InputAndCurv [7,8],InputAndCurv [8,8])
apicalCurveExp= InputAndCurv [10,8]


basalCurveContractSim=c ( InputAndCurv [1:4,9])
basalCurveECMSim=c ( InputAndCurv [1,9],InputAndCurv [5,9],InputAndCurv [7,9],InputAndCurv [8,9])
basalCurveExp= InputAndCurv [10,9]

#apicalCurve=c( apicalCurveContractSim , apicalCurveExp )
apicalCurve=c( apicalCurveECMSim , apicalCurveExp )
#basalCurve =c( basalCurveContractSim , basalCurveExp )
basalCurve =c( basalCurveECMSim , basalCurveExp )
#contractLevel=c ("zero (control)","Low","Medium","High","Exp. (not data)")
level=c (0,1,2,3,4)
curve=cbind (level,apicalCurve, basalCurve )

curveData=data.frame (curve)


p = ggplot() + 
  #geom_line(data=curveContractData , aes(x = contractLevel, y = basalCurveContract, color = "blue"),size=1) + 
  #theme_bw()+
  geom_point(data=curveData, aes(x = level, y = basalCurve, color = "blue"),size=5) + 
  theme_bw()+
  #geom_line(data=curveContractData , aes(x = contractLevel, y = apicalCurveContract, color = "red"), size=1) +
  #theme_bw() +
  geom_point(data=curveData , aes(x = level, y = apicalCurve, color = "red"),size=5) + 
  theme_bw()+
  scale_color_discrete(name = "Curvature", labels = c("Basal", "Apical")) +
  #xlab(expression(paste("Actomyosin contractility (nN/" , mu, "m)"))) +
  #xlab("Actomyosin contractility level") +
  xlab("ECM passive tension") +
  ylab(expression(paste("Curvature (1/", mu , "m)"))) +
  theme(axis.text=element_text(size=18, ,face="bold"),
        axis.title=element_text(size=18,face="bold"),
        title=element_text(size=18,face="bold"),
        legend.text=element_text(size=18),
        legend.position = c(0.2, 0.8)) 

print(p)

