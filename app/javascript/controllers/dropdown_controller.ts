import { Controller } from "@hotwired/stimulus"
import hotkeys from "hotkeys-js"

export default class extends Controller {

  static targets = ["dropdown"]

  readonly dropdownTarget!: HTMLElement

  connect() {
    // @ts-ignore
    hotkeys("escape", (event) => {
      event.preventDefault()
      this.close()
    })
  }

  toggle() {
    console.log("hit")
    this.dropdownTarget.classList.toggle("hidden")
  }

  close() {
    this.dropdownTarget.classList.add("hidden")
  }
}
