clear
clc

% design method:
% https://www.12000.org/my_notes/butterworth_analog_filter_design/index.htm

% ############# butterord implementation #############
wp = 500; % passband = 500 rad/s
ws = 2000;% stopband = 2000 rad/s
Ap = 0.25; % pass band ripple (dB)
As = 50; % stopband attenuation (dB)

norm_wp = 1;
norm_ws = ws/wp;
order = log10((10^(0.1*As)-1)/(10^(0.1*Ap)-1) / 2*log10(norm_ws));
min_int_order = ceil(order);
disp(min_int_order);

% find new wc
temp_a = norm_ws^(2*min_int_order);
temp_b = 10^(0.1*Ap)-1;
new_As = 10*log10(temp_a*temp_b+1);

temp_c = 10^(0.1*new_As)-1;
temp_d = temp_c^(1/(2*min_int_order));
new_wc = norm_ws / temp_d;

temp_e = 10^(0.1*As)-1;
new_Ap = 10*log10(temp_e/temp_a+1);
real_wc = new_wc*wp;
disp(real_wc);