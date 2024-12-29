clear
clc

% Specifications
wp = 0.2;       % Passband edge (normalized)
ws = 0.3;       % Stopband edge (normalized)
wc = mean([wp,ws]);
rp = 0.25;      % Passband ripple in dB
as = 50;        % Stopband attenuation in dB

N = 2;
while 1
    % Design filter using fir1 and Hamming window
    h_n = fir1(N-1, wc, 'low', hamming(N));
    [h, w] = freqz(h_n, 1, 1024);
    [max_Rp,passband_ripples] = check_rp(h,w, wp);
    [att, valid] = check_As(h, w, ws, as);
    fprintf('N=%d  max_ripple=%f  att=%d \n', N, max_Rp, att);
    if valid && max_Rp<rp
        break
    else
        N = N+1;
    end
end

%%
mag_dB = 20*log10((abs(h)));
% Magnitude response
figure(1);
plot(w/pi,mag_dB);
title(['Magnitude Response at N=', num2str(N), '(fixed window)']);
xlabel('Normalized Frequency (\times\pi rad/sample)');
ylabel('Magnitude (dB)');

% Impulse response
figure(2);
stem(0:N-1, h_n, 'filled');
title('Impulse Response (Fixed Window)');
xlabel('n');
ylabel('h[n]');
grid on;

% Plot window
w_n = hamming(N);
figure(3);
stem(0:length(w_n)-1, w_n);
xlabel('n');
ylabel('w[n]');
title(['Hamming Window at N=', num2str(N)]);

