clear
clc

% Specifications
wp = 0.2;       % Passband edge (normalized)
ws = 0.3;       % Stopband edge (normalized)
wc = mean([wp,ws]);
rp = 0.25;      % Passband ripple in dB
as = 50;        % Stopband attenuation in dB
delta_p = 10^(-0.25/20);
delta_s = 10^(-50/20);

%% cal beta
band_edge = [wp, ws];
%[n ,wn, beta, ftype] = kaiserord(band_edge, [1,0], [delta_p, delta_s]);
beta=0.5842*(as-21)^0.4+0.07886*(as-21);
n=ceil((as-8)/2.285/(ws-wp)/pi);
hh = fir1(n, wc, 'low', kaiser((n+1), beta));
[h,w] = freqz(hh,1,1024);
[max_Rp,passband_ripples] = check_rp(h,w, wp);
[att, valid] = check_As(h, w, ws, as);

mag_dB = 20*log10((abs(h)));
% Magnitude response
figure(1);
plot(w/pi,mag_dB);
title(['Magnitude Response at Order=', num2str(n), '(Kaiser window)']);
xlabel('Normalized Frequency (\times\pi rad/sample)');
ylabel('Magnitude (dB)');

% Impulse response
figure(2);
stem(0:n, hh);
title('Impulse Response (Kaiser Window)');
xlabel('n');
ylabel('h[n]');
grid on;
