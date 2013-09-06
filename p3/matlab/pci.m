function angulos = pci(L1, L2, p, th1_positivo)
    x = p(1);
    y = p(2);
    
    th2 = acos((x^2 + y^2 - L1^2 - L2^2)/(2*L1*L2));
    th2 = [th2, -th2];
    
    th1 = atan2(y * (L1 + L2 * cos(th2)) - x * L2 * sin(th2),...
        x * (L1 + L2 * cos(th2)) + y * L2 * sin(th2));
    
    angulos =[th1; th2];
    if th1_positivo == true
        indice = find(th1 > 0, 1);
        if numel(indice) == 1
            angulos = [th1(indice); th2(indice)];
        else %no hay positivo, pues el primero mismamente
            angulos = [th1(1); th2(1)];
        end
    end
    