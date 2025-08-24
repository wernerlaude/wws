// app/javascript/controllers/layout_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = [
        'sidebar',
        'content',
        'toggleButton',
        'overlay',
        'dropdownMenu',
        'notification',
        'header',
        'footer',
        'searchInput',
        'mobileMenu',
        'sidebarLink',
        'navItem',
        'kpiCard',
        'liveIndicator',
        'tableRow'
    ]

    static values = {
        sidebarCollapsed: Boolean,
        theme: String
    }

    connect() {
        this.initializeLayout()
        this.setupEventListeners()
        this.loadUserPreferences()
        this.animateKpiCards()
        this.startLiveUpdates()
    }

    disconnect() {
        this.cleanup()
        if (this.liveUpdateInterval) {
            clearInterval(this.liveUpdateInterval)
        }
    }

    // Layout Initialization
    initializeLayout() {
        // Set initial sidebar state
        if (this.sidebarCollapsedValue) {
            this.collapseSidebar()
        }

        // Apply theme
        if (this.themeValue) {
            document.documentElement.setAttribute('data-theme', this.themeValue)
        }

        // Initialize responsive behavior
        this.checkScreenSize()
    }

    // Event Listeners Setup
    setupEventListeners() {
        // Window resize listener
        this.resizeHandler = this.handleResize.bind(this)
        window.addEventListener('resize', this.resizeHandler)

        // Click outside listener for dropdowns
        this.outsideClickHandler = this.handleOutsideClick.bind(this)
        document.addEventListener('click', this.outsideClickHandler)

        // Escape key listener
        this.escapeHandler = this.handleEscape.bind(this)
        document.addEventListener('keydown', this.escapeHandler)
    }

    // Cleanup
    cleanup() {
        window.removeEventListener('resize', this.resizeHandler)
        document.removeEventListener('click', this.outsideClickHandler)
        document.removeEventListener('keydown', this.escapeHandler)
    }

    // Sidebar Management
    toggleSidebar() {
        if (this.sidebarCollapsedValue) {
            this.expandSidebar()
        } else {
            this.collapseSidebar()
        }
        this.saveSidebarState()
    }

    collapseSidebar() {
        if (this.hasSidebarTarget) {
            this.sidebarTarget.classList.add('collapsed')
            this.sidebarCollapsedValue = true

            // Adjust content margin
            if (this.hasContentTarget) {
                this.contentTarget.classList.add('sidebar-collapsed')
            }

            // Update toggle button
            if (this.hasToggleButtonTarget) {
                this.toggleButtonTarget.classList.add('collapsed')
            }
        }
    }

    expandSidebar() {
        if (this.hasSidebarTarget) {
            this.sidebarTarget.classList.remove('collapsed')
            this.sidebarCollapsedValue = false

            // Adjust content margin
            if (this.hasContentTarget) {
                this.contentTarget.classList.remove('sidebar-collapsed')
            }

            // Update toggle button
            if (this.hasToggleButtonTarget) {
                this.toggleButtonTarget.classList.remove('collapsed')
            }
        }
    }

    // Mobile Menu Management
    toggleMobileMenu() {
        if (this.hasMobileMenuTarget) {
            this.mobileMenuTarget.classList.toggle('open')

            // Toggle overlay
            if (this.hasOverlayTarget) {
                this.overlayTarget.classList.toggle('show')
            }

            // Prevent body scroll
            document.body.classList.toggle('menu-open')
        }
    }

    closeMobileMenu() {
        if (this.hasMobileMenuTarget) {
            this.mobileMenuTarget.classList.remove('open')

            if (this.hasOverlayTarget) {
                this.overlayTarget.classList.remove('show')
            }

            document.body.classList.remove('menu-open')
        }
    }

    // Dropdown Management
    toggleDropdown(event) {
        event.stopPropagation()
        const dropdown = event.currentTarget.querySelector('[data-layout-target="dropdownMenu"]')

        if (dropdown) {
            // Close other dropdowns first
            this.closeAllDropdowns()

            // Toggle current dropdown
            dropdown.classList.toggle('show')
        }
    }

    closeAllDropdowns() {
        this.dropdownMenuTargets.forEach(dropdown => {
            dropdown.classList.remove('show')
        })
    }

    // Theme Management (erweitert)
    toggleTheme() {
        const currentTheme = this.themeValue || 'light'
        const newTheme = currentTheme === 'light' ? 'dark' : 'light'

        this.themeValue = newTheme
        document.documentElement.setAttribute('data-theme', newTheme)

        // Save theme preference
        this.saveThemePreference(newTheme)

        // Announce theme change for accessibility
        this.announceChange(`Theme changed to ${newTheme} mode`)
    }

    setTheme(theme) {
        this.themeValue = theme
        document.documentElement.setAttribute('data-theme', theme)
        this.saveThemePreference(theme)
    }

    // Search Functionality
    handleSearch(event) {
        if (event.key === 'Enter') {
            const query = event.target.value.trim()
            if (query) {
                this.performSearch(query)
            }
        }
    }

    performSearch(query) {
        // Hier würdest du die Suchlogik implementieren
        console.log('Suche nach:', query)

        // Beispiel: Turbo Frame Update oder AJAX Call
        // fetch(`/search?q=${encodeURIComponent(query)}`)
        //     .then(response => response.text())
        //     .then(html => {
        //         // Update search results
        //     })
    }

    clearSearch() {
        if (this.hasSearchInputTarget) {
            this.searchInputTarget.value = ''
            this.searchInputTarget.focus()
        }
    }

    // Notification Management
    showNotification(message, type = 'info', duration = 5000) {
        if (this.hasNotificationTarget) {
            this.notificationTarget.textContent = message
            this.notificationTarget.className = `notification ${type} show`

            // Auto-hide notification
            setTimeout(() => {
                this.hideNotification()
            }, duration)
        }
    }

    hideNotification() {
        if (this.hasNotificationTarget) {
            this.notificationTarget.classList.remove('show')
        }
    }

    // Responsive Behavior
    handleResize() {
        this.checkScreenSize()
    }

    checkScreenSize() {
        const isMobile = window.innerWidth < 768
        const isTablet = window.innerWidth >= 768 && window.innerWidth < 1024

        if (isMobile) {
            // Force sidebar collapse on mobile
            this.collapseSidebar()
            this.closeMobileMenu()
        } else if (isTablet) {
            // Optional: Different behavior for tablets
            this.closeMobileMenu()
        }
    }

    // Event Handlers
    handleOutsideClick(event) {
        // Close dropdowns when clicking outside
        if (!event.target.closest('[data-layout-target="dropdownMenu"]') &&
            !event.target.closest('[data-action*="toggleDropdown"]')) {
            this.closeAllDropdowns()
        }

        // Close mobile menu when clicking overlay
        if (event.target === this.overlayTarget) {
            this.closeMobileMenu()
        }
    }

    handleEscape(event) {
        if (event.key === 'Escape') {
            this.closeAllDropdowns()
            this.closeMobileMenu()
        }
    }

    // User Preferences
    loadUserPreferences() {
        // Load sidebar state
        const savedSidebarState = localStorage.getItem('sidebar-collapsed')
        if (savedSidebarState === 'true') {
            this.sidebarCollapsedValue = true
            this.collapseSidebar()
        }

        // Load theme preference
        const savedTheme = localStorage.getItem('user-theme') || 'light'
        this.setTheme(savedTheme)
    }

    saveSidebarState() {
        localStorage.setItem('sidebar-collapsed', this.sidebarCollapsedValue)
    }

    saveThemePreference(theme) {
        localStorage.setItem('user-theme', theme)
    }

    // Fullscreen Management
    toggleFullscreen() {
        if (!document.fullscreenElement) {
            document.documentElement.requestFullscreen()
        } else {
            document.exitFullscreen()
        }
    }

    // Utility Methods (erweitert)
    scrollToTop() {
        window.scrollTo({
            top: 0,
            behavior: 'smooth'
        })
    }

    // Accessibility Helper
    announceChange(message) {
        const liveRegion = document.querySelector('#live-region')
        if (liveRegion) {
            liveRegion.textContent = message
        }
    }

    // Get responsive state
    getResponsiveState() {
        const width = window.innerWidth
        if (width < 768) return 'mobile'
        if (width < 1024) return 'tablet'
        return 'desktop'
    }

    // Loading State Management
    showLoading() {
        document.body.classList.add('loading')
    }

    hideLoading() {
        document.body.classList.remove('loading')
    }

    // Focus Management
    trapFocus(element) {
        const focusableElements = element.querySelectorAll(
            'button, [href], input, select, textarea, [tabindex]:not([tabindex="-1"])'
        )

        if (focusableElements.length > 0) {
            focusableElements[0].focus()
        }
    }

    // ===========================================
    // DASHBOARD SPECIFIC METHODS (from style_controller.js)
    // ===========================================

    // Sidebar Navigation (erweitert)
    selectSidebarItem(event) {
        // Don't prevent default for actual navigation links
        const link = event.currentTarget
        const href = link.getAttribute('href')

        // If it's a hash link (like #analytics), prevent default and handle locally
        if (href.startsWith('#')) {
            event.preventDefault()

            // Update active states for hash links only
            this.sidebarLinkTargets.forEach(sidebarLink => {
                if (sidebarLink.getAttribute('href').startsWith('#')) {
                    sidebarLink.classList.remove("active")
                }
            })
            event.currentTarget.classList.add("active")

            // Optional: Handle hash navigation
            const targetId = href.substring(1)
            const targetElement = document.getElementById(targetId)
            if (targetElement) {
                targetElement.scrollIntoView({ behavior: 'smooth' })
            }
        }
        // For real links (like customers_path), let them navigate normally
        // The server-side will handle the active state via Rails helpers
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
        if (this.hasKpiCardTarget) {
            this.kpiCardTargets.forEach((card, index) => {
                setTimeout(() => {
                    // Use CSS classes instead of inline styles
                    card.classList.add('kpi-card-animate-start')

                    setTimeout(() => {
                        card.classList.remove('kpi-card-animate-start')
                        card.classList.add('kpi-card-animate-end')
                    }, 100)
                }, index * 150)
            })
        }
    }

    // Live Updates Simulation
    startLiveUpdates() {
        this.liveUpdateInterval = setInterval(() => {
            if (this.hasLiveIndicatorTarget) {
                // Use CSS classes instead of inline styles
                this.liveIndicatorTarget.classList.remove('pulse-animation')
                setTimeout(() => {
                    this.liveIndicatorTarget.classList.add('pulse-animation')
                }, 100)
            }
        }, 8000)
    }

    // Dashboard Button Actions
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