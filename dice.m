 
function [win,aver]=dice(B) 
%Play the dice game B times 
gains=[-1,2,-3,4,-5,6]; 
plays=unidrnd(6,B,1); 
win=sum(gains(plays)); 
aver=win/B; 
