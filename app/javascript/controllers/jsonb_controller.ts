import { Controller } from "@hotwired/stimulus"
import { Typed } from "stimulus-typescript"

const targets = {
  input: HTMLInputElement,
  result: HTMLInputElement
}

export default class extends Typed(Controller, { targets }) {
  jsonResult: object = {}

  inputTargetConnected(e: typeof targets["input"]["prototype"]) {
    this.jsonResult[e.id] = e.value
    e.addEventListener("input", () => this.handleInput(e.id, e.value))
  }

  handleInput(fieldName: string, value: string) {
    this.jsonResult[fieldName] = value
    this.resultTarget.value = JSON.stringify(this.jsonResult)
  }
}

