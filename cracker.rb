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

def descifrar(cadena)
  cadena_ary = cadena.split("")
  unique_chars = cadena_ary.uniq
  aparicion_letras = {}

  for char in unique_chars do
    apariciones_count = cadena.count(char)
    porcentaje_aparicion = ((apariciones_count*1.0)/(cadena.length*1.0))*100.0
    aparicion_letras[char] = porcentaje_aparicion.round(4)
  end
  aparicion_letras = aparicion_letras.sort_by {|k,v| v}.reverse
  puts aparicion_letras.to_s
end

def chunk(string, size)
    string.scan(/.{1,#{size}}/)
end

def main
  file = File.open("texto_cifrado07.txt")
  criptograma = file.read

  # salida   = encontrar_clave(criptograma)
  clave_final = 8 #salida[:clave]

  elementos_columna = (criptograma.length*1.0/clave_final*1.0).ceil
  puts "Elementos columna: " + elementos_columna.to_s

  subcadenas_aux = chunk(criptograma, elementos_columna)
  subcadenas_fin = []
  8.times do |c|
    subcad = ''
    elementos_columna.times do |f|
      subcad += criptograma[c + clave_final*f].nil? ? '': criptograma[c + clave_final*f]
    end
    subcadenas_fin.push(subcad)
  end

  subcadenas_texto_plano = []
  for cadena in subcadenas_fin do
      subcadenas_texto_plano << descifrar(cadena)
  end

end

main
