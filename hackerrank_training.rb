# 🥷 ENTRENAMIENTO HACKERRANK - NIVEL RUBY NINJA
# =============================================
# Ejercicios REALES de entrevistas técnicas

puts "🔥 ENTRENAMIENTO HACKERRANK - RUBY EDITION"
puts "=" * 50

# 📊 PROBLEMA 1: ARRAYS Y MANIPULACIÓN
# ===================================
# Encuentra el segundo número más grande en un array

def segundo_mayor(numeros)
  # Solución NINJA con Ruby idiomático
  numeros.uniq.sort.reverse[1]
end

# Versión optimizada O(n)
def segundo_mayor_optimizado(numeros)
  mayor = segundo = -Float::INFINITY
  
  numeros.each do |num|
    if num > mayor
      segundo = mayor
      mayor = num
    elsif num > segundo && num != mayor
      segundo = num
    end
  end
  
  segundo == -Float::INFINITY ? nil : segundo
end

puts "\n📊 PROBLEMA 1: Segundo número mayor"
test_array = [3, 1, 4, 1, 5, 9, 2, 6]
puts "Array: #{test_array}"
puts "Segundo mayor: #{segundo_mayor(test_array)}"
puts "Optimizado: #{segundo_mayor_optimizado(test_array)}"

# 🔄 PROBLEMA 2: STRINGS Y PALINDROMOS
# ===================================
# Verifica si una string es un palíndromo (ignora espacios y mayúsculas)

def palindromo?(texto)
  # Limpieza y comparación en una línea - RUBY POWER!
  limpio = texto.downcase.gsub(/[^a-z0-9]/, '')
  limpio == limpio.reverse
end

# Versión con two pointers (más eficiente)
def palindromo_optimizado?(texto)
  limpio = texto.downcase.gsub(/[^a-z0-9]/, '')
  left, right = 0, limpio.length - 1
  
  while left < right
    return false if limpio[left] != limpio[right]
    left += 1
    right -= 1
  end
  
  true
end

puts "\n🔄 PROBLEMA 2: Palíndromos"
test_strings = ["A man a plan a canal Panama", "race a car", "hello"]
test_strings.each do |str|
  puts "#{str}: #{palindromo?(str)}"
end

# 🧮 PROBLEMA 3: ALGORITMO CLÁSICO - FIBONACCI
# ===========================================
# Múltiples implementaciones para mostrar tu versatilidad

# Recursivo simple (ineficiente pero elegante)
def fib_recursivo(n)
  return n if n <= 1
  fib_recursivo(n - 1) + fib_recursivo(n - 2)
end

# Iterativo (eficiente)
def fib_iterativo(n)
  return n if n <= 1
  
  a, b = 0, 1
  (2..n).each { a, b = b, a + b }
  b
end

# Con memoización (recursivo pero eficiente)
def fib_memo(n, memo = {})
  return n if n <= 1
  return memo[n] if memo[n]
  
  memo[n] = fib_memo(n - 1, memo) + fib_memo(n - 2, memo)
end

# Ruby idiomático con Enumerator
def fib_sequence(limit)
  Enumerator.new do |y|
    a, b = 0, 1
    loop do
      y << a
      a, b = b, a + b
      break if a > limit
    end
  end
end

puts "\n🧮 PROBLEMA 3: Fibonacci"
n = 10
puts "Fib(#{n}) recursivo: #{fib_recursivo(n)}"
puts "Fib(#{n}) iterativo: #{fib_iterativo(n)}"
puts "Fib(#{n}) memoizado: #{fib_memo(n)}"
puts "Secuencia hasta 100: #{fib_sequence(100).to_a}"

# 🔍 PROBLEMA 4: BÚSQUEDA Y ORDENAMIENTO
# =====================================
# Binary Search - algoritmo clásico de entrevistas

def busqueda_binaria(array, target)
  left, right = 0, array.length - 1
  
  while left <= right
    mid = (left + right) / 2
    
    case array[mid] <=> target
    when -1
      left = mid + 1
    when 1
      right = mid - 1
    else
      return mid  # Encontrado!
    end
  end
  
  -1  # No encontrado
end

# Merge Sort - demuestra conocimiento de algoritmos
def merge_sort(array)
  return array if array.length <= 1
  
  mid = array.length / 2
  left = merge_sort(array[0...mid])
  right = merge_sort(array[mid..-1])
  
  merge(left, right)
end

def merge(left, right)
  result = []
  i = j = 0
  
  while i < left.length && j < right.length
    if left[i] <= right[j]
      result << left[i]
      i += 1
    else
      result << right[j]
      j += 1
    end
  end
  
  result + left[i..-1] + right[j..-1]
