clear all
clc
close all
%myFolder = 'C:\Users\Shixin Xu\Downloads\2018\July\7\ECMExport'; % Define your working folder
number_Frames=167
number_Basal_Nodes=1953 ; 
number_Apical_Nodes=1838 ;
number_BC_Nodes=416 ;

notAvailStart=151 ; 
notAvailEnd=150; 

time_ind=0 ; 
for increment =1:number_Frames
    if  increment<notAvailStart || increment>notAvailEnd
        time_ind=time_ind+1 ; 
       
        epi_nodes = load(['ECMLocationExport_N03G01_' num2str(increment) '.txt']); 
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


fileID_apical = fopen('ApicalCurvartue_0202_June16th2020.txt','w');
fileID_basal  = fopen('BasalCurvartue_0202_June16th2020.txt','w');

time_part1=(1:notAvailStart-1) ;
time_part2=(notAvailEnd+1:number_Frames) ;

apical_curve_part1=meanCurvatureApical22(1:notAvailStart-1)
apical_curve_part2=meanCurvatureApical22(notAvailStart:end)

basal_curve_part1 =meanCurvatureBasal22(1:notAvailStart-1)
basal_curve_part2 =meanCurvatureBasal22(notAvailStart:end)


time_and_apical_curve_part1=[time_part1 ; apical_curve_part1] 
time_and_apical_curve_part2=[time_part2 ; apical_curve_part2] 
fprintf(fileID_apical,'%6.2f %12.8f\n',time_and_apical_curve_part1) ;
fprintf(fileID_apical,'%6.2f %12.8f\n',time_and_apical_curve_part2) ; 
fclose(fileID_apical);

time_and_basal_curve_part1=[time_part1 ; basal_curve_part1] 
time_and_basal_curve_part2=[time_part2 ; basal_curve_part2] 
fprintf(fileID_basal,'%6.2f %12.8f\n',time_and_basal_curve_part1) ;
fprintf(fileID_basal,'%6.2f %12.8f\n',time_and_basal_curve_part2) ; 
fclose(fileID_basal);

save('run22','meanCurvatureBasal22','meanCurvatureApical22','Time22'); %%4
%plot(Time22,meanCurvatureBasal22, Time22,ExpCurv )

%legend('Computational (ECM contraction)','Experiment (120 h AED)','Location','southeast') % y-axis label
% hold on 
%rectangle('Position', [0 0.004 1000 0.004], 'FaceColor', [1 0 0 0.5])

double (meanCurvatureBasal22(end))

