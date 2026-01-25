import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

// https://vite.dev/config/
export default defineConfig({
  plugins: [react()],
  server: {
    host: '0.0.0.0',
    port: 5173,
    strictPort: true,
    hmr: {
      clientPort: 5173,
    },
    allowedHosts: [
      'localhost',
      '127.0.0.1',
      'nextgensis.mooazsayyed.live',
      'preprod.nextgensis.mooazsayyed.live',
      '54.87.192.112'
    ]
  },
  preview: {
    host: '0.0.0.0',
    port: 5173,
    strictPort: true,
    allowedHosts: [
      'localhost',
      '127.0.0.1',
      'nextgensis.mooazsayyed.live',
      'preprod.nextgensis.mooazsayyed.live',
      'staging.nextgensis.mooazsayyed.live',
      'dev.nextgensis.mooazsayyed.live',
      'local.nextgensis.mooazsayyed.live',
      '54.87.192.112'
    ]
  }
})
