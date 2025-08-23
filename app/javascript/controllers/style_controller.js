// app/javascript/controllers/dashboard_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ['sidebarLink', 'navItem', 'kpiCard', 'liveIndicator', 'tableRow']

    connect() {
        this.animateKpiCards()
        this.startLiveUpdates()
    }

    disconnect() {
        if (this.liveUpdateInterval) {
            clearInterval(this.liveUpdateInterval)
        }
    }

    // Sidebar Navigation
    selectSidebarItem(event) {
        this.sidebarLinkTargets.forEach(link => link.classList.remove("active"))
        event.currentTarget.classList.add("active")
    }

    // Top Navigation
    selectNavItem(event) {
        event.preventDefault()
        // Remove active class from all nav items
        this.navItemTargets.forEach(item => item.classList.remove('active'))
        // Add active class to clicked item
        event.currentTarget.classList.add('active')
    }

    // Table Row Selection
    selectTableRow(event) {
        const orderNumber = event.currentTarget.cells[0].textContent
        console.log('Auftrag ausgewählt:', orderNumber)

        // Visual feedback for selected row
        this.tableRowTargets.forEach(row => row.classList.remove('selected'))
        event.currentTarget.classList.add('selected')
    }

    // KPI Cards Animation
    animateKpiCards() {
        this.kpiCardTargets.forEach((card, index) => {
            setTimeout(() => {
                card.style.opacity = '0'
                card.style.transform = 'translateY(20px)'
                card.style.transition = 'all 0.6s ease'

                setTimeout(() => {
                    card.style.opacity = '1'
                    card.style.transform = 'translateY(0)'
                }, 100)
            }, index * 150)
        })
    }

    // Live Updates Simulation
    startLiveUpdates() {
        this.liveUpdateInterval = setInterval(() => {
            if (this.hasLiveIndicatorTarget) {
                this.liveIndicatorTarget.style.animation = 'none'
                setTimeout(() => {
                    this.liveIndicatorTarget.style.animation = 'pulse 2s infinite'
                }, 100)
            }
        }, 8000)
    }

    // Button Actions
    exportData() {
        alert('Export-Funktion würde hier implementiert werden')
        // Hier würdest du z.B. einen AJAX-Call machen:
        // fetch('/dashboard/export', { method: 'POST' })
    }

    createNewEntry() {
        alert('Neuer Eintrag - Modal oder neue Seite würde hier geöffnet')
        // Hier könntest du z.B. ein Turbo Frame laden:
        // Turbo.visit('/entries/new')
    }

    createNewOrder() {
        alert('Neuer Auftrag - Weiterleitung zur Auftragserstellung')
        // Hier könntest du z.B. zu einer neuen Seite navigieren:
        // Turbo.visit('/orders/new')
    }
}

