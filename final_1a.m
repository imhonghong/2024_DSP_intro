clear
clc

% Butterworth filter design
rp = 0.25;                  % Passband ripple in dB
rs = 50;                    % Stopband attenuation in dB
wp = 500;                   % Passband edge (rad/s)
ws = 2000;                  % Stopband edge (rad/s)

% Calculate filter order and cutoff frequency
[n, wc] = buttord(wp, ws, rp, rs, 's'); % Analog filter
[b, a] = butter(n, wc, 's');            % Filter coefficients

% Frequency response
w = 0:3000;                % Log-spaced frequencies
h = freqs(b, a, w);

% Magnitude Response
figure(1);
subplot(3, 1, 1);
plot(abs(h));
title('Magnitude Response');
xlabel('Frequency (rad/s)');
ylabel('Magnitude');
grid on;

% Log-magnitude response (dB)
subplot(3, 1, 2);
plot(w, 20*log10(abs(h)));
title('Butterworth Filter: Log-Magnitude Response');
xlabel('Frequency (rad/s)');
ylabel('Magnitude (dB)');
grid on;

% Phase response
subplot(3, 1, 3);
plot(w, angle(h));
title('Butterworth Filter: Phase Response');
xlabel('Frequency (rad/s)');
ylabel('Phase (radians)');
grid on;

% Impulse response
figure;
impulse(tf(b, a));
title('Butterworth Filter: Impulse Response');

sys = tf(b,a)