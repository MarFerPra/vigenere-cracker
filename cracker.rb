#!/usr/bin/env ruby

def indice_freeman_subcadena(cadena)
  alfabeto = ['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z']
  tam_cadena = cadena.length
  indice_freeman = 0
  for letra in alfabeto do
    veces_letra = 0

    tam_cadena.times do |i|
      if cadena[i] == letra
        veces_letra += 1
      end
    end

    f_letra = (veces_letra * (veces_letra-1))*1.0 / (tam_cadena*(tam_cadena-1))*1.0
    indice_freeman += f_letra
  end
  indice_freeman
end

file = File.open("texto_cifrado07.txt")
criptograma = file.read

tam_texto = criptograma.length
matriz_indices = []
# Para cada valor de la clave
rango = 8...1
(rango.first).downto(rango.last).each do |long_clave|
  cantidad_subcadenas = (tam_texto / long_clave).ceil
  array_indices = []
  # Para cada subcadena
  cantidad_subcadenas.times do |i_subcadena|
    subcadena = ''

    i = 0
    while((i_subcadena + long_clave*i) < tam_texto) do
      subcadena += criptograma[i_subcadena + long_clave*i]
      i += 1
    end

    array_indices  << indice_freeman_subcadena(subcadena)
  end

  media = 0.0
  for i in array_indices do
    media += array_indices[i]
  end

  media = media / array_indices.length*1.0
  if media < 0.08 && media > 0.07
    puts "Media: " + media.to_s
    puts "Con long_clave: " + long_clave.to_s
  end

  matriz_indices << array_indices
end

puts matriz_indices.to_s
