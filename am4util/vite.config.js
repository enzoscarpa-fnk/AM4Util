import { fileURLToPath, URL } from 'node:url'
import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'
import tailwindcss from '@tailwindcss/vite'

export default defineConfig({
  plugins: [
    vue(),
    tailwindcss(),
  ],
  resolve: {
    alias: {
      '@': fileURLToPath(new URL('./src', import.meta.url))
    },
  },
  build: {
    sourcemap: false, // Désactiver les source maps en production
    minify: 'terser', // Minification optimale
    chunkSizeWarningLimit: 1000,
  },
  // Pour un sous-domaine
  base: '/',
})
