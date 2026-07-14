# 🎯 EJERCICIOS DE ENTREVISTA - PRACTICA AQUÍ
# ==========================================
# Resuelve cada ejercicio paso a paso
# ¡No mires las soluciones hasta intentarlo!

puts "🔥 EJERCICIOS DE ENTREVISTA TÉCNICA"
puts "=" * 40

# 📊 EJERCICIO 1: SEGUNDO MAYOR
# =============================
# Encuentra el segundo número más grande en un array
# Ejemplo: [3, 1, 4, 1, 5, 9, 2, 6] → 6
#   
# Requisitos:
# - Si hay duplicados, ignorarlos
# - Si no hay segundo mayor, retornar nil
# - Complejidad: O(n)

# def segundo_mayor(numeros)
#   # TU CÓDIGO AQUÍ 👇
#  unicos = numeros.uniq.sort.reverse
#  unicos.length >= 2 ? unicos[1] : nil
# end
# puts segundo_mayor([3, 1, 4, 1, 5, 9, 2, 6])
 
# # 🧪 PRUEBAS:
# puts "\n📊 EJERCICIO 1: Segundo mayor"
# puts "Test 1: #{segundo_mayor([3, 1, 4, 1, 5, 9, 2, 6])} (esperado: 6)"
# puts "Test 2: #{segundo_mayor([1, 1, 1])} (esperado: nil)"
# puts "Test 3: #{segundo_mayor([5, 2])} (esperado: 2)"

# # 🔄 EJERCICIO 2: PALÍNDROMO
# # ==========================
# # Verifica si una frase es palíndromo (ignora espacios y mayúsculas)
# # Ejemplo: "A man a plan a canal Panama" → true
# #
# # Requisitos:
# # - Ignorar espacios, puntuación y mayúsculas
# # - Solo considerar letras y números

# def palindromo?(texto)
#   # TU CÓDIGO AQUÍ 👇
#   texto = texto.downcase.gsub(/[^a-z0-9]/, '')
#   puts texto == texto.reverse ? true : false

# end

# # 🧪 PRUEBAS:
# puts "\n🔄 EJERCICIO 2: Palíndromo"
#puts "Test 1: #{palindromo?("A man a plan a canal Panama")} (esperado: true)"
# ps "Test 2: #{palindromo?("race a car")} (esperado: false)"
# puts "Test 3: #{palindromo?("Madam")} (esperado: true)"

# # 🧮 EJERCICIO 3: FIBONACCI
# # =========================
# # Implementa fibonacci de forma eficiente
# # Ejemplo: fib(6) → 8 (secuencia: 0,1,1,2,3,5,8)
# #
# # Requisitos:
# # - Debe ser eficiente (no recursión simple)
# # - Complejidad: O(n) tiempo, O(1) espacio

# def fibonacci(n)
#   # TU CÓDIGO AQUÍ 👇
  
# end

# # 🧪 PRUEBAS:
# puts "\n🧮 EJERCICIO 3: Fibonacci"
# puts "Test 1: #{fibonacci(0)} (esperado: 0)"
# puts "Test 2: #{fibonacci(1)} (esperado: 1)"
# puts "Test 3: #{fibonacci(6)} (esperado: 8)"
# puts "Test 4: #{fibonacci(10)} (esperado: 55)"

# # 🎯 EJERCICIO 4: TWO SUM (CLÁSICO LEETCODE)
# # ==========================================
# # Encuentra dos números que sumen un target
# # Ejemplo: [2, 7, 11, 15], target=9 → [0, 1]
# #
# # Requisitos:
# # - Retorna los ÍNDICES de los dos números
# # - Complejidad: O(n) tiempo, O(n) espacio
# # - Solo hay una solución válida

# def two_sum(nums, target)
#   # TU CÓDIGO AQUÍ 👇
  
# end

# # 🧪 PRUEBAS:
# puts "\n🎯 EJERCICIO 4: Two Sum"
# puts "Test 1: #{two_sum([2, 7, 11, 15], 9)} (esperado: [0, 1])"
# puts "Test 2: #{two_sum([3, 2, 4], 6)} (esperado: [1, 2])"
# puts "Test 3: #{two_sum([3, 3], 6)} (esperado: [0, 1])"

# # 🏆 EJERCICIO 5: PARÉNTESIS VÁLIDOS
# # ==================================
# # Verifica si los paréntesis están balanceados
# # Ejemplo: "()[]{}" → true, "([)]" → false
# #
# # Requisitos:
# # - Tipos: (), [], {}
# # - Deben estar correctamente anidados
# # - Usa una pila (stack)

# def parentesis_validos?(s)
#   # TU CÓDIGO AQUÍ 👇
  
# end

# # 🧪 PRUEBAS:
# puts "\n🏆 EJERCICIO 5: Paréntesis válidos"
# puts "Test 1: #{parentesis_validos?("()")} (esperado: true)"
# puts "Test 2: #{parentesis_validos?("()[]{}")} (esperado: true)"
# puts "Test 3: #{parentesis_validos?("(]")} (esperado: false)"
# puts "Test 4: #{parentesis_validos?("([)]")} (esperado: false)"

