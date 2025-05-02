/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ["./src/**/*.{html,js,elm}"],
  theme: {
    extend: {
      animation: {
        'progress-bar': 'fill 5s linear infinite',
        'pop-in': 'pop-in 0.2s ease-in',
      }
    },
    keyframes: {
      fill: {
        '0%': {width: '0%'},
        '98%': {width: '100%'},
        '100%': {width: '100%'}
      },
      'pop-in': {
        '0%': {transform: 'scale(0.95)', opacity: '40%'},
        '40%': {transform: 'scale(1.02)'},
        '100%': {transform: 'scale(1)', opacity: '100%'}
      }
    }
  },
  plugins: [require("@tailwindcss/typography")],
}
