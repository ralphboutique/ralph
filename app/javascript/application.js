import "controllers";
import Rails from "@rails/ujs";
Rails.start();
//= require select2
//= require select2-full

// Importar jQuery y asignarlo a window
import $ from "jquery";
window.$ = window.jQuery = $;

// Importar Select2
import "select2";

// Asegurar que Select2 se inicializa correctamente
document.addEventListener("turbo:load", function () {
    $(".select2").select2({
      matcher: function (params, data) {
        // Si no se ingresa nada, devolver el elemento
        if ($.trim(params.term) === '') {
          return data;
        }
  
        // Convertir el término de búsqueda y el texto del elemento a minúsculas y buscar si el término está en alguna parte del texto
        if (data.text.toLowerCase().includes(params.term.toLowerCase())) {
          return data;
        }
  
        // Si no hay coincidencia, devolver null para que no se muestre en los resultados
        return null;
      }
    });
  });
  