const defaultTheme = require('tailwindcss/defaultTheme');
module.exports = {
  content: [
    './app/views/**/*.html.erb',   // Todas las vistas ERB
    './app/helpers/**/*.rb',      // Archivos de helpers
    './app/javascript/**/*.js',  // Archivos JS
    './app/assets/stylesheets/**/*.css', // Archivos CSS
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
      },
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/container-queries'),
  ]
}

