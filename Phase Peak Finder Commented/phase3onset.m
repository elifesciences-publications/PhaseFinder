%This program will tell you the onset of phase 3 by using the frequency,
%number of peaks divided by the interval of time. 


%Reset Parameters
    window = 1:200;
    p = 25;
    q = .10;
    z = 10;



for k = numcol;
    window = 1:200;
    p = 25;
    q = .10;
    z = 10;
    for i = 1:ep2
        
        [pks,inds] = findpeaks(data(window,k),  'MinPeakProminence', q, 'minpeakdistance', p);  
        dR_inds(i,1:numel(inds)) = inds;
        dR_pks(i, 1:numel(pks)) = pks;
  

        time = timeset(dR_inds(i,1:sum(~isnan(dR_inds(i,:)))) + (window(1) - 1 ) );
        total_time(i, 1:numel(time)) = time;

        window = window + offset;
        p = 10 + log(z);
        z = z + 10; 
        q = q + .005;
        
        eval(sprintf ('T%d = [total_time]', k));
        eval(sprintf ('P%d = [dR_pks]',k));
        var = eval(sprintf( 'P%d', k));
        
        
        
       
        
    end;
    clear dR_pks;
    clear dR_inds;
    clear time;
    clear total_time;
    
 

end

%Changes all the zeros to NaN, so the zeros do not skew the calculations.
for k = numcol;
    var = eval(sprintf('P%d' ,k));
    var(var == 0) = NaN;
    eval(sprintf('P%d = [var]', k));
end
%The window is from 1-200 so 199 length. 
inttime = 199;

%For the number of frames, take the number of peaks and divide it by the
%window length, 199 times the amount of time between each point, which is
%1.067 seconds. Input those values into a variable called dR_freq2.
for k = numcol
    for i = 1:ep2;
        var = (eval(sprintf('P%d',k)));
        freq = sum(~isnan(var(i,:)))./ (inttime .* 1.067);
        dR_freq2 (1:numel(freq),i) = freq; 
        %dR_freq2(dR_freq2 == 0) = NaN;
    end
    eval(sprintf('freq%d = [dR_freq2]',k));
    clear dR_freq2;
end

%take the difference of each frequency

for k = numcol
    var = eval(sprintf('freq%d',k));
    timefreqdiff = diff(var);
    eval(sprintf('deltnew%d = [timefreqdiff]',k));
    
end

% Find indices where sign change occurs


for k = numcol
    var = eval(sprintf('deltnew%d', k));
    indices = find([0 diff(sign(var))]~=0);
    dR_indices(k,1:numel(indices)) = indices;
end



%Loop through all the indices and check if the time is greater than the
%threshold, in our case 41, and make sure the value is going from positive
%to negative in the time4freqdiff variable. 

for k = numcol
    for i = 1: length(dR_indices(k,:));


        var = eval(sprintf('deltnew%d', k));
        if dR_indices(k,i) == 0;
            frequency = NaN;
            phase3(k, 1:numel(frequency)) = frequency;
        else
            if T1(dR_indices(k,i),1) > 41 && var(1,i) < var(1,i-1);

                break
            end
            time_var = eval(sprintf('T%d', k));
            frequency = time_var(dR_indices(k,i),1);
            phase3(k, 1:numel(frequency)) = frequency;
        end

    end
     
end    




