# 🧪 PROBANDO TU SOLUCIÓN CON CASOS EDGE

def segundo_mayor(numeros)
  numeros.sort.reverse[1]
end

puts "🔥 PROBANDO CASOS EDGE:"
puts "=" * 30

# Caso normal
puts "Test 1: #{segundo_mayor([3, 1, 4, 1, 5, 9, 2, 6])} (esperado: 6) ✅"

# Casos problemáticos
puts "Test 2: #{segundo_mayor([1, 1, 1])} (esperado: nil) ❓"
puts "Test 3: #{segundo_mayor([5, 2])} (esperado: 2) ❓"
puts "Test 4: #{segundo_mayor([1])} (esperado: nil) ❓"
puts "Test 5: #{segundo_mayor([])} (esperado: nil) ❓"

puts "\n🤔 ¿Qué opinas de estos resultados?"