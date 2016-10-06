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
