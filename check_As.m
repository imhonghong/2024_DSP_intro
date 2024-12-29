function [att, valid] = check_As(h,w,ws, As)
%CHECK_AS Summary of this function goes here
%   Detailed explanation goes here
[val, idx] = min(abs(w/pi-ws));
ws_over = val/pi;
if ws_over>ws
    idx=idx-1;
end

wcc = abs(h(idx));
wcc_dB = 20*log10(wcc);
valid = abs(wcc_dB)>As;
att = abs(wcc_dB);

end
