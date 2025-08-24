// app/javascript/layout_helpers.js

// Theme Icons Toggle Management
class ThemeIconsManager {
    constructor() {
        this.init();
    }

    init() {
        document.addEventListener('DOMContentLoaded', () => {
            this.setupThemeIcons();
        });
    }

    setupThemeIcons() {
        const themeToggle = document.querySelector('.theme-toggle');
        if (!themeToggle) return;

        const sunIcon = themeToggle.querySelector('.sun-icon');
        const moonIcon = themeToggle.querySelector('.moon-icon');

        if (!sunIcon || !moonIcon) return;

        const updateThemeIcons = () => {
            const isDark = document.documentElement.getAttribute('data-theme') === 'dark';
            if (isDark) {
                sunIcon.style.display = 'none';
                moonIcon.style.display = 'block';
            } else {
                sunIcon.style.display = 'block';
                moonIcon.style.display = 'none';
            }
        };

        // Initial update
        updateThemeIcons();

        // Listen for theme changes
        const observer = new MutationObserver(updateThemeIcons);
        observer.observe(document.documentElement, {
            attributes: true,
            attributeFilter: ['data-theme']
        });
    }
}

// Scroll to Top Button Management
class ScrollToTopManager {
    constructor() {
        this.init();
    }

    init() {
        this.setupScrollButton();
    }

    setupScrollButton() {
        window.addEventListener('scroll', () => {
            const scrollBtn = document.querySelector('.scroll-to-top');
            if (!scrollBtn) return;

            if (window.pageYOffset > 100) {
                scrollBtn.style.display = 'flex';
            } else {
                scrollBtn.style.display = 'none';
            }
        });
    }
}

// Loading Overlay Management for Turbo
class LoadingManager {
    constructor() {
        this.init();
    }

    init() {
        this.setupTurboLoadingStates();
    }

    setupTurboLoadingStates() {
        // Show loading on Turbo requests
        document.addEventListener('turbo:before-fetch-request', () => {
            document.body.classList.add('loading');
        });

        // Hide loading when frame renders
        document.addEventListener('turbo:before-frame-render', () => {
            document.body.classList.remove('loading');
        });

        // Hide loading when page loads
        document.addEventListener('turbo:load', () => {
            document.body.classList.remove('loading');
        });

        // Fallback: Hide loading after a reasonable timeout
        document.addEventListener('turbo:before-fetch-request', () => {
            setTimeout(() => {
                document.body.classList.remove('loading');
            }, 10000); // 10 seconds timeout
        });
    }
}

// Keyboard Shortcuts Manager
class KeyboardShortcutsManager {
    constructor() {
        this.init();
    }

    init() {
        this.setupGlobalShortcuts();
    }

    setupGlobalShortcuts() {
        document.addEventListener('keydown', (event) => {
            // Ctrl/Cmd + K for search focus
            if ((event.ctrlKey || event.metaKey) && event.key === 'k') {
                event.preventDefault();
                const searchInput = document.querySelector('[data-layout-target="searchInput"]');
                if (searchInput) {
                    searchInput.focus();
                    searchInput.select();
                }
            }

            // Ctrl/Cmd + B for sidebar toggle
            if ((event.ctrlKey || event.metaKey) && event.key === 'b') {
                event.preventDefault();
                const layoutController = this.getLayoutController();
                if (layoutController) {
                    layoutController.toggleSidebar();
                }
            }

            // Ctrl/Cmd + Shift + T for theme toggle
            if ((event.ctrlKey || event.metaKey) && event.shiftKey && event.key === 'T') {
                event.preventDefault();
                const layoutController = this.getLayoutController();
                if (layoutController) {
                    layoutController.toggleTheme();
                }
            }
        });
    }

    getLayoutController() {
        const layoutElement = document.querySelector('[data-controller*="layout"]');
        if (layoutElement && layoutElement.layoutController) {
            return layoutElement.layoutController;
        }
        return null;
    }
}

// Responsive Utilities
class ResponsiveManager {
    constructor() {
        this.breakpoints = {
            mobile: 768,
            tablet: 1024,
            desktop: 1200
        };
        this.init();
    }

    init() {
        this.setupResizeHandler();
    }

    setupResizeHandler() {
        let resizeTimeout;
        window.addEventListener('resize', () => {
            clearTimeout(resizeTimeout);
            resizeTimeout = setTimeout(() => {
                this.handleResize();
            }, 100);
        });

        // Initial check
        this.handleResize();
    }

