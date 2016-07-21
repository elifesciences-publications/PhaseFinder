%This program will find the onset of Phase 1, by using the findpeaks
%function. This program creates a moving window across the time data points
%and grabs the first peak that comes up. 



%This for loop moves across the data window by window, grabbing the indices
%and peaks for each peak, then converting each index to a time point and
%concatenating them into a variable matrix. The Minpeakprominence is set at
%.25 and should be changed accordingly, to what distance between peaks you
%want. We are adding .005 each loop to the minpeakprominence. The
%meanpeakdistance is set at p = 10+log(z) and z = z+10, this is so we don't
%grab every single peak through the data. The variable q is the minpeak prominence. 
%You may have to change the q value if you want more or less peaks. 

a = 1e-4; %Just a divisor
 

for k = numcol
%Reset key parameters for each iteration in your data columns.
    window = 1:200;
    p = 25;
    q = .10;
    z = 10;

    for i = 1:ep2 ;
        %Find peaks methods, will find all the peaks in your data satisfying your criteria ie. minpeakprominence and minpeakdistance
        [pks,inds] = findpeaks(data(window,k),  'MinPeakProminence', q, 'minpeakdistance', p);  
		%Saves all of the peaks and indices of the peaks to a file called dR_inds and dR_pks.
        dR_inds(i,1:numel(inds)) = inds;
        dR_pks(i, 1:numel(pks)) = pks;
  
		%Saves all the time points corresponding to the indices in a file called total_time
        time = timeset(dR_inds(i,1:sum(~isnan(dR_inds(i,:)))) + (window(1)-1));
        total_time(i, 1:numel(time)) = time;

        window = window + offset; %creates moving window
        p = 10 + log(z);
        z = z + 10; 
        q = q + .005;
        
        eval(sprintf ('T%d = [total_time]', k)); %adding the Times to a variable T1
        
        eval(sprintf ('P%d = [dR_pks]',k));  %adding the peaks to a variable A1. To check if peaks are working, plot over the actaual data set
        var = eval(sprintf( 'T%d', k));
        %var = var';load RkSingles_729_4.mat
		
		%Turning all zeros to NaN
        var(var == 0) = NaN; 
		%Nanmean takes the mean ignoring NaN values
        M = nanmean(var);
        dR_M(k, 1:numel(M)) = M;
        
        if time > 0 %when time variable gets the first peak, quit the for loop
            break
        end
       
        
    end
     clear dR_pks;
     clear dR_inds;
     clear time;
     clear total_time;
    
 

end
[lB,rB] = size(dR_M);
dR_M(:,2:rB)=[];

%Final file to look at load RkSingles_729_4.mat
%is the dR_M. This output file contains each onset
%time for each column of the data set. It should be x rows by 1 column.
%Each row is  the onset time for the correspond column. 

[phase1] = dR_M;

P1(P1 == 0) = NaN;