function pxy = robot(L1, th1, p)
    x=[0 L1 * cos(th1) p(1)];
    y=[0 L1 * sin(th1) p(2)];
    pxy = [x; y];
    plot(x, y)
    axis([-2 2 -2 2]);