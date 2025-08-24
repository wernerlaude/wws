# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true

# Pin all controllers
pin_all_from "app/javascript/controllers", under: "controllers"

# Custom layout helpers
pin "layout_helpers", to: "layout_helpers.js", preload: true

