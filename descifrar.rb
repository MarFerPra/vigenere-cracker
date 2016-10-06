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
