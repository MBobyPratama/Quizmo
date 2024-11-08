import type { Config } from "tailwindcss";

const config: Config = {
  content: [
    "./pages/**/*.{js,ts,jsx,tsx,mdx}",
    "./components/**/*.{js,ts,jsx,tsx,mdx}",
    "./app/**/*.{js,ts,jsx,tsx,mdx}",
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Inter', 'sans-serif'],
      },
      textColor: {
        skin: {
          base: 'var(--color-text-base)',
          muted: 'var(--color-text-muted)',
          inverted: 'var(--color-text-inverted)',
          accent: 'var(--color-text-accent)',
        }
      },
      
      backgroundColor: {
        skin: {
          fill: 'var(--color-fill)',
          secondary: 'var(--color-secondary)',
          
          'button-primary': 'var(--color-button-primary)',
          'button-primary-hover': 'var(--color-button-primary-hover)',
          'button-secondary': 'var(--color-button-secondary)',
          'button-secondary-hover': 'var(--color-button-secondary-hover)'
        }
      },

      

    },
  },
  plugins: [],
};
export default config;
