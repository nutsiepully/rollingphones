function [ f_vec ] = mah_fuhrer( vec, smooth_window )
    f_vec = abs(real(fft(vec)));
    
%     gaussFilter = gausswin(smooth_window);
%     gaussFilter = gaussFilter / sum(gaussFilter); % Normalize.
%     % Do the blur.
%     f_vec = conv(f_vec, gaussFilter);
end