end

puts "\n🔍 PROBLEMA 4: Búsqueda y ordenamiento"
sorted_array = [1, 3, 5, 7, 9, 11, 13, 15]
target = 7
puts "Array: #{sorted_array}"
puts "Buscar #{target}: posición #{busqueda_binaria(sorted_array, target)}"

unsorted = [64, 34, 25, 12, 22, 11, 90]
puts "Desordenado: #{unsorted}"
puts "Merge sort: #{merge_sort(unsorted)}"

# 📈 PROBLEMA 5: HASH MAPS Y FRECUENCIAS
# =====================================
# Cuenta frecuencias y encuentra el más común

def elemento_mas_frecuente(array)
  # Ruby one-liner NINJA style!
  array.group_by(&:itself).max_by { |k, v| v.length }
end

def top_k_frecuentes(array, k)
  frecuencias = Hash.new(0)
  array.each { |elemento| frecuencias[elemento] += 1 }
  
  frecuencias.sort_by { |elemento, freq| -freq }.first(k).map(&:first)
end

puts "\n📈 PROBLEMA 5: Frecuencias"
test_freq = [1, 3, 2, 1, 4, 1, 2, 5]
puts "Array: #{test_freq}"
mas_frecuente = elemento_mas_frecuente(test_freq)
puts "Más frecuente: #{mas_frecuente[0]} (#{mas_frecuente[1].length} veces)"
puts "Top 3 frecuentes: #{top_k_frecuentes(test_freq, 3)}"

# 🎯 PROBLEMA 6: TWO SUM (CLÁSICO DE LEETCODE)
# ===========================================
# Encuentra dos números que sumen un target

def two_sum(nums, target)
  hash = {}
  
  nums.each_with_index do |num, i|
    complement = target - num
    return [hash[complement], i] if hash[complement]
    hash[num] = i
  end
  
  []
end

# Versión con Ruby idiomático
def two_sum_ruby(nums, target)
  nums.combination(2).with_index.find do |(a, b), _|
    a + b == target
  end&.last || []
end

puts "\n🎯 PROBLEMA 6: Two Sum"
nums = [2, 7, 11, 15]
target_sum = 9
puts "Array: #{nums}, Target: #{target_sum}"
puts "Índices: #{two_sum(nums, target_sum)}"

# 🏆 PROBLEMA 7: VALIDACIÓN DE PARÉNTESIS
# ======================================
# Stack problem clásico

def parentesis_validos?(s)
  stack = []
  pairs = { '(' => ')', '[' => ']', '{' => '}' }
  
  s.each_char do |char|
    if pairs.key?(char)
      stack.push(char)
    elsif pairs.value?(char)
      return false if stack.empty? || pairs[stack.pop] != char
    end
  end
  
  stack.empty?
end

puts "\n🏆 PROBLEMA 7: Paréntesis válidos"
test_brackets = ["()", "()[]{}", "(]", "([)]", "{[]}"]
test_brackets.each do |brackets|
  puts "#{brackets}: #{parentesis_validos?(brackets)}"
end

# 💡 PROBLEMA 8: ANAGRAMAS
# =========================
def anagramas?(str1, str2)
  str1.downcase.chars.sort == str2.downcase.chars.sort
end

def agrupar_anagramas(strings)
  strings.group_by { |str| str.downcase.chars.sort.join }
end

puts "\n💡 PROBLEMA 8: Anagramas"
puts "listen, silent: #{anagramas?('listen', 'silent')}"
palabras = ["eat", "tea", "tan", "ate", "nat", "bat"]
puts "Grupos de anagramas: #{agrupar_anagramas(palabras).values}"

puts "\n🎓 ANÁLISIS DE COMPLEJIDAD:"
puts "================================"
puts "Segundo mayor optimizado: O(n) tiempo, O(1) espacio"
puts "Búsqueda binaria: O(log n) tiempo, O(1) espacio" 
puts "Merge sort: O(n log n) tiempo, O(n) espacio"
puts "Two sum: O(n) tiempo, O(n) espacio"
puts "Paréntesis válidos: O(n) tiempo, O(n) espacio"

puts "\n🚀 TIPS PARA ENTREVISTAS:"
puts "=========================="
puts "✅ Siempre pregunta sobre casos edge (arrays vacíos, nulos)"
puts "✅ Explica tu approach antes de codificar"
puts "✅ Empieza con solución simple, luego optimiza"
puts "✅ Menciona complejidad temporal y espacial"
puts "✅ Usa nombres de variables descriptivos"
puts "✅ Prueba tu código con ejemplos"

puts "\n🔥 ¡ESTÁS LISTO PARA HACKERRANK!"