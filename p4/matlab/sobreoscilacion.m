function mp = sobreoscilacion(y, consigna)
    [picos, ~] = findpeaks(y);
    if numel(picos) > 0
        mp = picos(1) - consigna;
    else
        mp = [];
    end
end