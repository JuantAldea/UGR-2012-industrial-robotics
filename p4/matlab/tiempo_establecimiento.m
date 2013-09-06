function [t, indice] = tiempo_establecimiento(y, delta_t, consigna, umbral)
  error = abs(y - consigna);
  indice = find(error > umbral, 1, 'last') + 1;
  if numel(indice) > 0
    t = indice * delta_t;
  else
      t = [];
  end
end