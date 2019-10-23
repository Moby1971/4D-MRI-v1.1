% ----------------------------
%  Radial k-space trajectory
%
%  Gustav Strijkers
%  April 2019
%  
% ----------------------------

%% clear all

clc;
clearvars;
close all force;


%% Initialization

outputdir = '/Users/Gustav/Desktop/';

dimy = 96;
dimx = 96;
number_of_spokes = 400;

tiny_golden_angles = [111.24611, 68.75388, 49.75077, 38.97762, 32.03967, 23.62814, 20.88643, 18.71484, 16.95229];
angle_nr = 1;

%% fill the list

range = max([dimy,dimx]);
rb = -round(range/2)+1;
re = round(range/2);
angle = 0;
kspacelist=[];

for ns = 1:number_of_spokes
    
    nr=1;
    clear c;
    for i=rb:re
        
        c(nr,:) = [round(i * cos(angle*pi/180)),round(i * sin(angle*pi/180))];
        nr = nr + 1;
        
    end
    
    c = unique(c,'Rows','Stable');
    kspacelist = [kspacelist;c];
    
    angle = angle + tiny_golden_angles(angle_nr);
end

kspacelist = round(2*kspacelist./[dimx, dimy],4);

figure;

scatter(kspacelist(:,1),kspacelist(:,2),'s')
    
%% export matrix

kspacelist = kspacelist(1:dimy*dimx,:);

csvwrite([outputdir,'xcor.CSV'],kspacelist(:,1)');
csvwrite([outputdir,'ycor.CSV'],kspacelist(:,2)');


