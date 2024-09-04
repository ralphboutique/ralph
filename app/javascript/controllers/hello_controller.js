import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "name", "output" ]
  connect() {
    // alert("Hello World desede select!")
  }
  greet() {
    this.outputTarget.textContent =
      `Hello, ${this.nameTarget.value}!`
  }
  moveUp() {
    this.element.classButon.add('transform', 'translate-y-[-10px]')
  }

  moveDown() {
    this.element.classList.remove('transform', 'translate-y-[-10px]')
  }
}
