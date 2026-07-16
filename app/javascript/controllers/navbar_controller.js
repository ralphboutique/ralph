import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["mobileMenu", "overlay", "hamburger"]

  connect() {
    this.lastScroll = 0
    this.initScrollEffect()
  }

  toggleMobile() {
    this.mobileMenuTarget.classList.toggle("translate-x-full")
    this.mobileMenuTarget.classList.toggle("translate-x-0")
    this.overlayTarget.classList.toggle("hidden")
    this.overlayTarget.classList.toggle("opacity-0")
    this.overlayTarget.classList.toggle("opacity-100")
    this.hamburgerTarget.classList.toggle("active")
    document.body.classList.toggle("overflow-hidden")
  }

  closeMobile() {
    this.mobileMenuTarget.classList.add("translate-x-full")
    this.mobileMenuTarget.classList.remove("translate-x-0")
    this.overlayTarget.classList.add("hidden", "opacity-0")
    this.overlayTarget.classList.remove("opacity-100")
    this.hamburgerTarget.classList.remove("active")
    document.body.classList.remove("overflow-hidden")
  }

  initScrollEffect() {
    const navbar = this.element
    window.addEventListener("scroll", () => {
      const currentScroll = window.scrollY
      if (currentScroll > 50) {
        navbar.classList.add("scrolled")
      } else {
        navbar.classList.remove("scrolled")
      }
      this.lastScroll = currentScroll
    }, { passive: true })
  }
}
