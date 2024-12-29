clear
clc

% Specifications
wp = 0.45 * pi;                % Passband edge (rad/sample)
ws = 0.5 * pi;                 % Stopband edge (rad/sample)
rp = 0.5;                      % Passband ripple (dB)
rs = 60;                       % Stopband attenuation (dB)

% Convert to normalized frequency (digital)
wp_norm = wp / pi;             % Normalized passband edge
ws_norm = ws / pi;             % Normalized stopband edge

% Butterworth Filter
[n_b, wn_b] = buttord(wp_norm, ws_norm, rp, rs);
[b_b, a_b] = butter(n_b, wn_b);
[h_b, w_b] = freqz(b_b, a_b, 1024);
stopband_att_b = -20*log10(abs(h_b(w_b > ws_norm)));

% Chebyshev Type-1 Filter
[n_c1, wn_c1] = cheb1ord(wp_norm, ws_norm, rp, rs);
[b_c1, a_c1] = cheby1(n_c1, rp, wn_c1);
[h_c1, w_c1] = freqz(b_c1, a_c1, 1024);
stopband_att_c1 = -20*log10(abs(h_c1(w_c1 > ws_norm)));

% Chebyshev Type-2 Filter
[n_c2, wn_c2] = cheb2ord(wp_norm, ws_norm, rp, rs);
[b_c2, a_c2] = cheby2(n_c2, rs, wn_c2);
[h_c2, w_c2] = freqz(b_c2, a_c2, 1024);
stopband_att_c2 = -20*log10(abs(h_c2(w_c2 > ws_norm)));

% Elliptic Filter
[n_e, wn_e] = ellipord(wp_norm, ws_norm, rp, rs);
[b_e, a_e] = ellip(n_e, rp, rs, wn_e);
[h_e, w_e] = freqz(b_e, a_e, 1024);
stopband_att_e = -20*log10(abs(h_e(w_e > ws_norm)));
%%
figure(1);
hold on
plot(w_b/pi, 20*log10(abs(h_b)));
plot(w_c1/pi, 20*log10(abs(h_c1)));
plot(w_c2/pi, 20*log10(abs(h_c2)));
plot(w_e/pi, 20*log10(abs(h_e)));
title('Different Filter Magnitude Response');
legend('Butterworth', 'Chebychev 1', 'Chebychev 2', 'Elliptic');
xlabel('Normalized Frequency (\times\pi rad/sample)');
ylabel('Magnitude (dB)');
ylim([-120 1]);
hold off
%%
% Plot Frequency Responses
figure(2);
subplot(2, 2, 1);
plot(w_b/pi, 20*log10(abs(h_b)));
title('Butterworth Filter');
xlabel('Normalized Frequency (\times\pi rad/sample)');
ylabel('Magnitude (dB)');
grid on;

subplot(2, 2, 2);
plot(w_c1/pi, 20*log10(abs(h_c1)));
title('Chebyshev Type-1 Filter');
xlabel('Normalized Frequency (\times\pi rad/sample)');
ylabel('Magnitude (dB)');
grid on;

subplot(2, 2, 3);
plot(w_c2/pi, 20*log10(abs(h_c2)));
title('Chebyshev Type-2 Filter');
xlabel('Normalized Frequency (\times\pi rad/sample)');
ylabel('Magnitude (dB)');
grid on;

subplot(2, 2, 4);
plot(w_e/pi, 20*log10(abs(h_e)));
title('Elliptic Filter');
xlabel('Normalized Frequency (\times\pi rad/sample)');
ylabel('Magnitude (dB)');
grid on;

% Group Delay
figure(3);
hold on
grpdelay(b_b, a_b,128);
grpdelay(b_c1, a_c1,128);
grpdelay(b_c2, a_c2,128);
grpdelay(b_e, a_e,128);
legend('Butterworth', 'Chebychev 1', 'Chebychev 2', 'Elliptic');
xlabel('Normalized Frequency (\times\pi rad/sample)');
ylabel('Delay');
hold off

min_stop_att_b = max(stopband_att_b(~isinf(stopband_att_b)));
min_stop_att_c1 = max(stopband_att_c1(~isinf(stopband_att_c1)));
min_stop_att_c2 = max(stopband_att_c2);
min_stop_att_e = max(stopband_att_e);

%% Group delay
[zb, pb, kb] = butter(n_b, wn_b);
[zc1, pc1, kc1] = cheby1(n_c1, rp, wn_c1);
[zc2, pc2, kc2] = cheby2(n_c2, rs, wn_c2);
[ze, pe, ke] = ellip(n_e, rp, rs, wn_e);
sos_b = zp2sos(zb, pb, kb);
sos_c1 = zp2sos(zc1, pc1, kc1);
sos_c2 = zp2sos(zc2, pc2, kc2);
sos_e = zp2sos(ze, pe, ke);
[gd_b, wgd_b] = grpdelay(sos_b,1024);
[gd_c1, wgd_c1] = grpdelay(sos_c1,1024);
[gd_c2, wgd_c2] = grpdelay(sos_c2,1024);
[gd_e, wgd_e] = grpdelay(sos_e,1024);
max_gd_b = max(gd_b);
max_gd_c1 = max(gd_c1);
max_gd_c2 = max(gd_c2);
max_gd_e = max(gd_e);
figure(3);
hold on
grid on

grpdelay(sos_b,1024);
grpdelay(sos_c1,1024);
grpdelay(sos_c2,1024);
grpdelay(sos_e,1024);
title('Group delay of Different Filters');
legend('Butterworth', 'Chebychev 1', 'Chebychev 2', 'Elliptic');
xlabel('Normalized Frequency (\times\pi rad/sample)');
ylabel('Samples');
hold off