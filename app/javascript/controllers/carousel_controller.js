import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="carousel"
export default class extends Controller {
  static targets = ["slide"]

  connect() {
    this.index = 0
    this.showCurrentSlide()
    this.startAutoSlide()
  }

  disconnect() {
    this.stopAutoSlide()
  }

  next() {
    this.index = (this.index + 1) % this.slideTargets.length
    this.showCurrentSlide()
  }

  previous() {
    this.index = (this.index - 1 + this.slideTargets.length) % this.slideTargets.length
    this.showCurrentSlide()
  }

  showCurrentSlide() {
    this.slideTargets.forEach((element, i) => {
      element.classList.toggle('hidden', i !== this.index)
    })
  }

  startAutoSlide() {
    this.autoSlideInterval = setInterval(() => {
      this.next()
    }, 3000) // Cambia la imagen cada 3 segundos
  }

  stopAutoSlide() {
    clearInterval(this.autoSlideInterval)
  }
}
