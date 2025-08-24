class AbsicherungAltSchema < ActiveRecord::Migration[8.0]
  def change
    add_foreign_key :addresses, :customers, column: :nummer, primary_key: :kundennr

    add_check_constraint :addresses,  "art IN ('K','L','S') OR art IS NULL",                           name: "chk_addresses_art"
    add_check_constraint :customers,  "umsatzsteuer IN ('J','N') OR umsatzsteuer IS NULL",             name: "chk_customers_umsatzsteuer"
    add_check_constraint :customers,  "gekuendigt   IN ('J','N') OR gekuendigt   IS NULL",             name: "chk_customers_gekuendigt"
    add_check_constraint :addresses,  "erledigt IN (0,1) OR erledigt IS NULL",                         name: "chk_addresses_erledigt"

    add_index :addresses, :art,       name: "idx_addresses_art"
    add_index :addresses, :erledigt,  name: "idx_addresses_erledigt"
    add_index :customers, :kundgruppe, name: "idx_customers_kundgruppe"
    add_index :customers, :bundesland, name: "idx_customers_bundesland"
  end
end
