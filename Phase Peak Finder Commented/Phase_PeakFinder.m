%Author : Sarav Shah

%This program will go through your input signal and will determine the onset time for phase 1, phase 2, and phase 3 in pupal ecdysis. 



% Load the data set you are working with. Columns should be samples, and Rows should be time.

load Exploratory_data.mat
data = DFF_WP

timeset = Rk_TL; 




%Set parameters

window = 1:200; % Pick your window size, that wall move across your data. 

offset = 100; % Pick your overlap size for the moving window. 

overlap = length(window) - offset; % After picking window size and offset size, overlap will calculate how much the window will move across the data.

% This calculates what the endpoint of the for loop in each of the phases.

endpoint = length(data) ./ overlap; 
ep1 = (endpoint - 1);
ep2 = floor(ep1);

%Number of columns in your data
numcol = 1:8;

b = 3000; % b is the amplitude difference you are looking for, this is the value you will be changing to get the correct threshold.
a = 1e-4; %Used to divide floats to ints in phase 2 onset.
 

%Find peaks function

for k = 1;
  
    %Phase 1 Onset Time
    run('phase1onset');
   
    %Phase 2 Onset Time
    run('phase2onset');

    %Phase 3 Onset Time
    run('phase3onset');
end
        

run('invPhase3');


clearvars -except phase1 phase2 phase3 interphase


