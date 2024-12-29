clear
clc

% Filter specifications
N = 50;                    % Filter order
center = 0.5;
pe = 0.01;
se = 0.06;

band = [0 center-se center-pe center+pe center+se 1];
amplitude = [0 0 1 1 0 0];
b=firpm(N, band, amplitude);

% Plot magnitude response
figure(1);
hold on
grid on
[h, w] = freqz(b, 1, 1024);
mag_dB = 20*log10(abs(h));
plot(w/pi, mag_dB, LineWidth=1);
title('Magnitude Response of the FIR Bandpass Filter');
xlabel('Normalized Frequency (\times\pi rad/sample)');
ylabel('Magnitude (dB)');
xline(center-pe,'-r');
xline(center+pe,'-r');
xline(center-se,'-g');
xline(center+se,'-g');
yline(-30, '-k');
legend('magnitude response','passband1=0.49', 'passband2=0.51', 'stopband1=0.44', 'stopband2=0.56');
hold off

%%
n = 0:199;
w_n = randn(size(n));
x_n = 2*cos(0.5*pi.*n)+w_n;
y_n = filter(b, 1, x_n);

figure(2);
subplot(3, 1, 1);
plot(x_n);
title('input x[n]');
xlabel('sample');
ylabel('value');
xlim([100 199]);
subplot(3, 1, 2);
plot(y_n);
title('output y[n]');
xlabel('sample');
ylabel('value');
xlim([100 199]);
subplot(3,1,3);
plot(2*cos(0.5*pi.*n));
title('input without noise')
xlabel('sample');
ylabel('value');
xlim([100 199]);