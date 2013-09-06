animar = true;
duracion = 5;
T = 0.01;

angulos1 = trayectoria_pci(1, 1, [2; 0], [ 0; 2], duracion, T, animar);
angulos2 = trayectoria_pci(1, 1, [1; 1], [-1; 0], duracion, T, animar);
angulos3 = trayectoria_pci(1, 1, [1; 0], [-1; 0], duracion, T, animar);

angulos = angulos3;
tiempo = 0:T:duracion;
variable = 2;

subplot(2, 2, 1),
    plot(tiempo, angulos(variable, :));
    title('Posicion')

subplot(2, 2, 2),
    plot(tiempo(2:end), diff(angulos(variable, :), 1)./T);
    title('Velocidad')

subplot(2, 2, 3),
    plot(tiempo(3:end), diff(angulos(variable, :), 2)./T);
    title('Aceleracion');
    
subplot(2, 2, 4),
    plot(tiempo(4:end), diff(angulos(variable, :), 3)./T);
    title('Jerk');