# # 💡 EJERCICIO 6: ANAGRAMAS
# # =========================
# # Verifica si dos strings son anagramas
# # Ejemplo: "listen", "silent" → true
# #
# # Requisitos:
# # - Ignorar mayúsculas
# # - Dos approaches diferentes

# def anagramas?(str1, str2)
#   # TU CÓDIGO AQUÍ 👇
  
# end

# # 🧪 PRUEBAS:
# puts "\n💡 EJERCICIO 6: Anagramas"
# puts "Test 1: #{anagramas?("listen", "silent")} (esperado: true)"
# puts "Test 2: #{anagramas?("evil", "vile")} (esperado: true)"
# puts "Test 3: #{anagramas?("hello", "bello")} (esperado: false)"

# # 📈 EJERCICIO 7: ELEMENTO MÁS FRECUENTE
# # ======================================
# # Encuentra el elemento que aparece más veces
# # Ejemplo: [1,1,2,2,2,3] → 2
# #
# # Requisitos:
# # - Si hay empate, cualquiera de los empatados
# # - Una línea de Ruby idiomático

# def mas_frecuente(array)
#   # TU CÓDIGO AQUÍ 👇
  
# end

# # 🧪 PRUEBAS:
# puts "\n📈 EJERCICIO 7: Más frecuente"
# puts "Test 1: #{mas_frecuente([1,1,2,2,2,3])} (esperado: 2)"
# puts "Test 2: #{mas_frecuente([1])} (esperado: 1)"
# puts "Test 3: #{mas_frecuente([1,2,3,1,2,1])} (esperado: 1)"

# # 🔍 EJERCICIO 8: BÚSQUEDA BINARIA
# # ================================
# # Implementa búsqueda binaria
# # Ejemplo: buscar 7 en [1,3,5,7,9,11] → 3 (índice)
# #
# # Requisitos:
# # - Array ya está ordenado
# # - Retorna índice o -1 si no existe
# # - Complejidad: O(log n)

# def busqueda_binaria(array, target)
#   # TU CÓDIGO AQUÍ 👇
  
# end

# # 🧪 PRUEBAS:
# puts "\n🔍 EJERCICIO 8: Búsqueda binaria"
# puts "Test 1: #{busqueda_binaria([1,3,5,7,9,11], 7)} (esperado: 3)"
# puts "Test 2: #{busqueda_binaria([1,3,5,7,9,11], 2)} (esperado: -1)"
# puts "Test 3: #{busqueda_binaria([1], 1)} (esperado: 0)"

# # 🎪 EJERCICIO 9: ROTAR ARRAY
# # ===========================
# # Rota un array k posiciones a la derecha
# # Ejemplo: [1,2,3,4,5], k=2 → [4,5,1,2,3]
# #
# # Requisitos:
# # - No usar arrays auxiliares
# # - Modifica el array original

# def rotar_array(nums, k)
#   # TU CÓDIGO AQUÍ 👇
  
# end

# # 🧪 PRUEBAS:
# test_array1 = [1,2,3,4,5]
# rotar_array(test_array1, 2)
# puts "\n🎪 EJERCICIO 9: Rotar array"
# puts "Test 1: #{test_array1} (esperado: [4,5,1,2,3])"

# # 🌟 EJERCICIO BONUS: SUBSECUENCIA MÁS LARGA
# # ==========================================
# # Encuentra la subsecuencia de números consecutivos más larga
# # Ejemplo: [100, 4, 200, 1, 3, 2] → 4 (secuencia: 1,2,3,4)
# #
# # Requisitos:
# # - Los números no tienen que estar consecutivos en el array
# # - Complejidad: O(n)

# def subsecuencia_consecutiva_mas_larga(nums)
#   # TU CÓDIGO AQUÍ 👇
  
# end

# # 🧪 PRUEBAS:
# puts "\n🌟 EJERCICIO BONUS: Subsecuencia más larga"
# puts "Test 1: #{subsecuencia_consecutiva_mas_larga([100, 4, 200, 1, 3, 2])} (esperado: 4)"
# puts "Test 2: #{subsecuencia_consecutiva_mas_larga([0,3,7,2,5,8,4,6,0,1])} (esperado: 9)"

# puts "\n🎓 TIPS PARA RESOLVER:"
# puts "======================"
# puts "✅ Lee el problema 2 veces antes de empezar"
# puts "✅ Piensa en casos edge (arrays vacíos, un elemento)"
# puts "✅ Empieza con solución simple, luego optimiza"
# puts "✅ Usa nombres de variables descriptivos"
# puts "✅ Comenta tu lógica para la entrevista"
# puts "✅ Prueba con los casos de ejemplo"

# puts "\n📚 CONCEPTOS CLAVE A DOMINAR:"
# puts "=============================="
# puts "🔹 Hash maps para O(1) lookup"
# puts "🔹 Two pointers technique"
# puts "🔹 Stack para validaciones"
# puts "🔹 Sorting como preprocessing"
# puts "🔹 Binary search en arrays ordenados"
# puts "🔹 Sliding window para substrings"

# puts "\n🏁 ¡EMPIEZA A RESOLVER! ¡TÚ PUEDES!"