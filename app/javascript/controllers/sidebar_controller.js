import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="sidebar"
export default class extends Controller {
  static targets = ["mainContent"]

  toggle() {
    this.element.classList.toggle("show")
    this.mainContentTarget.classList.toggle("shifted")
  }
}
