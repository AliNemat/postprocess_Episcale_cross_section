clear all
clc
close all
%myFolder = 'C:\Users\Shixin Xu\Downloads\2018\July\7\ECMExport'; % Define your working folder
number_Frames=168
number_Basal_Nodes=1953 ; 
number_Apical_Nodes=1838 ;
number_BC_Nodes=416 ;

notAvailStart=151 ; 
notAvailEnd=150; 

time_ind=0 ; 
for increment =1:number_Frames
    if  increment<notAvailStart || increment>notAvailEnd
        time_ind=time_ind+1 ; 
       
        epi_nodes = load(['ECMLocationExport_N01G00_' num2str(increment) '.txt']); 
       XYBsaal(1:number_Basal_Nodes,1)=epi_nodes(1:number_Basal_Nodes,1) ; 
       XYBsaal(1:number_Basal_Nodes,2)=epi_nodes(1:number_Basal_Nodes,2) ; 

       XYBC(1:number_BC_Nodes,1)=epi_nodes(number_Basal_Nodes+1:number_Basal_Nodes+number_BC_Nodes,1) ; 
       XYBC(1:number_BC_Nodes,2)=epi_nodes(number_Basal_Nodes+1:number_Basal_Nodes+number_BC_Nodes,2) ; 
       
       XYApical(1:number_Apical_Nodes,1)= ...
           epi_nodes(number_Basal_Nodes+number_BC_Nodes+1:number_Basal_Nodes+number_Apical_Nodes+number_BC_Nodes,1) ; 
       XYApical(1:number_Apical_Nodes,2)=...
           epi_nodes(number_Basal_Nodes+number_BC_Nodes+1:number_Basal_Nodes+number_Apical_Nodes+number_BC_Nodes,2) ; 

    %   plot (XY(:,1),XY(:,2)) 
       ParBasal = CircleFitByPratt(XYBsaal) ; 
       ParBC = CircleFitByPratt(XYBC) ;
       ParApical = CircleFitByPratt(XYApical) ;
       meanCurvatureBasal (time_ind)=1/ParBasal(1,3) ;
       meanCurvatureBC (time_ind)=1/ParBC(1,3) ;
       meanCurvatureApical (time_ind)=1/ParApical(1,3) ;
       Time (time_ind)=time_ind ; 

       meanCurvatureBasal22=meanCurvatureBasal ; %%1
       meanCurvatureBC22=meanCurvatureBC ; %%1
       meanCurvatureApical22=meanCurvatureApical ; %%1
       Time22=Time ;  %%2
    end 
end
ExpCurv=0.006*ones (1,time_ind)

 %fprintf(fileID2,'%6.3f %6.3f \n',Time (i,1),meanCurvatureBasal22) ; 
% plot (Time22,meanCurvatureBasal22) %%3
% hold on 
% %plot (Time22,meanCurvatureBC22) %%3
% hold on
% plot (Time22,meanCurvatureApical22) %%3


plot (1:notAvailStart-1,meanCurvatureBasal22(1:notAvailStart-1))
hold on 
plot (notAvailEnd+1:number_Frames,meanCurvatureBasal22(notAvailStart:end))

title(' Basal curvature')
hold off 

figure ; 
plot (1:notAvailStart-1,meanCurvatureApical22(1:notAvailStart-1))
hold on 
plot (notAvailEnd+1:number_Frames,meanCurvatureApical22(notAvailStart:end))
title(' Apical curvature')
hold off 
 figure ;
plot (1:notAvailStart-1,meanCurvatureBC22(1:notAvailStart-1))
hold on 
plot (notAvailEnd+1:number_Frames,meanCurvatureBC22(notAvailStart:end))
title(' BC curvature')


fileID = fopen('ApicalCurvartue_Dec9_0203.txt','w');
TimePrint=(1:notAvailStart-1) ;
ApicalCurvePrint=meanCurvatureApical22(1:notAvailStart-1)
TimePrint2=(notAvailEnd+1:number_Frames) ;
ApicalCurvePrint2=meanCurvatureApical22(notAvailStart:end)

A=[TimePrint ; ApicalCurvePrint] 
A2=[TimePrint2 ; ApicalCurvePrint2] 
fprintf(fileID,'%6.2f %12.8f\n',A) ;
fprintf(fileID,'%6.2f %12.8f\n',A2) ; 
fclose(fileID);

save('run22','meanCurvatureBasal22','meanCurvatureApical22','Time22'); %%4
%plot(Time22,meanCurvatureBasal22, Time22,ExpCurv )

%legend('Computational (ECM contraction)','Experiment (120 h AED)','Location','southeast') % y-axis label
% hold on 
%rectangle('Position', [0 0.004 1000 0.004], 'FaceColor', [1 0 0 0.5])



