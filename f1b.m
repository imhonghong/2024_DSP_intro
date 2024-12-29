clear
clc


As = 50; %stopband attenuation = 50dB
Ap = 1; % passband ripple = 1dB;
ws = 15; % stopband = 15rad/s
wp = 10; %passband = 10 rad/s

% calculate minimum order:
temp_a = (10^(0.1*As)-1)^0.5;
temp_b = (10^(0.1*Ap)-1)^0.5;
N = (acosh(temp_a/temp_b))/(acosh(ws/wp));
min_int_order = ceil(N);
