# 🔑 SOLUCIONES DE ENTREVISTA - ¡SOLO MIRA DESPUÉS DE INTENTAR!
# ============================================================
# Estas son las soluciones optimizadas

puts "🔑 SOLUCIONES COMPLETAS"
puts "=" * 30

# 📊 SOLUCIÓN 1: SEGUNDO MAYOR
def segundo_mayor(numeros)
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

# 🔄 SOLUCIÓN 2: PALÍNDROMO
def palindromo?(texto)
  limpio = texto.downcase.gsub(/[^a-z0-9]/, '')
  limpio == limpio.reverse
end

# 🧮 SOLUCIÓN 3: FIBONACCI
def fibonacci(n)
  return n if n <= 1
  
  a, b = 0, 1
  (2..n).each { a, b = b, a + b }
  b
end

# 🎯 SOLUCIÓN 4: TWO SUM
def two_sum(nums, target)
  hash = {}
  
  nums.each_with_index do |num, i|
    complement = target - num
    return [hash[complement], i] if hash[complement]
    hash[num] = i
  end
  
  []
end

# 🏆 SOLUCIÓN 5: PARÉNTESIS VÁLIDOS
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

# 💡 SOLUCIÓN 6: ANAGRAMAS
def anagramas?(str1, str2)
  str1.downcase.chars.sort == str2.downcase.chars.sort
end

# 📈 SOLUCIÓN 7: MÁS FRECUENTE
def mas_frecuente(array)
  array.group_by(&:itself).max_by { |k, v| v.length }[0]
end

# 🔍 SOLUCIÓN 8: BÚSQUEDA BINARIA
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
      return mid
    end
  end
  
  -1
end

# 🎪 SOLUCIÓN 9: ROTAR ARRAY
def rotar_array(nums, k)
  k = k % nums.length
  nums.replace(nums[-k..-1] + nums[0...-k])
end

# 🌟 SOLUCIÓN BONUS: SUBSECUENCIA CONSECUTIVA
def subsecuencia_consecutiva_mas_larga(nums)
  num_set = nums.to_set
  max_length = 0
  
  nums.each do |num|
    unless num_set.include?(num - 1)
      current_num = num
      current_length = 1
      
      while num_set.include?(current_num + 1)
        current_num += 1
        current_length += 1
      end
      
      max_length = [max_length, current_length].max
    end
  end
  
  max_length
end

puts "🎓 COMPLEJIDADES:"
puts "Segundo mayor: O(n) tiempo, O(1) espacio"
puts "Two sum: O(n) tiempo, O(n) espacio"
puts "Búsqueda binaria: O(log n) tiempo, O(1) espacio"
puts "Subsecuencia consecutiva: O(n) tiempo, O(n) espacio"