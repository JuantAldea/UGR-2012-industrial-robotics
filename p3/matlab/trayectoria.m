periodo = 0.01;
ini = [1; 0];
des = [1; 0.1];
ase = [1.5; 0.1];
ate = [1.5; 0];
duraciones = [2; 4; 2;];

angulos_ini = pci(1, 1, ini, true);
angulos_des = pci(1, 1, des, true);
angulos_ase = pci(1, 1, ase, true);
angulos_ate = pci(1, 1, ate, true);

muestras = 0:periodo:sum(duraciones);
angulos_iniciales_cell = repmat(mat2cell([angulos_ini, angulos_des,...
    angulos_ase, angulos_ate], 2, 4), numel(muestras), 1);
duraciones_cell = repmat(num2cell(duraciones, 1), numel(muestras), 1);
t_cell = num2cell(muestras');
angulos_cell = cellfun(@calcular_angulos, angulos_iniciales_cell,...
    duraciones_cell, t_cell, 'UniformOutput', false);

angulos = cell2mat(angulos_cell');

p = pcd(1, 1, angulos(1,:), angulos(2, :));

close all;

for i = 1:numel(muestras)
    plot(p(1, 1:i), p(2, 1:i));
    hold(gca, 'on');
    robot(1, angulos(1, i), p(:, i));
    hold(gca,'off');
    pause(periodo);
end

hold(gca, 'on');
puntos_criticos = [ini, des, ase, ate];
plot(puntos_criticos(1,:), puntos_criticos(2, :), 'x');
hold(gca, 'off');

pause;
close all;
subplot(2, 2, 1),
    plot(muestras, angulos(2, :));
    title('Angulo')
subplot(2, 2, 2),
    plot(muestras(2:end), diff(angulos(2, :))./diff(muestras));
    title('Velocidad')
subplot(2, 2, 3),
    plot(muestras(3:end), diff(angulos(2, :), 2)/periodo);
    title('Aceleracion')
subplot(2, 2, 4),
    plot(muestras(4:end), diff(angulos(2, :), 3)/periodo);
    title('Jerk')
