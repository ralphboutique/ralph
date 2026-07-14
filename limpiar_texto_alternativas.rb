# 🧹 ALTERNATIVAS PARA LIMPIAR TEXTO SIN REGEX
# ==========================================

texto = "A man a plan a canal Panama!"
puts "Texto original: '#{texto}'"
puts "=" * 50

# 🎯 MÉTODO 1: SELECT con chars + include?
def limpiar_metodo1(texto)
  validos = ('a'..'z').to_a + ('0'..'9').to_a
  texto.downcase.chars.select { |char| validos.include?(char) }.join
end

# 🎯 MÉTODO 2: SELECT con rangos
def limpiar_metodo2(texto)
  texto.downcase.chars.select do |char|
    (char >= 'a' && char <= 'z') || (char >= '0' && char <= '9')
  end.join
end

# 🎯 MÉTODO 3: DELETE (elimina lo que NO queremos)
def limpiar_metodo3(texto)
  # Ruby tiene un método delete que elimina caracteres
  limpio = texto.downcase
  # Elimina todo excepto a-z y 0-9
  limpio.delete('^a-z0-9')
end

# 🎯 MÉTODO 4: FILTER con ord (códigos ASCII)
def limpiar_metodo4(texto)
  texto.downcase.chars.filter do |char|
    codigo = char.ord
    # a=97, z=122, 0=48, 9=57
    (codigo >= 97 && codigo <= 122) || (codigo >= 48 && codigo <= 57)
  end.join
end

# 🎯 MÉTODO 5: ITERACIÓN MANUAL (más básico)
def limpiar_metodo5(texto)
  resultado = ""
  texto.downcase.each_char do |char|
    if ('a'..'z').include?(char) || ('0'..'9').include?(char)
      resultado += char
    end
  end
  resultado
end

# 🎯 MÉTODO 6: SCAN (como regex pero más simple)
def limpiar_metodo6(texto)
  # scan encuentra patrones, pero podemos usar caracteres simples
  texto.downcase.scan(/[a-z0-9]/).join
end

# 🎯 MÉTODO 7: TR (transliterate - reemplaza caracteres)
def limpiar_metodo7(texto)
  # tr elimina caracteres que no están en el rango
  texto.downcase.tr('^a-z0-9', '')
end

puts "\n🧪 PROBANDO TODOS LOS MÉTODOS:"
puts "=" * 40

metodos = [
  ["Método 1 (select + include)", method(:limpiar_metodo1)],
  ["Método 2 (select + rangos)", method(:limpiar_metodo2)],
  ["Método 3 (delete)", method(:limpiar_metodo3)],
  ["Método 4 (ord/ASCII)", method(:limpiar_metodo4)],
  ["Método 5 (iteración manual)", method(:limpiar_metodo5)],
  ["Método 6 (scan)", method(:limpiar_metodo6)],
  ["Método 7 (tr)", method(:limpiar_metodo7)]
]

metodos.each do |nombre, metodo|
  resultado = metodo.call(texto)
  puts "#{nombre}: '#{resultado}'"
end

puts "\n🏆 RECOMENDACIONES PARA ENTREVISTA:"
puts "=" * 45

puts "✅ MÁS LEGIBLE: Método 2 (select + rangos)"
puts "✅ MÁS EFICIENTE: Método 3 (delete) o Método 7 (tr)"
puts "✅ MÁS RUBY: Método 1 (select + include)"
puts "✅ SIN MÉTODOS FANCY: Método 5 (iteración manual)"

puts "\n🎯 PARA TU EJERCICIO DE PALÍNDROMO:"
puts "=" * 40

# Implementación completa del palíndromo
def palindromo_sin_regex?(texto)
  # Opción más clara para entrevista
  limpio = texto.downcase.chars.select do |char|
    (char >= 'a' && char <= 'z') || (char >= '0' && char <= '9')
  end.join
  
  limpio == limpio.reverse
end

# Pruebas
test_casos = [
  "A man a plan a canal Panama",
  "race a car", 
  "Madam",
  "12321",
  "hello world"
]

puts "\nPruebas del palíndromo:"
test_casos.each do |caso|
  resultado = palindromo_sin_regex?(caso)
  puts "\"#{caso}\" → #{resultado}"
end

puts "\n💡 EXPLICACIÓN PARA LA ENTREVISTA:"
puts "=" * 45
puts "1. Convertimos a minúsculas con .downcase"
puts "2. Dividimos en caracteres con .chars"
puts "3. Filtramos solo letras y números con .select"
puts "4. Unimos de nuevo con .join"
puts "5. Comparamos con su reverso"
puts "\nComplejidad: O(n) tiempo, O(n) espacio"