    handleResize() {
        const width = window.innerWidth;

        // Update CSS custom properties for JavaScript access
        document.documentElement.style.setProperty('--window-width', `${width}px`);

        // Add responsive classes to body
        document.body.classList.toggle('is-mobile', width < this.breakpoints.mobile);
        document.body.classList.toggle('is-tablet',
            width >= this.breakpoints.mobile && width < this.breakpoints.desktop);
        document.body.classList.toggle('is-desktop', width >= this.breakpoints.desktop);
    }

    isMobile() {
        return window.innerWidth < this.breakpoints.mobile;
    }

    isTablet() {
        return window.innerWidth >= this.breakpoints.mobile &&
            window.innerWidth < this.breakpoints.desktop;
    }

    isDesktop() {
        return window.innerWidth >= this.breakpoints.desktop;
    }
}

// Performance Monitor (optional, for development)
class PerformanceMonitor {
    constructor() {
        this.init();
    }

    init() {
        if (this.isDevelopment()) {
            this.setupPerformanceTracking();
        }
    }

    isDevelopment() {
        return window.location.hostname === 'localhost' ||
            window.location.hostname === '127.0.0.1' ||
            window.location.search.includes('debug=true');
    }

    setupPerformanceTracking() {
        // Track page load times
        window.addEventListener('load', () => {
            const perfData = performance.timing;
            const pageLoadTime = perfData.loadEventEnd - perfData.navigationStart;
            console.log(`Page load time: ${pageLoadTime}ms`);
        });

        // Track Turbo navigation
        document.addEventListener('turbo:load', () => {
            const navigationEntry = performance.getEntriesByType('navigation')[0];
            if (navigationEntry) {
                console.log(`Turbo navigation time: ${navigationEntry.duration}ms`);
            }
        });
    }
}

// Accessibility Helpers
class AccessibilityManager {
    constructor() {
        this.init();
    }

    init() {
        this.setupAccessibilityFeatures();
    }

    setupAccessibilityFeatures() {
        // Focus trap for modals
        this.setupFocusTrap();

        // Skip links
        this.setupSkipLinks();

        // ARIA live regions
        this.setupLiveRegions();
    }

    setupFocusTrap() {
        document.addEventListener('keydown', (event) => {
            if (event.key === 'Tab') {
                const modal = document.querySelector('.modal.show, .dropdown-menu.show');
                if (modal) {
                    this.trapFocus(event, modal);
                }
            }
        });
    }

    trapFocus(event, container) {
        const focusableElements = container.querySelectorAll(
            'button:not([disabled]), [href], input:not([disabled]), select:not([disabled]), textarea:not([disabled]), [tabindex]:not([tabindex="-1"]):not([disabled])'
        );

        const firstElement = focusableElements[0];
        const lastElement = focusableElements[focusableElements.length - 1];

        if (event.shiftKey && document.activeElement === firstElement) {
            lastElement.focus();
            event.preventDefault();
        } else if (!event.shiftKey && document.activeElement === lastElement) {
            firstElement.focus();
            event.preventDefault();
        }
    }

    setupSkipLinks() {
        const skipLink = document.querySelector('.skip-link');
        if (skipLink) {
            skipLink.addEventListener('click', (event) => {
                event.preventDefault();
                const target = document.querySelector(skipLink.getAttribute('href'));
                if (target) {
                    target.focus();
                    target.scrollIntoView();
                }
            });
        }
    }

    setupLiveRegions() {
        // Create live region for dynamic announcements
        if (!document.querySelector('#live-region')) {
            const liveRegion = document.createElement('div');
            liveRegion.id = 'live-region';
            liveRegion.setAttribute('aria-live', 'polite');
            liveRegion.setAttribute('aria-atomic', 'true');
            liveRegion.style.cssText = 'position: absolute; left: -10000px; width: 1px; height: 1px; overflow: hidden;';
            document.body.appendChild(liveRegion);
        }
    }

    announce(message) {
        const liveRegion = document.querySelector('#live-region');
        if (liveRegion) {
            liveRegion.textContent = message;
        }
    }
}

// Initialize all managers
document.addEventListener('DOMContentLoaded', () => {
    new ThemeIconsManager();
    new ScrollToTopManager();
    new LoadingManager();
    new KeyboardShortcutsManager();
    new ResponsiveManager();
    new PerformanceMonitor();
    new AccessibilityManager();
});

// Export for use in other modules
export {
    ThemeIconsManager,
    ScrollToTopManager,
    LoadingManager,
    KeyboardShortcutsManager,
    ResponsiveManager,
    PerformanceMonitor,
    AccessibilityManager
};