import { Controller } from "@hotwired/stimulus"
export default class extends Controller {
    static targets = []
    comfortable(e){ this.setDensity(e, "is-comfortable") }
    compact(e){ this.setDensity(e, "is-compact") }
    setDensity(e, klass){
        const table = this.element.closest(".table-card").querySelector(".data-table")
        if (!table) return
        table.classList.remove("is-comfortable","is-compact")
        table.classList.add(klass)
        this.element.querySelectorAll("button").forEach(b=>b.classList.remove("is-active"))
        e.currentTarget.classList.add("is-active")
    }
}