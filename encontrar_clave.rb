require_relative 'indice_freeman'

def encontrar_clave(criptograma)
  tam_texto = criptograma.length
  matriz_indices = []
  matriz_texto = []
  # Para cada valor de la clave
  rango = 8...1
  (rango.first).downto(rango.last).each do |long_clave|
    longitud_subcadenas = ((tam_texto*1.0) / (long_clave*1.0)).ceil
    array_indices = []
    # Para cada subcadena
    longitud_subcadenas.times do |i_subcadena|
      subcadena = ''

      i = 0
      while((i_subcadena + long_clave*i) < tam_texto) do
        subcadena += criptograma[i_subcadena + long_clave*i]
        i += 1
      end
      matriz_texto << subcadena
      array_indices  << indice_freeman_subcadena(subcadena)
    end

    media = 0.0
    for i in array_indices do
      media += array_indices[i]
    end

    media = media / array_indices.length*1.0
    if media < 0.08 && media > 0.07
      puts "Media indices Freeman: " + media.to_s
      puts "Con long_clave: " + long_clave.to_s
      puts "Longitud de clave encontrada. \n"
      return {clave: long_clave, matriz_texto: matriz_texto}
    end

    matriz_indices << array_indices
  end
end
