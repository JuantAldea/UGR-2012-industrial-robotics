function trayectoria_pcd(duracion, periodo)
n_pasos = duracion / periodo;
%n_pasos = 1000;

th1 = 0:(pi/2)/n_pasos:pi/2;
th2 = 0:(pi/2)/n_pasos:pi/2;

p = pcd(1, 1, th1, th2);

for i = 1:n_pasos + 1
    plot(p(1, 1:i), p(2, 1:i));
    hold(gca, 'on');
    robot(1, th1(i), p(:,i));
    hold(gca,'off');
    pause(periodo);
end
