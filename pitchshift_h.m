%Code of High Pitch Function
function [y]=pitchshift_h();
[x,fs,n]=wavread('rec1.wav');
N=length(x);
M1=2;
x_deci=x(1:M1:N);
y=x_deci;