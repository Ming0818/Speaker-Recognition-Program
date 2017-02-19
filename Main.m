clc;
close all;
clear all;

[y, fs] = audioread('a17.wav');                                             %read the .wav file 
sound(y,fs)                                                                 %play back the .wav file
t = 0:1/fs:length(y)/fs-1/fs;                                               %create a time vector 

figure (1);
subplot(211);                         
plot(t,y);                                                                  %plot the original waveform   

rev_b = flipud(y);                                                          %reverse the audio                 
pause(12);                                                                  %creating a pause for 12 seconds
sound(rev_b, fs);                                                           %playing the audio in reverse

subplot(212);                      
plot(t,rev_b);                                                              %plot the reverse waveform

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[y, fs] = audioread('a18.wav');                                             %read the .wav file 
 t = 0:1/fs:length(y)/fs-1/fs;                                              %generate a time vector
 pause (12);                                                                %pause of 12 seconds
 
 figure (2);
 subplot(311)        
 
plot(t,y)                                                                   %plot the signal in time domain  

sigma = 0.02;
mu = 0;
n = randn(size(y))*sigma + mu*ones(size(y)); 
  
signal=n+y;                                                                 %add a gaussian noise to the original signal 
yfft=fft(y);                                                                %take the FFT of the original signal 
xfft=fft(signal);                                                           %take the FFT of the signal with noise added 

f = -length(y)/2:length(y)/2-1;                                             %generate a frequency scale. 

ysfft=fftshift(yfft);                                                       %calculate the shifted FFT of the original signal
xsfft=fftshift(xfft);                                                       %Shifted FFT for the signal with noise added  

subplot(312)  
plot(f,abs(ysfft));                                                         %plot the shifted FFT of the original signal in the frequency domain      

subplot(313)  
plot(f,abs(xsfft));                                                         %plot the shifted FFT of the original signal with noise added in the frequency domain

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[y, fs] = audioread('a27.wav');                                             %read the .wav file again

t = 0:1/fs:length(y)/fs-1/fs;                                               %generate a time vector  
pause(12);

figure (3);
subplot(311)       
plot(t,y)                                                                   %plot the signal in time domain  

sound(y,fs)                                                                 %play back the .wav file  

yfft=fft(y);                                                                %take the FFT of the original signal 
f = -length(y)/2:length(y)/2-1;                                             %create a frequency vector
ysfft=fftshift(yfft);                                                       %Shift the FFT of the original signal  

subplot(312) 
plot(f,abs(ysfft));                                                         %plot the shifted FFT of the orginal signal   

order = 3; 
cut = 0.05; 
[B, A] = butter(order, cut); 
filtersignal = filter(B, A, ysfft); 
   
subplot(313) 
plot(f,21*abs(filtersignal));                                               %plot the scaled and filtered signal to compare 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[y, fs] = audioread('a17.wav');                                             %read the .wav file 

[t, f0, avgF0] = pitch(y,fs);                                               %call the pitch.m function
pause(12);

figure (4);
plot(t,f0)  ;                                                               %plot of the pitch contour versus time
title('Pitch Contour Plot');

avgF0 ;                                                                     %display the average pitch 
sound(y)                                                                    %Play the sound file

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Code to calculate and plot the first three formants present in a speech 
%file and calculate the vector differences between peak positions of the first five formants. 
  
[y, fs] = audioread('a17.wav');                                             %read the speech file. 
 
pause (12);
sound(y)                                                                    %Play the sound file

N = length(y);
ydft = fft(y);
ydft = ydft(1:N/2+1);
psdy = (1/(fs*N)) * abs(ydft).^2;
psdy(2:end-1) = 2*psdy(2:end-1);
freq = 0:fs/length(y):fs/2;
p=10*log10(psdy);                                                           %To find the Power Spectral Density,
                                                                            %normalised frequency axis and position 
                                                                            %of the peak of the signal.

