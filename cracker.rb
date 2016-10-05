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
  alfabeto = ['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z']
  cadena_ary = cadena.split("")
  unique_chars = cadena_ary.uniq
  aparicion_letras = {}
  distancia_e = 0

  for char in unique_chars do
    apariciones_count = cadena.count(char)
    porcentaje_aparicion = ((apariciones_count*1.0)/(cadena.length*1.0))*100.0
    aparicion_letras[char] = porcentaje_aparicion.round(4)
  end
  aparicion_letras = aparicion_letras.sort_by {|k,v| v}.reverse

  if(aparicion_letras[0][1] > 13) # letra E
    puts "Letra E: " + aparicion_letras[0][0] + " " + aparicion_letras[0][1].to_s
    letra = aparicion_letras[0][0]
    indice_letra = alfabeto.index(letra)
    indice_e = alfabeto.index('E')
    puts "Indice letra: " + indice_letra.to_s + " Indice E: " + (indice_e).to_s

    if(indice_letra < indice_e)
      distancia_e = (indice_e - indice_letra)
    else
      distancia_e = (indice_letra - indice_e)*(-1)
    end

  end

  if(aparicion_letras[1][1] > 10 && aparicion_letras[1][1] < 13)
    puts "Letra A: " + aparicion_letras[1][0] + " " + aparicion_letras[1][1].to_s

    letra = aparicion_letras[1][0]
    indice_letra = alfabeto.index(letra)
    puts "Distancia E: " + distancia_e.to_s
    if(alfabeto[indice_letra + distancia_e] == 'A')
      puts "- CORRECTO"
    end
  end
  puts "---------"

  cadena_texto_plano = ""
  (cadena.length).times do |i|
    letra = cadena[i].delete(' ')
    if !alfabeto.index(letra).nil?
      puts "Letra: " + letra + " Distancia E: " + distancia_e.to_s
      indice = alfabeto.index(letra) + distancia_e
      # todo
      puts "Indice: " + indice.to_s
      cadena_texto_plano += alfabeto[indice % alfabeto.length]
    end
  end
  cadena_texto_plano
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

 puts subcadenas_texto_plano

end

main
