function angulos = pci(L1, L2, p)
    x = p(1);
    y = p(2);
    th2 = acos((x^2 + y^2 - L1^2 - L2^2)/(2*L1*L2));
    th2 = [th2, -th2];
    th1 = atan2(y * (L1 + L2 * cos(th2)) - x * L2 * sin(th2),...
        x * (L1 + L2 * cos(th2)) + y * L2 * sin(th2));
    angulos =[th1; th2];
    
    
    