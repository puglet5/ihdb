/* eslint-disable */

module.exports = {
  darkMode: "class",
  content: [
    './app/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js',
    './node_modules/flowbite/dist/datepicker.js'
  ],

  theme: {
    extend: {
      aspectRatio: {
        '4/3': '4 / 3',
      },
      boxShadow: {
        "3xl": "0 0 120px rgba(0, 0, 0, 0.3)",
      },
      maxHeight: {
        "1/2": "50vh",
      },
      minHeight: {
        "1/2": "50%",
        "2/3": "66%",
      },
      maxWidth: {
        "1/2": "50%",
        "2/3": "66%",
        "4/5": "80%",
      },
      container: {
        center: true
      },
    },
  }
}
