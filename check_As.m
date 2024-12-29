function [att, valid] = check_As(h,w,ws, As)
%CHECK_AS Summary of this function goes here
%   Detailed explanation goes here
[val, idx] = min(abs(w/pi-ws));
ws_over = val/pi;
if ws_over>ws
    idx=idx-1;
end

wcc = 20*log10(abs(h(idx)));
valid = wcc>As;
att = abs(wcc);

end

