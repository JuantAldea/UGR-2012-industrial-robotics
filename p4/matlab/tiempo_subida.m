function t = tiempo_subida(y, delta_t, consigna)
    [~, indices] = findpeaks(-abs((y) - consigna));
    if numel(indices) > 0
        t = indices(1) * delta_t;
    else
        t = [];
    end
end