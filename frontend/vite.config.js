import { defineConfig } from "vite";
import vue from "@vitejs/plugin-vue";
import { resolve } from "path";

export default defineConfig({
  plugins: [vue()],
  resolve: {
    alias: {
      "@": resolve(__dirname, "src"), // Алиас на папку src
    },
  },
  server: {
    proxy: {
      "/api": {
        target: "http://backend:3000", // Rails API service in Docker
        changeOrigin: true,

      },
    },
  },
});
