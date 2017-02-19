%Code to calculate and plot the first three formants present in a 
%speech file and 
%calculate the vector differences between peak positions of the first 
%five formants. 
%This code requires formant.m and pickmax.m to be in the same directory  
clc;close all; clear all;
[y, fs] = audioread('a17.wav');  %read in my speech file. 
%[P,F,I] = formant(y);          %apply formant routine and %return P, F, and I. 
sound(y);         %play the speech file.
N = length(y);
ydft = fft(y);
ydft = ydft(1:N/2+1);
psdy = (1/(fs*N)) * abs(ydft).^2;
psdy(2:end-1) = 2*psdy(2:end-1);
freq = 0:fs/length(y):fs/2;
p=10*log10(psdy);
plot(freq,p) ;                     %plot formants.   