figure(5);
plot(freq,p) ;                     %plot formants.   

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Code to sort and compare voice files. This code first compares the reference
%.wav file to all others based on average pitch. The top 3 most likely matches 
%are then compared by the differences in their formant peak vectors. 
%The resulting closest matches are then displayed. 

results=zeros(3,1);                                                         %create a vector for results. 
diff=zeros(16,1);                                                           %create a vector for differences in pitch. 
formantdiff=zeros(3,1);                                                     %create a vector for diff in formant vector  

[y17, fs17] = audioread('a17.wav');                                         %read the .wav file to compare all others to.  
[t17, f017, avgF017] = pitch(y17,fs17);                                     %call the pitch function for ref .wav file. 

pause(12);
figure(6);
subplot(311);
plot(t17,f017)                                                              %plot the pitch contour of the ref. 

N = length(y17);
y17dft = fft(y17);
y17dft = y17dft(1:N/2+1);
psdy = (1/(fs17*N)) * abs(y17dft).^2;
psdy(2:end-1) = 2*psdy(2:end-1);
freq = 0:fs17/length(y17):fs17/2;
p=10*log10(psdy);                                                           %To find the Power Spectral Density,
                                                                            %normalised frequency axis and position 
                                                                            %of the peak of the signal.


avgF17 = avgF017 ;                                                          %set the average pitch equal to avg17 
sound(y17)  

pause(3)                                                                    %pause for 3 seconds      

[b,I17]=pickmax(y17);
 
for i=11:26     
     if i<10  
         filename = sprintf('a0%i.wav', i);     
     else
         filename = sprintf('a%i.wav', i);   
     end

     [y, fs] = audioread(filename);
  
[t, f0, avgF0] = pitch(y,fs);                                               %call the pitch.m function for the current .wav file.  

subplot(312);
 plot(t,f0)                                                                 %plot the current .wav file contour plot.  
 
 avgF0(i) = avgF0;                                                          %find the average pitch for the current wav file.  
 
 diff(i,1)=norm(avgF0(i)-avgF17);                                           %create a vector of avg. pitch diff between current 
                                                                            %.wav file and reference wav file.  
                                   
i                                                                           %display the index to see where the comparison is.  
end

[Y,H]=sort(diff) ;                                                          %sort the pitch correlations in ascending order.

for j=11:13                                                                 %pick the lowest 3 pitch correlations to compare formants .  
   p=H(j);                                                                  %set p equal to jth position of vector H .     
  
   if p<10        
       filename = sprintf('a0%i.wav', p);     
   
   else
       filename = sprintf('a%i.wav', p);
   end
   
   filename                                                                 %display the filename of the .wav file being compared.
   
   [y2, fs] = audioread(filename);  
  
  N = length(y2);
ydft = fft(y2);
ydft = ydft(1:N/2+1);
psdy = (1/(fs*N)) * abs(ydft).^2;
psdy(2:end-1) = 2*psdy(2:end-1);
F = 0:fs/length(y2):fs/2;
p=10*log10(psdy);                                                           %To find the Power Spectral Density,
                                                                            %normalised frequency axis and position 
                                                                            %of the peak of the signal.


[c, I]=pickmax(y2);
   
sound(y2)                                                                   %play back the wav file being compared. 
   
subplot(313);
   plot(F,p)                                                                %plot the formants for the comparison wav file. 
   
   pause(5)                                                                 %pause for 5 seconds so sound will finish playing back. 
   
   formantdiff(j,1)=norm(I17-I);                                            %create a vector of formant peak differences. 
end

[Y1,H1]=sort(formantdiff);                                                  %sort the vector in ascending order

for k=11:13
    results(k,1)=H(H1(k));                                                  %calculate the numerical numbers of the closest wav matches.     
end

H;                                                                          %display the vector H.

H1;                                                                         %display the vector H1. 

results                                                                     %display the numerical numbers of the closest wav file matches. 
