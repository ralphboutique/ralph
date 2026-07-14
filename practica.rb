# 🔥 PRÁCTICA DE RUBY - NIVEL JUNIOR A SEMI-SENIOR
# ================================================

puts "🚀 ¡Bienvenido a la práctica de Ruby!"
puts "=" * 50

# 📚 EJERCICIO 1: VARIABLES Y TIPOS DE DATOS
# ==========================================

# Strings
nombre = "Ralph"
apellido = "Boutique"
nombre_completo = "#{nombre} #{apellido}"

# Numbers
precio = 75.50
cantidad = 10
total = precio * cantidad

# Arrays
productos = ["vestido", "blusa", "pantalón", "zapatos"]
precios = [75.50, 45.00, 65.00, 120.00]

# Hashes (como los objetos en JS)
articulo = {
  titulo: "Vestido Elegante",
  precio: 75.50,
  categoria: "Vestidos",
  disponible: true
}

puts "\n📊 DATOS BÁSICOS:"
puts "Nombre completo: #{nombre_completo}"
puts "Total: $#{total}"
puts "Productos: #{productos}"
puts "Artículo: #{articulo[:titulo]} - $#{articulo[:precio]}"

# 🔄 EJERCICIO 2: CONTROL DE FLUJO
# =================================

puts "\n🔄 CONTROL DE FLUJO:"

# If/elsif/else
stock = 5
status = if stock > 10
          "Abundante"
        elsif stock > 0
          "Disponible" 
        else
          "Agotado"
        end

puts "Stock: #{stock} - Estado: #{status}"

# Case/when (como switch en otros lenguajes)
categoria = "vestidos"
descuento = case categoria.downcase
           when "vestidos"
             0.15
           when "zapatos" 
             0.10
           when "accesorios"
             0.05
           else
             0.0
           end

puts "Categoría: #{categoria.capitalize} - Descuento: #{descuento * 100}%"

# 🔁 EJERCICIO 3: ITERADORES (¡La magia de Ruby!)
# ===============================================

puts "\n🔁 ITERADORES MÁGICOS:"

# Each - el más básico
puts "Productos disponibles:"
productos.each_with_index do |producto, index|
  puts "#{index + 1}. #{producto.capitalize}"
end

# Map - transforma cada elemento
productos_mayusculas = productos.map(&:upcase)
puts "En mayúsculas: #{productos_mayusculas}"

# Select - filtra elementos
productos_largos = productos.select { |p| p.length > 6 }
puts "Productos con nombre largo: #{productos_largos}"

# Reduce - acumula valores
total_precios = precios.reduce(0) { |suma, precio| suma + precio }
puts "Total de todos los precios: $#{total_precios}"

# 🏗️ EJERCICIO 4: MÉTODOS PERSONALIZADOS
# ======================================

puts "\n🏗️ MÉTODOS PERSONALIZADOS:"

# Método simple
def saludo(nombre)
  "¡Hola #{nombre}! Bienvenido a Ralph Boutique"
end

# Método con parámetros opcionales
def calcular_precio_final(precio, descuento = 0, impuesto = 0.12)
  precio_con_descuento = precio * (1 - descuento)
  precio_final = precio_con_descuento * (1 + impuesto)
  precio_final.round(2)
end

# Método que recibe un block
def aplicar_descuento_personalizado(productos_hash)
  productos_hash.each do |producto, precio|
    nuevo_precio = yield(precio) if block_given?
    puts "#{producto}: $#{precio} → $#{nuevo_precio}"
  end
end

puts saludo("María")

precio_vestido = calcular_precio_final(75.50, 0.15)
puts "Precio final del vestido: $#{precio_vestido}"

puts "\nDescuentos personalizados:"
productos_precios = { "Vestido" => 75.50, "Blusa" => 45.00 }
aplicar_descuento_personalizado(productos_precios) do |precio|
  precio * 0.8  # 20% de descuento
end

# 🎯 EJERCICIO PRÁCTICO: Simular tu sistema de ventas
# ===================================================

puts "\n🎯 SIMULACIÓN DE VENTA:"

# Simular una venta
class VentaSimple
  attr_accessor :items, :cliente
  
  def initialize(cliente)
    @cliente = cliente
    @items = []
  end
  
  def agregar_item(producto, precio, cantidad = 1)
    @items << { producto: producto, precio: precio, cantidad: cantidad }
  end
  
  def total
    @items.sum { |item| item[:precio] * item[:cantidad] }
  end
  
  def mostrar_resumen
    puts "\n📄 RESUMEN DE VENTA"
    puts "Cliente: #{@cliente}"
    puts "Items:"
    @items.each do |item|
      subtotal = item[:precio] * item[:cantidad]
      puts "  - #{item[:producto]} x#{item[:cantidad]} = $#{subtotal}"
    end
    puts "TOTAL: $#{total}"
  end
end

# Crear una venta de ejemplo
venta = VentaSimple.new("María González")
venta.agregar_item("Vestido Elegante", 75.50)
venta.agregar_item("Zapatos", 120.00)
venta.agregar_item("Blusa", 45.00, 2)

venta.mostrar_resumen

puts "\n🔥 ¡EXCELENTE! Has practicado:"
puts "✅ Variables y tipos de datos"
puts "✅ Control de flujo (if/case)"
puts "✅ Iteradores mágicos (each, map, select, reduce)"
puts "✅ Métodos personalizados"
puts "✅ Clases básicas"
puts "✅ Blocks y yield"

puts "\n🚀 ¿Qué quieres practicar ahora?"
puts "1. 🏗️ Clases más avanzadas"
puts "2. 🔄 Más iteradores y enumerables"
puts "3. 💎 Metaprogramming"
puts "4. 🧪 Integrar con tu sistema Rails"
