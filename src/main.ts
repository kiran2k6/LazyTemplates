import '@/style.css'

import { createApp } from 'vue'
import App from '@/App.vue'

const app = createApp(App)
applyTheme()
app.mount('#app')

function applyTheme() {
  const body = document.getElementsByTagName('body')[0]!
  let theme = localStorage.getItem('theme')
  if (theme == null || (theme != 'dark' && theme != 'light')) {
    const prefersDark = window.matchMedia('(prefers-color-scheme: dark)')
    theme = prefersDark ? 'dark' : 'light'
  }
  body.className = theme
  localStorage.setItem('theme', theme)
}
