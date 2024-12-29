clear
clc

% Chebyshev-I filter design
rp = 1;                     % Passband ripple in dB
rs = 50;                    % Stopband attenuation in dB
wp = 10;                    % Passband edge (rad/s)
ws = 15;                    % Stopband edge (rad/s)

% Calculate filter order and cutoff frequency
[n, wc] = cheb1ord(wp, ws, rp, rs, 's'); % Analog filter
[b, a] = cheby1(n, rp, wc, 's');         % Filter coefficients
[p, z, k] = cheby1(n, rp, wc, 's');

% Frequency response
w = 0:50;
h = freqs(b, a, w);


% Log-magnitude response (dB)
figure(2);
subplot(3, 1, 1);
plot(w, 20*log10(abs(h)));
title('Chebyshev-I Filter: Log-Magnitude Response');
xlabel('Frequency (rad/s)');
ylabel('Magnitude (dB)');
grid on;

% Group delay
%[gd, freq] = grpdelay(b, a, w);
gd = -diff(unwrap(angle(h))) ./ diff(w); 
w_gd = w(1:end-1); 
subplot(3, 1, 2);
plot(w_gd, gd);
title('Chebyshev-I Filter: Group Delay');
xlabel('Frequency (rad/s)');
ylabel('Group Delay (s)');
grid on;

% Impulse response
subplot(3, 1, 3);
impulse(tf(b, a));
title('Chebyshev-I Filter: Impulse Response');

disp(tf(b,a));
sys = tf(b,a)