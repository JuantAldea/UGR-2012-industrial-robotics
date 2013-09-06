function angulo = calcular_angulo(posiciones, tiempos, t)
    v0 = 0;
    a0 = 0;
    vf = 0;
    af = 0;
    
    t1 = tiempos(1);
    t2 = tiempos(2);
    tn = tiempos(end);
    
    thini = posiciones(1);
    thdes = posiciones(2);
    thase = posiciones(3);
    thfin = posiciones(4);
    
    theta0 = thini;
    theta1 = thdes;
    theta2 = thase;
    thetaf = thfin;

    delta1 = theta1 - theta0;
    delta2 = theta2 - theta1;
    deltan = thetaf - theta2;

    Y = [delta1 - (a0*t1^2)/2 - v0*t1;
        -a0*t1 - v0;
        -a0;
        delta2;
        -af*tn + vf;
        af;
        deltan + (af*tn^2)/2 - vf*tn];

    C = [1 1 0 0 0 0 0;
        3/t1 4/t1 -1/t2 0 0 0 0;
        6/t1^2 12/t1^2 0 -2/t2^2 0 0 0;
        0 0 1 1 1 0 0;
        0 0 1/t2 2/t2 3/t2 -3/tn 4/tn;
        0 0 0 2/t2^2 6/t2^2 6/tn^2 -12/tn^2;
        0 0 0 0 0 1 -1;];
    
    X = C\Y;
    
    h1 = [X(2), X(1), (a0*t1^2)/2, v0*t1, theta0];
    h2 = [X(5), X(4), X(3), theta1];
    hn = [X(7), 
        -4*X(7) + X(6),
        6*X(7) - 3*X(6) + af*tn^2,
        -4*X(7) + 3*X(6) - 2*(af*tn^2)/2 + vf*tn,
        X(7) - X(6) + (af*tn^2)/2 - vf*tn + thetaf
        ];
    
    limites_temporales_acumulados = cumsum([0 t1, t2, tn]);
        
    tramo = find(limites_temporales_acumulados < t, 1, 'last');

    if t >= limites_temporales_acumulados(end)
        tramo = 3;
        t_normalizado = 1;
    elseif t <= 0
        t_normalizado = 0;
        tramo = 1;
    else
        t_normalizado = (t - limites_temporales_acumulados(tramo))/...
            (limites_temporales_acumulados(tramo + 1) -...
            limites_temporales_acumulados(tramo));
    end
    
    if tramo == 1
        angulo = polyval(h1, t_normalizado);
    elseif tramo == 2
        angulo = polyval(h2, t_normalizado);
    elseif tramo == 3
        angulo = polyval(hn, t_normalizado);
    else
        angulo =  -1;
    end
end