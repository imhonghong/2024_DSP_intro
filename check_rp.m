function [max_Rp,passband_ripples] = check_rp(h,w, wp)
%CHECK_RP Summary of this function goes here
%   Detailed explanation goes here

wp_=[];
for ii=1:length(w)
    if w(ii)<wp*pi
        wp_=[wp_ ii];
    end
end
mag_dB = 20*log10(abs(h(wp_)));
passband_ripples = (mag_dB);
max_Rp = max(passband_ripples);
end

