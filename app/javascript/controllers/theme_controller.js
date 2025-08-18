import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.initializeTheme()
  }

  toggle() {
    const currentTheme = document.documentElement.getAttribute('data-theme')
    const newTheme = currentTheme === 'dark' ? 'light' : 'dark'
    this.setTheme(newTheme)
  }

  initializeTheme() {
    // Check for saved theme preference or default to system preference
    const savedTheme = localStorage.getItem('theme')
    const systemPrefersDark = window.matchMedia('(prefers-color-scheme: dark)').matches
    
    let theme
    if (savedTheme) {
      theme = savedTheme
    } else {
      theme = systemPrefersDark ? 'dark' : 'light'
    }
    
    this.setTheme(theme)
    
    // Listen for system theme changes
    window.matchMedia('(prefers-color-scheme: dark)').addListener((e) => {
      if (!localStorage.getItem('theme')) {
        this.setTheme(e.matches ? 'dark' : 'light')
      }
    })
  }

  setTheme(theme) {
    document.documentElement.setAttribute('data-theme', theme)
    localStorage.setItem('theme', theme)
    this.updateToggleButton(theme)
  }

  updateToggleButton(theme) {
    const lightIcon = this.element.querySelector('.theme-icon-light')
    const darkIcon = this.element.querySelector('.theme-icon-dark')
    
    if (theme === 'dark') {
      lightIcon.style.display = 'none'
      darkIcon.style.display = 'inline'
    } else {
      lightIcon.style.display = 'inline'
      darkIcon.style.display = 'none'
    }
  }
}