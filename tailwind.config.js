/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ["*.html", "./src/**/*.rs"],
  daisyui: {
    themes: ["light", "dark", "retro", "aqua"],
  },
  theme: {
    extend: {},
  },
  plugins: [require("daisyui")],
};
