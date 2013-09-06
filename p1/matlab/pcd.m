function p = pcd(L1, L2, th1, th2)
    px = L1 .* cos(th1) + L2 .* cos(th1 + th2);
    py = L1 .* sin(th1) + L2 .* sin(th1 + th2);
    p = [px; py];