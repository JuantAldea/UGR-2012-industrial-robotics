function angulos = calcular_angulos(posiciones, tiempos, t)
    th1 = calcular_angulo(posiciones(1, :), tiempos, t);
    th2 = calcular_angulo(posiciones(2, :), tiempos, t);
    angulos = [th1; th2];
end