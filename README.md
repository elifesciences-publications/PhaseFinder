
### This code is associated with the paper from Diao et al., "Neuromodulatory connectivity defines the structure of a behavioral neural network". eLife, 2017. http://dx.doi.org/10.7554/eLife.29797



#Introduction:
The overall goal of these programs is to help you determine the phase onset times in the three behavioral sequences of pupal ecdysis: Pre-Ecdysis (Phase1), Ecdysis (Phase2), transitions phase, (interphase), and post-ecdysis (phase3). The Phase_PeakFinder program calls the phase1onset, phase2onset, and phase3onset after setting the parameters. InvPhase3TransitionOffset tells you the onset of the interphase, between phase 2 and phase 3. Using your calcium data time course, these programs will reliably be able to tell you the onset of phase 1, 2, 3, and the interphase. The input signal I am using is whole animal calcium data, not single cell. In my case I used Rickets/bursicon neurons. 

#Phase Onset/Offset Time

##Phase_PeakFinder:
This program will use a moving window across your input signal (calcium data time course), determining the three behavioral phases in pupal ecdysis: Phase1, Phase2, and Phase3.  Here you will set your moving window size, by changed the variables “window” and “offset”. You will also want to set the number of columns your data has by changing “numcol”. The “data” should be samples/preps in columns and calcium intensities in the rows. The “timeset “should be 1 column by however many time points you have corresponding with your data. “ampdiff” is the amplitude difference, used in phase2onset.  This value should be changed depending on the type of input signal and what threshold you want for the amplitude difference.  The preset parameters are specific to Rickets/Bursicon neurons, but can be changed for different types of neurons.  The window size I used was 1:200, with an offset of 100. Numcol was set to 8, because there are 8 preps/samples I used. 200 was the size of the window because this was the best signal to noise ratio when determining the frequencies/peaks of the window. 
##Phase1onset:
This program will find the onset of phase 1, by using the Matlab’s findpeaks function. This program creates a moving window across the data points and grabs the first peak that comes up; based on the parameters I set. The minpeakprominence of a peak determines how much the peak stands out due to its height and location relative to other peaks.  “mpp” is the variable set to minpeakprominence. The higher the “mpp” the less peaks will be detected. The lower the “mpp’ the more peaks will be detected. This is the same for minpeakdistance.  The higher the distance results in fewer peaks detected and vice versa. “mpd” is set to the minpeakdistance.  “mpd” was set  equal to  10 + log("add") where "add" is "add" + 10. This is so the program does not select every single peak in your input data. “mpd” by default is set to 25. Then once the program starts it starts incrementing by 10+log("add"). We used 25 and the 10+log("add") function after many trials of guessing and checking on what number would give us the best signal to noise ratio for the peaks. We didn’t want to capture every single peak, because some of it was just noise.  All the variable “add” does is increments the variable “mpd” by 10. These were used for the minpeakdistnace.  “mpp” was set to 0.25 by default. This was also found after many trials of guessing and checking. We found that 0.25 with an increment of 0.005 led to the best signal to noise ratio for the determination of peaks. This was used for the minpeakprominence.
##Phase2onset:
This program uses the difference in amplitude threshold, “ampdiff”, to determine where the onset of phase 2 starts. This uses the same moving window as Phase1onset. The amplitude threshold was set to 3000. I use the amplitudes of each peak and compare to the amplitude threshold. The peaks that are greater than the threshold are saved to a variable to be converted to get the correct time index. The amplitude is the total amplitude, from 0 to peak. 
##nterphaseonset:
Interphaseonset uses the difference in frequency across the moving window to determine the onset of interphase. The frequency is calculated by the number of peaks within the window divided by the interval of time in that window. This uses the same moving window as Phase1onset.  After finding the frequencies from each window I took the difference of each frequency.  Using the difference’s I found where the sign changes occur and created a new variable for that. I then looped through all the indices and checked if the time is greater than the index threshold, in mean(phase2). This value will change for different types of data sets, but we chose this value so the interphase onset time does not detect the changes in frequency in phase 1 or 2.

##Phase3onset:
Phase3onset determines the transition phase after interphase, phase 3. This program uses the same moving window and parameters as Phase1onset, Phase2onset, and interphase onset, however the moving window moves from the end of the data to the beginning. We want to do this so the program can detect the change in frequency from phase3onset to interphase onset. I looped through all the indices and checked if the time is greater than the index threshold, in our case mean (interphase). We do this so we make sure we don’t detect changes in frequencies where phase 1,  phase 2, or interphase should occur. 
#How to use:
Toolbox: Signals Processing Toolbox, Matlab
Input files:
Data- Calcium data should have samples as columns and calcium fluorescence intensities as rows. (Increasing with time)

Timeset- One column of all the times in increasing order. The rows should be the same size as the Data.

#Parameters:
•	Change the minpeakprominence and minpeakdistance to either increase or decrease the number of peaks the program is detecting.
•	Change the “ampdiff” variable to determine the amplitude threshold, in determining phase 2. 
•	Specify the number of columns you wish to iterate this program over, “numcol”.

#Output file:
•	Four separate variables displaying the Phase 1, Phase 2, interphase, and Phase 3 onset times. The variables are called “Phase 1”, “Phase 2”, “interphase” and “Phase 3”. Within each variable, there are x rows depending on how many samples your input data file contains.  There will be another variable called interphase, displaying the phase between 2 and 3.
##Turn peak intensities and times into two rows
#Cleanup Peaks:
This program is very simple. It will take in your peak intensities “Pn” and times “Tn” created from Phase_peakfinder and will return a two column variable “Finaln”. The first colum will be your peak times and the second column will be the peak intensity values.
#How to use:
Input files:
Data- Peaks intensities and times for peaks from the Phase_peakfinder  program. The variables should be “P1”, “P2”…. “Pn”, “T1”, “T2”… “Tn”.
#Paramters:
•	The only parameter in this program you need to change is the number of columns you want the program to iterate through. The variable “i” determines how many columns you want to iterate through.
#Output file:
•	 The output variable from this program is called “Final1”, “Final2” …”Finaln”. This variable will contain both the columns of peak intensities and peak times
