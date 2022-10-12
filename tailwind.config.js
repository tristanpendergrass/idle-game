/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ["./src/**/*.{html,js,elm}"],
  theme: {
    extend: {
      animation: {
        'progress-bar': 'fill 5s linear infinite'
      }
    },
    keyframes: {
      fill: {
        '0%': {width: '0%'},
        '95%': {width: '100%'},
        '100%': {width: '100%'}
      }
    }
  },
  plugins: [require("daisyui")],
}
