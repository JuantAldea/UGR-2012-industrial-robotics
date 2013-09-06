function angulos = trayectoria_pci(L1, L2, p0, pn, tiempo, T, animar)
    x0 = p0(1);
    y0 = p0(2);
    xn = pn(1);
    yn = pn(2);
    pasos = tiempo/T;
    x = x0:(xn - x0)/pasos:xn;
    y = y0:(yn - y0)/pasos:yn;
    
    %angulos correspondientes a la posicion de partida
    angulos_iniciales = pci(L1, L2, p0);
    
    %elegimos la solucion que tiene el th1 positivo
    if angulos_iniciales(1) >= 0
        angulos_iniciales = angulos_iniciales(:, 1);
    else
         angulos_iniciales = angulos_iniciales(:, 2);
    end
    
    angulos = zeros(2, pasos + 1);
    
    %display('angulos finales');
    %display(angulos_iniciales*180/pi);
    
    %como se  han creado tantos puntos como pasos hay entre los puntos
    %puede ser que un angulo tenga menos pasos que el otro porque su
    %movimiento termino antes, en ese caso los valores que faltan son
    %iguales al ultimo valor.
    
    if numel(x) < pasos + 1 
        x = [x, xn * ones(1, pasos - numel(x)) + 1];
    end 
    
    if numel(y) < pasos + 1
        y = [y, yn * ones(1, pasos - numel(y) + 1)];
    end
    
    %los primeros angulos son los angulos iniciales
    angulos(:, 1) = angulos_iniciales;
    for i = 2:pasos + 1
        angulos_i = pci(L1, L2, [x(i), y(i)]);
        %elige la solucion mas proxima a la anterior, evita saltos.
        if  abs(angulos_i(1) - angulos(1, i-1)) <...
                abs(angulos_i(3) - angulos(1, i-1))
            angulos(:, i) = angulos_i(:, 1);
        else
            angulos(:, i) = angulos_i(:, 2);
        end
        if (i == 6)
            display('discontinuidad')
            angulos(1,i)
            angulos(1, i - 1)
           abs(angulos(1,i) - angulos(1, i - 1)) 
        end
        
        if abs(angulos(1,i) - angulos(1, i - 1)) > pi/4
            posibilidades = [0, pi/2, pi, 4/3*pi, 2*pi];
            th1_anterior = ones(size(posibilidades)) * angulos(1, i-1);
            diferencias = abs(posibilidades - th1_anterior);
            [~, indice] = min(diferencias);
            angulos(1, i) = posibilidades(indice);
        end
        
        if abs(angulos(2,i) - angulos(2, i - 1)) > pi/4
            v_anterior = [cos(angulos(2, i-1)); sin(angulos(2, i-1))];
            v_actual = [cos(angulos(2, i)); sin(angulos(2, i))];
            diferencia = acos(dot(v_anterior, v_actual));
            
            angulos(2, i) = angulos(2, i-1) + ...
                sign(angulos(2, i-1)) .* diferencia;
            
            angulos(2,i)=mod(angulos(2,i), sign(angulos(2, i))*2*pi);
        end
    end
    
    p = pcd(1, 1, angulos(1,:), angulos(2, :));
    if animar == true
        for i = 1:pasos + 1
            plot(p(1, 1:i), p(2, 1:i));
            hold(gca, 'on');
            robot(1, angulos(1, i), p(:,i));
            hold(gca, 'off');
            pause(T);
        end
    end
end

