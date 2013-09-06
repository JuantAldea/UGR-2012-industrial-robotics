function t = tiempo_pico(y, delta_t)
    [~, indices] = findpeaks(y);
    if numel(indices) > 0
        t = indices(1) * delta_t;
    else
        t = [];
    end
end