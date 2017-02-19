% Function: 
% Return the first five formants of a speech file
% Input: 
% The speech file "y" 
% Output: 
% The PSD (P), the normalized frequency axis (F), the position of the peak (I) 
function [P, F, I] = formant(y)  
% calculate the PSD using Yule-Walker's method 
order = 12; 

P = pyulear(y,order,[]);      % power spectral denstity, returns the PSD
P = 10*log10(P);           % convert to DB 
F = 0:1/128:1;             % normalized frequency axis  
[Pm,I] = pickmax(P);       % call pickmax pm is the value of peak and I is the index
I = I/128;     
% you should use plot(F, P) to plot the PSD % and I tells you the location of those formant lines.
plot(F,P);