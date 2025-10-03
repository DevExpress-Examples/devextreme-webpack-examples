import { defineConfig } from 'vite';
import vue from '@vitejs/plugin-vue';

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [vue()],
  server: {
    port: 9900,
    open: true
  },
  build: {
    outDir: 'dist'
  },
  resolve: {
    alias: {
      'devextreme/ui': 'devextreme/esm/ui'
    }
  }
});
