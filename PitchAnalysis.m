clc;
clear all;
close all;
[y, fs] = audioread('a17.wav');  %read in the wav file 
[t, f0, avgF0] = pitch(y,fs);    %call the pitch.m routine
plot(t,f0)  ;                    %plot pitch contour versus time frame 
title('Pitch Contour Plot');
avgF0 ;                          %display the average pitch 
sound(y)                         %play back the sound file  

