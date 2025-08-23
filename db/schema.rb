# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_08_23_183343) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "addresses", primary_key: "nummer", id: :integer, default: nil, force: :cascade do |t|
    t.string "name1", limit: 30
    t.string "name2", limit: 30
    t.string "branche", limit: 40
    t.string "strasse", limit: 42
    t.string "nat", limit: 3
    t.string "plz", limit: 10
    t.string "ort", limit: 40
    t.string "postfach", limit: 10
    t.string "postfplz", limit: 8
    t.string "postfort", limit: 30
    t.string "telefon1", limit: 20
    t.string "telefon2", limit: 20
    t.string "telefax", limit: 20
    t.string "land", limit: 40
    t.string "anrede", limit: 15
    t.string "briefanr", limit: 50
    t.string "art", limit: 1
    t.integer "knr"
    t.integer "frei1", limit: 2
    t.integer "frei2", limit: 2
    t.string "frei3", limit: 10
    t.string "frei4", limit: 30
    t.string "trans", limit: 1
    t.string "email", limit: 255
    t.string "homepage", limit: 60
    t.string "trfield", limit: 1
    t.integer "repl_id"
    t.integer "repl_database"
    t.string "lname1", limit: 100
    t.string "lname2", limit: 100
    t.string "lbranche", limit: 100
    t.integer "erledigt"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.index ["art"], name: "idx_addresses_art"
    t.index ["erledigt"], name: "idx_addresses_erledigt"
    t.check_constraint "(art::text = ANY (ARRAY['K'::character varying, 'L'::character varying, 'S'::character varying]::text[])) OR art IS NULL", name: "chk_addresses_art"
    t.check_constraint "(erledigt = ANY (ARRAY[0, 1])) OR erledigt IS NULL", name: "chk_addresses_erledigt"
  end

  create_table "customers", primary_key: "kundennr", id: :integer, default: nil, force: :cascade do |t|
    t.integer "kundgruppe"
    t.integer "bundesland"
    t.string "kontoauszug", limit: 1
    t.datetime "datumlauszug", precision: nil
    t.integer "nrlauszug"
    t.float "saldolauszug"
    t.string "saldorechnung", limit: 1
    t.integer "lfdrechnnr"
    t.integer "rechnkunde"
    t.string "umsatzsteuer", limit: 1
    t.string "werbetext", limit: 1
    t.string "rechnformular", limit: 8
    t.float "rabatt"
    t.string "zahlungart", limit: 1
    t.integer "zinstabsoll"
    t.integer "zinstabhaben"
    t.float "zinssatzsoll"
    t.float "zinssatzhaben"
    t.string "zinsbuchung", limit: 1
    t.datetime "datumlzinsabr", precision: nil
    t.float "saldolzinsabr"
    t.string "selbstabhrabatt", limit: 12
    t.float "selbstabhbetrag"
    t.string "bonusberecht", limit: 1
    t.integer "mitgliednr"
    t.integer "geschkonto"
    t.string "gekuendigt", limit: 1
    t.string "kuendgrund", limit: 30
    t.datetime "datumeintritt", precision: nil
    t.datetime "datumaustritt", precision: nil
    t.integer "pflichtanteile"
    t.integer "pflichtanteilegez"
    t.integer "anteilgekuend1"
    t.datetime "datumkuend1", precision: nil
    t.integer "anteilgekuend2"
    t.datetime "datumkuend2", precision: nil
    t.string "trans", limit: 1
    t.string "trfield", limit: 1
    t.integer "repl_id"
    t.integer "repl_database"
    t.string "organschaft", limit: 1
    t.string "bemerkford", limit: 1
    t.string "kontoauszug2", limit: 1
    t.integer "rechnanzahl"
    t.float "nk_stdsatz"
    t.float "nk_fahrtkosten"
    t.string "offeneposten", limit: 1
    t.float "regalflaeche"
    t.string "fremdwaehrung", limit: 3
    t.string "konzernkunde", limit: 1
    t.float "gk_aufschlag"
    t.float "ernte_mitglbeitrag"
    t.integer "kreditorkto2"
    t.integer "rabstnr_ls"
    t.string "formular_ls", limit: 12
    t.string "versandspesen", limit: 1
    t.string "zert_pflicht", limit: 1
    t.datetime "zert_datum", precision: nil
    t.string "formular_stang", limit: 12
    t.string "formular_stauf", limit: 12
    t.string "lieferbedkurz", limit: 5
    t.string "zahlbedtext", limit: 80
    t.string "zbabdatum", limit: 1
    t.integer "versandavis"
    t.float "proforma_rabatt1"
    t.float "proforma_rabatt2"
    t.datetime "versandavisdatum", precision: nil
    t.integer "zb_id"
    t.integer "zb_dbid"
    t.string "formular_ernte1", limit: 12
    t.string "formular_ernte2", limit: 12
    t.string "formular_ernte3", limit: 12
    t.integer "versandaviseinzel"
    t.string "versandavisvb", limit: 1
    t.float "vkpreiszuschlagek"
    t.datetime "vkpreiszuschldatum", precision: nil
    t.integer "landwamtnr"
    t.string "lwa_betriebsnr", limit: 20
    t.string "kontoauszug1", limit: 1
    t.integer "kundennrschnittst"
    t.string "edi_iln", limit: 15
    t.integer "edi_typ"
    t.integer "edi_uebertrnr"
    t.string "edi_prefix", limit: 15
    t.string "rechnsammelliste", limit: 1
    t.float "marge"
    t.string "edi_iln_nad_su", limit: 15
    t.integer "g12_statistik"
    t.string "kundstatusw", limit: 1
    t.string "versicherung", limit: 1
    t.float "versprozent"
    t.float "schwellenwert"
    t.string "gutschrverr", limit: 1
    t.float "rechnlistenprov"
    t.integer "liefbewertung_basis"
    t.integer "andavisexport"
    t.integer "sprachenr"
    t.string "nabizertstelleregnr", limit: 40
    t.string "bruttoberechn", limit: 1
    t.integer "tankrechnungpdf"
    t.string "zblieferdat", limit: 1
    t.integer "preisqzuabsortenr"
    t.float "minbestellwert"
    t.float "vkbonus"
    t.integer "mvo_ek_kennz"
    t.integer "mvo_vk_kennz"
    t.string "vertrbeauf1keineprov", limit: 1
    t.string "vertrbeauf2keineprov", limit: 1
    t.string "formular_wiegeschein", limit: 12
    t.integer "edi_kostenst"
    t.integer "anzdruckliefersch"
    t.string "sknpflschg", limit: 1
    t.string "kundennrdeuka", limit: 15
    t.string "edi_keinstorno", limit: 1
    t.string "selbstabrechner", limit: 1
    t.string "edi_kundennr", limit: 70
    t.integer "edi_typorders"
    t.integer "edi_typdesadv"
    t.integer "edi_uebertrnr_desadv"
    t.string "formular_nve", limit: 12
    t.string "explosivnachweis", limit: 1
    t.string "edi_iln_desadv", limit: 15
    t.integer "kontraktzusammenstellung"
    t.integer "id_unternehmensgegenstand"
    t.integer "dbid_unternehmensgegenstand"
    t.datetime "explosivnachweisdatum", precision: nil
    t.datetime "geaendertam", precision: nil
    t.integer "edi_abkommensnr"
    t.string "selbstabrechnerek", limit: 1
    t.string "formular_etikett", limit: 12
    t.integer "creditreform_status"
    t.datetime "creditreform_timestamp", precision: nil
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["bundesland"], name: "idx_customers_bundesland"
    t.index ["kundgruppe"], name: "idx_customers_kundgruppe"
    t.check_constraint "(gekuendigt::text = ANY (ARRAY['J'::character varying, 'N'::character varying]::text[])) OR gekuendigt IS NULL", name: "chk_customers_gekuendigt"
    t.check_constraint "(umsatzsteuer::text = ANY (ARRAY['J'::character varying, 'N'::character varying]::text[])) OR umsatzsteuer IS NULL", name: "chk_customers_umsatzsteuer"
  end

  create_table "delivery_note_line_items", id: false, force: :cascade do |t|
    t.integer "delivery_note_id", null: false
    t.integer "position_number", null: false
    t.string "position_type", limit: 1, default: "N"
    t.string "article_number", limit: 12
    t.string "description1", limit: 40
    t.string "description2", limit: 40
    t.text "long_text"
    t.integer "sales_order_id"
    t.integer "sales_order_position_number"
    t.integer "warehouse"
    t.integer "department"
    t.float "delivered_quantity", default: 0.0, null: false
    t.integer "unit_key"
    t.string "unit", limit: 5
    t.decimal "unit_price", precision: 10, scale: 4, null: false
    t.decimal "list_price", precision: 10, scale: 4
    t.float "discount_percent", default: 0.0
    t.string "discount_type", limit: 3
    t.float "vat_rate", default: 19.0
    t.decimal "net_amount", precision: 10, scale: 2, default: "0.0"
    t.decimal "vat_amount", precision: 10, scale: 2, default: "0.0"
    t.decimal "gross_amount", precision: 10, scale: 2, default: "0.0"
    t.float "weight", default: 0.0
    t.integer "contract_number"
    t.integer "contract_position"
    t.string "sales_rep", limit: 5
    t.text "loading_info"
    t.index ["article_number"], name: "index_delivery_note_line_items_on_article_number"
    t.index ["contract_number"], name: "index_delivery_note_line_items_on_contract_number"
    t.index ["delivery_note_id", "position_number"], name: "idx_delivery_note_line_items_pk", unique: true
    t.index ["delivery_note_id"], name: "index_delivery_note_line_items_on_delivery_note_id"
    t.index ["department"], name: "index_delivery_note_line_items_on_department"
    t.index ["sales_order_id"], name: "index_delivery_note_line_items_on_sales_order_id"
    t.index ["sales_rep"], name: "index_delivery_note_line_items_on_sales_rep"
    t.index ["warehouse"], name: "index_delivery_note_line_items_on_warehouse"
  end

  create_table "delivery_notes", id: :serial, force: :cascade do |t|
    t.date "delivery_date", null: false
    t.string "operator", limit: 5
    t.string "sales_rep", limit: 5
    t.string "customer_name", limit: 30
    t.string "customer_order_number", limit: 50
    t.string "delivery_terms", limit: 80
    t.string "project", limit: 80
    t.string "delivery_type", limit: 40
    t.boolean "self_pickup", default: false
    t.boolean "printed", default: false
    t.integer "invoice_number"
    t.integer "warehouse"
    t.integer "truck_number"
    t.string "vehicle", limit: 22
    t.string "license_plate1", limit: 12
    t.string "license_plate2", limit: 12
    t.string "time", limit: 5
    t.decimal "net_amount", precision: 10, scale: 2, default: "0.0"
    t.decimal "gross_amount", precision: 10, scale: 2, default: "0.0"
    t.text "delivery_info"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.bigint "sales_order_id"
    t.bigint "customer_id"
    t.bigint "customer_address_id"
    t.bigint "billing_address_id"
    t.bigint "shipping_address_id"
    t.index ["billing_address_id"], name: "index_delivery_notes_on_billing_address_id"
    t.index ["customer_address_id"], name: "index_delivery_notes_on_customer_address_id"
    t.index ["customer_id"], name: "index_delivery_notes_on_customer_id"
    t.index ["delivery_date"], name: "index_delivery_notes_on_delivery_date"
    t.index ["invoice_number"], name: "index_delivery_notes_on_invoice_number"
    t.index ["operator"], name: "index_delivery_notes_on_operator"
    t.index ["printed"], name: "index_delivery_notes_on_printed"
    t.index ["sales_order_id"], name: "index_delivery_notes_on_sales_order_id"
    t.index ["self_pickup"], name: "index_delivery_notes_on_self_pickup"
    t.index ["shipping_address_id"], name: "index_delivery_notes_on_shipping_address_id"
    t.index ["updated_at"], name: "index_delivery_notes_on_updated_at"
  end

  create_table "sales_order_line_items", id: false, force: :cascade do |t|
    t.integer "sales_order_id", null: false
    t.integer "position_number", null: false
    t.string "position_type", limit: 1, default: "N"
    t.string "article_number", limit: 12
    t.string "description1", limit: 40
    t.string "description2", limit: 40
    t.text "long_text"
    t.string "article_type", limit: 4
    t.integer "sales_group"
    t.integer "warehouse"
    t.integer "department"
    t.float "quantity", null: false
    t.integer "unit_key"
    t.string "unit", limit: 5
    t.decimal "unit_price", precision: 10, scale: 4, null: false
    t.decimal "gross_price", precision: 10, scale: 4
    t.decimal "list_price", precision: 10, scale: 4
    t.float "discount_percent", default: 0.0
    t.string "discount_type", limit: 3
    t.float "vat_rate", default: 19.0
    t.decimal "net_amount", precision: 10, scale: 2
    t.decimal "vat_amount", precision: 10, scale: 2
    t.decimal "gross_amount", precision: 10, scale: 2
    t.float "weight", default: 0.0
    t.boolean "commission", default: false
    t.boolean "foreign_goods", default: false
    t.integer "contract_number"
    t.integer "contract_position"
    t.string "sales_rep", limit: 5
    t.text "comment"
    t.index ["article_number"], name: "index_sales_order_line_items_on_article_number"
    t.index ["contract_number"], name: "index_sales_order_line_items_on_contract_number"
    t.index ["department"], name: "index_sales_order_line_items_on_department"
    t.index ["sales_order_id", "position_number"], name: "idx_sales_order_line_items_pk", unique: true
    t.index ["sales_order_id"], name: "index_sales_order_line_items_on_sales_order_id"
    t.index ["sales_rep"], name: "index_sales_order_line_items_on_sales_rep"
    t.index ["warehouse"], name: "index_sales_order_line_items_on_warehouse"
  end

  create_table "sales_orders", id: :serial, force: :cascade do |t|
    t.date "order_date", null: false
    t.string "operator", limit: 5
    t.string "sales_rep", limit: 5
    t.string "status", limit: 1
    t.boolean "completed", default: false
    t.string "customer_name", limit: 30
    t.string "customer_order_number", limit: 50
    t.string "customer_department", limit: 30
    t.string "delivery_terms", limit: 80
    t.string "project", limit: 80
    t.string "delivery_type", limit: 40
    t.integer "currency_code"
    t.integer "vat_code"
    t.integer "discount1_days"
    t.float "discount1_percent"
    t.integer "discount2_days"
    t.float "discount2_percent"
    t.integer "net_days"
    t.date "due_date"
    t.string "payment_terms_text", limit: 80
    t.integer "warehouse"
    t.boolean "self_pickup", default: false
    t.string "delivery_terms_short", limit: 5
    t.date "planned_delivery_date"
    t.string "reference", limit: 80
    t.date "valid_until"
    t.text "general_info"
    t.text "production_info"
    t.text "loading_info"
    t.text "delivery_info"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.bigint "customer_id"
    t.bigint "customer_address_id"
    t.bigint "billing_address_id"
    t.bigint "shipping_address_id"
    t.bigint "pickup_address_id"
    t.index ["billing_address_id"], name: "index_sales_orders_on_billing_address_id"
    t.index ["completed"], name: "index_sales_orders_on_completed"
    t.index ["customer_address_id"], name: "index_sales_orders_on_customer_address_id"
    t.index ["customer_id"], name: "index_sales_orders_on_customer_id"
    t.index ["customer_order_number"], name: "index_sales_orders_on_customer_order_number"
    t.index ["operator"], name: "index_sales_orders_on_operator"
    t.index ["order_date"], name: "index_sales_orders_on_order_date"
    t.index ["pickup_address_id"], name: "index_sales_orders_on_pickup_address_id"
    t.index ["planned_delivery_date"], name: "index_sales_orders_on_planned_delivery_date"
    t.index ["sales_rep"], name: "index_sales_orders_on_sales_rep"
    t.index ["shipping_address_id"], name: "index_sales_orders_on_shipping_address_id"
    t.index ["status"], name: "index_sales_orders_on_status"
    t.index ["updated_at"], name: "index_sales_orders_on_updated_at"
  end

  create_table "weighing_slips", id: :serial, force: :cascade do |t|
    t.integer "database_id", null: false
    t.integer "weighing_slip_number", null: false
    t.integer "slip_type"
    t.date "weighing_date", null: false
    t.string "time", limit: 5
    t.string "operator", limit: 5
    t.string "article_number", limit: 12
    t.string "description1", limit: 40
    t.string "description2", limit: 40
    t.datetime "first_weighing_time"
    t.datetime "second_weighing_time"
    t.float "first_weight"
    t.float "second_weight"
    t.float "net_weight"
    t.float "total_weight"
    t.decimal "price", precision: 10, scale: 4
    t.string "vehicle_registration", limit: 20
    t.boolean "completed", default: false
    t.string "target_slip", limit: 2
    t.integer "document_number"
    t.text "info_text"
    t.integer "contract_number"
    t.integer "contract_position"
    t.string "completion_reason", limit: 80
    t.boolean "printed", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.bigint "customer_id"
    t.bigint "shipping_address_id"
    t.bigint "sales_order_id"
    t.bigint "delivery_note_id"
    t.index ["article_number"], name: "index_weighing_slips_on_article_number"
    t.index ["completed"], name: "index_weighing_slips_on_completed"
    t.index ["contract_number"], name: "index_weighing_slips_on_contract_number"
    t.index ["customer_id"], name: "index_weighing_slips_on_customer_id"
    t.index ["delivery_note_id"], name: "index_weighing_slips_on_delivery_note_id"
    t.index ["sales_order_id"], name: "index_weighing_slips_on_sales_order_id"
    t.index ["shipping_address_id"], name: "index_weighing_slips_on_shipping_address_id"
    t.index ["updated_at"], name: "index_weighing_slips_on_updated_at"
    t.index ["vehicle_registration"], name: "index_weighing_slips_on_vehicle_registration"
    t.index ["weighing_date"], name: "index_weighing_slips_on_weighing_date"
    t.index ["weighing_slip_number"], name: "index_weighing_slips_on_weighing_slip_number", unique: true
  end

  create_table "wws_kunden", primary_key: "kundennr", id: :serial, force: :cascade do |t|
    t.integer "kundgruppe"
    t.integer "bundesland"
    t.string "kontoauszug", limit: 1
    t.datetime "datumlauszug", precision: nil
    t.integer "nrlauszug"
    t.float "saldolauszug"
    t.string "saldorechnung", limit: 1
    t.integer "lfdrechnnr"
    t.integer "rechnkunde"
    t.string "umsatzsteuer", limit: 1
    t.string "werbetext", limit: 1
    t.string "rechnformular", limit: 8
    t.float "rabatt"
    t.string "zahlungart", limit: 1
    t.integer "zinstabsoll"
    t.integer "zinstabhaben"
    t.float "zinssatzsoll"
    t.float "zinssatzhaben"
    t.string "zinsbuchung", limit: 1
    t.datetime "datumlzinsabr", precision: nil
    t.float "saldolzinsabr"
    t.string "selbstabhrabatt", limit: 12
    t.float "selbstabhbetrag"
    t.string "bonusberecht", limit: 1
    t.integer "mitgliednr"
    t.integer "geschkonto"
    t.string "gekuendigt", limit: 1
    t.string "kuendgrund", limit: 30
    t.datetime "datumeintritt", precision: nil
    t.datetime "datumaustritt", precision: nil
    t.integer "pflichtanteile"
    t.integer "pflichtanteilegez"
    t.integer "anteilgekuend1"
    t.datetime "datumkuend1", precision: nil
    t.integer "anteilgekuend2"
    t.datetime "datumkuend2", precision: nil
    t.string "trans", limit: 1
    t.string "trfield", limit: 1
    t.integer "repl_id"
    t.integer "repl_database"
    t.string "organschaft", limit: 1
    t.string "bemerkford", limit: 1
    t.string "kontoauszug2", limit: 1
    t.integer "rechnanzahl"
    t.float "nk_stdsatz"
    t.float "nk_fahrtkosten"
    t.string "offeneposten", limit: 1
    t.float "regalflaeche"
    t.string "fremdwaehrung", limit: 3
    t.string "konzernkunde", limit: 1
    t.float "gk_aufschlag"
    t.float "ernte_mitglbeitrag"
    t.integer "kreditorkto2"
    t.integer "rabstnr_ls"
    t.string "formular_ls", limit: 12
    t.string "versandspesen", limit: 1
    t.string "zert_pflicht", limit: 1
    t.datetime "zert_datum", precision: nil
    t.string "formular_stang", limit: 12
    t.string "formular_stauf", limit: 12
    t.string "lieferbedkurz", limit: 5
    t.string "zahlbedtext", limit: 80
    t.string "zbabdatum", limit: 1
    t.integer "versandavis"
    t.float "proforma_rabatt1"
    t.float "proforma_rabatt2"
    t.datetime "versandavisdatum", precision: nil
    t.integer "zb_id"
    t.integer "zb_dbid"
    t.string "formular_ernte1", limit: 12
    t.string "formular_ernte2", limit: 12
    t.string "formular_ernte3", limit: 12
    t.integer "versandaviseinzel"
    t.string "versandavisvb", limit: 1
    t.float "vkpreiszuschlagek"
    t.datetime "vkpreiszuschldatum", precision: nil
    t.integer "landwamtnr"
    t.string "lwa_betriebsnr", limit: 20
    t.string "kontoauszug1", limit: 1
    t.integer "kundennrschnittst"
    t.string "edi_iln", limit: 15
    t.integer "edi_typ"
    t.integer "edi_uebertrnr"
    t.string "edi_prefix", limit: 15
    t.string "rechnsammelliste", limit: 1
    t.float "marge"
    t.string "edi_iln_nad_su", limit: 15
    t.integer "g12_statistik"
    t.string "kundstatusw", limit: 1
    t.string "versicherung", limit: 1
    t.float "versprozent"
    t.float "schwellenwert"
    t.string "gutschrverr", limit: 1
    t.float "rechnlistenprov"
    t.integer "liefbewertung_basis"
    t.integer "andavisexport"
    t.integer "sprachenr"
    t.string "nabizertstelleregnr", limit: 40
    t.string "bruttoberechn", limit: 1
    t.integer "tankrechnungpdf"
    t.string "zblieferdat", limit: 1
    t.integer "preisqzuabsortenr"
    t.float "minbestellwert"
    t.float "vkbonus"
    t.integer "mvo_ek_kennz"
    t.integer "mvo_vk_kennz"
    t.string "vertrbeauf1keineprov", limit: 1
    t.string "vertrbeauf2keineprov", limit: 1
    t.string "formular_wiegeschein", limit: 12
    t.integer "edi_kostenst"
    t.integer "anzdruckliefersch"
    t.string "sknpflschg", limit: 1
    t.string "kundennrdeuka", limit: 15
    t.string "edi_keinstorno", limit: 1
    t.string "selbstabrechner", limit: 1
    t.string "edi_kundennr", limit: 70
    t.integer "edi_typorders"
    t.integer "edi_typdesadv"
    t.integer "edi_uebertrnr_desadv"
    t.string "formular_nve", limit: 12
    t.string "explosivnachweis", limit: 1
    t.string "edi_iln_desadv", limit: 15
    t.integer "kontraktzusammenstellung"
    t.integer "id_unternehmensgegenstand"
    t.integer "dbid_unternehmensgegenstand"
    t.datetime "explosivnachweisdatum", precision: nil
    t.datetime "geaendertam", precision: nil
    t.integer "edi_abkommensnr"
    t.string "selbstabrechnerek", limit: 1
    t.string "formular_etikett", limit: 12
    t.integer "creditreform_status"
    t.datetime "creditreform_timestamp", precision: nil
    t.index ["bundesland"], name: "index_wws_kunden_on_bundesland"
    t.index ["creditreform_status"], name: "index_wws_kunden_on_creditreform_status"
    t.index ["edi_iln"], name: "index_wws_kunden_on_edi_iln"
    t.index ["geaendertam"], name: "index_wws_kunden_on_geaendertam"
    t.index ["gekuendigt"], name: "index_wws_kunden_on_gekuendigt"
    t.index ["konzernkunde"], name: "index_wws_kunden_on_konzernkunde"
    t.index ["kundennrdeuka"], name: "index_wws_kunden_on_kundennrdeuka"
    t.index ["kundgruppe"], name: "index_wws_kunden_on_kundgruppe"
    t.index ["kundstatusw"], name: "index_wws_kunden_on_kundstatusw"
    t.index ["landwamtnr"], name: "index_wws_kunden_on_landwamtnr"
    t.index ["mitgliednr"], name: "index_wws_kunden_on_mitgliednr"
    t.index ["rechnkunde"], name: "index_wws_kunden_on_rechnkunde"
  end

  create_table "wws_kunden1", primary_key: "kundennr", id: :serial, force: :cascade do |t|
    t.integer "kundgruppe"
    t.integer "bundesland"
    t.string "kontoauszug", limit: 1
    t.datetime "datumlauszug", precision: nil
    t.integer "nrlauszug"
    t.float "saldolauszug"
    t.string "saldorechnung", limit: 1
    t.integer "lfdrechnnr"
    t.integer "rechnkunde"
    t.string "umsatzsteuer", limit: 1
    t.string "werbetext", limit: 1
    t.string "rechnformular", limit: 8
    t.float "rabatt"
    t.string "zahlungart", limit: 1
    t.integer "zinstabsoll"
    t.integer "zinstabhaben"
    t.float "zinssatzsoll"
    t.float "zinssatzhaben"
    t.string "zinsbuchung", limit: 1
    t.datetime "datumlzinsabr", precision: nil
    t.float "saldolzinsabr"
    t.string "selbstabhrabatt", limit: 12
    t.float "selbstabhbetrag"
    t.string "bonusberecht", limit: 1
    t.integer "mitgliednr"
    t.integer "geschkonto"
    t.string "gekuendigt", limit: 1
    t.string "kuendgrund", limit: 30
    t.datetime "datumeintritt", precision: nil
    t.datetime "datumaustritt", precision: nil
    t.integer "pflichtanteile"
    t.integer "pflichtanteilegez"
    t.integer "anteilgekuend1"
    t.datetime "datumkuend1", precision: nil
    t.integer "anteilgekuend2"
    t.datetime "datumkuend2", precision: nil
    t.string "trans", limit: 1
    t.string "trfield", limit: 1
    t.integer "repl_id"
    t.integer "repl_database"
    t.string "organschaft", limit: 1
    t.string "bemerkford", limit: 1
    t.string "kontoauszug2", limit: 1
    t.integer "rechnanzahl"
    t.float "nk_stdsatz"
    t.float "nk_fahrtkosten"
    t.string "offeneposten", limit: 1
    t.float "regalflaeche"
    t.string "fremdwaehrung", limit: 3
    t.string "konzernkunde", limit: 1
    t.float "gk_aufschlag"
    t.float "ernte_mitglbeitrag"
    t.integer "kreditorkto2"
    t.integer "rabstnr_ls"
    t.string "formular_ls", limit: 12
    t.string "versandspesen", limit: 1
    t.string "zert_pflicht", limit: 1
    t.datetime "zert_datum", precision: nil
    t.string "formular_stang", limit: 12
    t.string "formular_stauf", limit: 12
    t.string "lieferbedkurz", limit: 5
    t.string "zahlbedtext", limit: 80
    t.string "zbabdatum", limit: 1
    t.integer "versandavis"
    t.float "proforma_rabatt1"
    t.float "proforma_rabatt2"
    t.datetime "versandavisdatum", precision: nil
    t.integer "zb_id"
    t.integer "zb_dbid"
    t.string "formular_ernte1", limit: 12
    t.string "formular_ernte2", limit: 12
    t.string "formular_ernte3", limit: 12
    t.integer "versandaviseinzel"
    t.string "versandavisvb", limit: 1
    t.float "vkpreiszuschlagek"
    t.datetime "vkpreiszuschldatum", precision: nil
    t.integer "landwamtnr"
    t.string "lwa_betriebsnr", limit: 20
    t.string "kontoauszug1", limit: 1
    t.integer "kundennrschnittst"
    t.string "edi_iln", limit: 15
    t.integer "edi_typ"
    t.integer "edi_uebertrnr"
    t.string "edi_prefix", limit: 15
    t.string "rechnsammelliste", limit: 1
    t.float "marge"
    t.string "edi_iln_nad_su", limit: 15
    t.integer "g12_statistik"
    t.string "kundstatusw", limit: 1
    t.string "versicherung", limit: 1
    t.float "versprozent"
    t.float "schwellenwert"
    t.string "gutschrverr", limit: 1
    t.float "rechnlistenprov"
    t.integer "liefbewertung_basis"
    t.integer "andavisexport"
    t.integer "sprachenr"
    t.string "nabizertstelleregnr", limit: 40
    t.string "bruttoberechn", limit: 1
    t.integer "tankrechnungpdf"
    t.string "zblieferdat", limit: 1
    t.integer "preisqzuabsortenr"
    t.float "minbestellwert"
    t.float "vkbonus"
    t.integer "mvo_ek_kennz"
    t.integer "mvo_vk_kennz"
    t.string "vertrbeauf1keineprov", limit: 1
    t.string "vertrbeauf2keineprov", limit: 1
    t.string "formular_wiegeschein", limit: 12
    t.integer "edi_kostenst"
    t.integer "anzdruckliefersch"
    t.string "sknpflschg", limit: 1
    t.string "kundennrdeuka", limit: 15
    t.string "edi_keinstorno", limit: 1
    t.string "selbstabrechner", limit: 1
    t.string "edi_kundennr", limit: 70
    t.integer "edi_typorders"
    t.integer "edi_typdesadv"
    t.integer "edi_uebertrnr_desadv"
    t.string "formular_nve", limit: 12
    t.string "explosivnachweis", limit: 1
    t.string "edi_iln_desadv", limit: 15
    t.integer "kontraktzusammenstellung"
    t.integer "id_unternehmensgegenstand"
    t.integer "dbid_unternehmensgegenstand"
    t.datetime "explosivnachweisdatum", precision: nil
    t.datetime "geaendertam", precision: nil
    t.integer "edi_abkommensnr"
    t.string "selbstabrechnerek", limit: 1
    t.string "formular_etikett", limit: 12
    t.integer "creditreform_status"
    t.datetime "creditreform_timestamp", precision: nil
  end

  create_table "wws_verkauf1", primary_key: "vauftragnr", id: :serial, force: :cascade do |t|
    t.datetime "datum", precision: nil
    t.string "bediener", limit: 5
    t.string "vertreter", limit: 5
    t.integer "kostenst"
    t.integer "kundennr"
    t.integer "debitorkto"
    t.string "kundname", limit: 30
    t.integer "kundadrnr"
    t.integer "rechnadrnr"
    t.integer "liefadrnr"
    t.string "gebiet", limit: 20
    t.string "best_anrede", limit: 15
    t.string "best_briefanrede", limit: 50
    t.string "besteller", limit: 30
    t.datetime "bestdatum", precision: nil
    t.string "bestnrkd", limit: 50
    t.string "kdabteilung", limit: 30
    t.integer "angebotnr"
    t.datetime "angebdatum", precision: nil
    t.string "liefertext", limit: 80
    t.string "objekt", limit: 80
    t.string "lieferart", limit: 40
    t.integer "waehrcode"
    t.integer "kundwaehrcode"
    t.integer "mwstkz"
    t.integer "skonto1tg"
    t.float "skonto1pr"
    t.integer "skonto2tg"
    t.float "skonto2pr"
    t.integer "nettotg"
    t.datetime "valuta", precision: nil
    t.string "lastschrift", limit: 1
    t.string "zahlbedtext", limit: 80
    t.integer "lager"
    t.integer "lkwnr"
    t.string "selbstabhrabatt", limit: 12
    t.integer "kundrechnart"
    t.string "sammelrech", limit: 1
    t.string "faktfrei1", limit: 1
    t.string "erledigt", limit: 1
    t.string "auftstatus", limit: 1
    t.string "auftrbestgedruckt", limit: 1
    t.string "betrauftrgedruckt", limit: 1
    t.integer "geplliefjahrkw"
    t.datetime "geplliefdatum", precision: nil
    t.string "verzgrund", limit: 5
    t.string "trans", limit: 1
    t.string "trfield", limit: 1
    t.integer "repl_id"
    t.integer "repl_database"
    t.string "textformat", limit: 20
    t.integer "ansprnr"
    t.datetime "anfragedatum", precision: nil
    t.string "ratenzahlung", limit: 1
    t.integer "ansprnr2"
    t.string "bezug", limit: 80
    t.string "pauschalangebot", limit: 1
    t.datetime "gueltigbis", precision: nil
    t.string "probestellung", limit: 1
    t.float "gesmengevorg"
    t.datetime "info_datum", precision: nil
    t.string "info_text", limit: 40
    t.float "lizenzvetrag"
    t.string "liefertermintxt", limit: 50
    t.string "lieftermintext", limit: 50
    t.string "paritaet", limit: 80
    t.integer "baust_nr"
    t.integer "bestellnrlief"
    t.integer "lieferantnr"
    t.integer "abholadrnr"
    t.string "vbgrafikdrucken", limit: 1
    t.integer "schlusspapier"
    t.integer "schlussemail"
    t.integer "schlussfax"
    t.string "ustidmandant", limit: 15
    t.string "ustidkunde", limit: 15
    t.integer "drucksortierung"
    t.integer "spediteurnr"
    t.string "fahrzeug", limit: 22
    t.float "fahrzleergewicht"
    t.string "containernr", limit: 20
    t.integer "transportart"
    t.string "ladeort", limit: 30
    t.integer "zollstelle"
    t.string "kdauftragnr", limit: 20
    t.string "lieferbedkurz", limit: 5
    t.string "zbabdatum", limit: 1
    t.text "infoallgemein"
    t.text "infoproduktion"
    t.text "infoverladung"
    t.text "infoliefsch"
    t.text "infoauftrbest"
    t.string "ausferklnr", limit: 10
    t.datetime "ausferkldatum", precision: nil
    t.datetime "prodtermin", precision: nil
    t.datetime "ladetermin", precision: nil
    t.datetime "ladedatum", precision: nil
    t.string "kfzkennzeichen1", limit: 12
    t.string "kfzkennzeichen2", limit: 12
    t.string "uhrzeit", limit: 5
    t.string "transpklasse", limit: 1
    t.string "transpmittel", limit: 20
    t.float "transpgewicht"
    t.string "zollspedname", limit: 30
    t.datetime "prodterminbis", precision: nil
    t.string "prodterminuhrzeit", limit: 5
    t.string "prodterminbisuhrzeit", limit: 5
    t.string "auftrunterschr", limit: 1
    t.datetime "proforma_lieferdatum", precision: nil
    t.integer "statusproduktion"
    t.string "selbstabholer", limit: 1
    t.integer "webshopbest1id"
    t.integer "webshopbest1dbid"
    t.integer "webshopzahlungart"
    t.integer "repscheinnr"
    t.datetime "auftrunterschrdatum", precision: nil
    t.string "kdreferenznr", limit: 25
    t.integer "hauptkundennr"
    t.string "rechnhauptkunde", limit: 1
    t.integer "aenderungsperre"
    t.string "fremdwaehrung", limit: 3
    t.float "umrfaktor"
    t.string "bruttoberechn", limit: 1
    t.integer "kbestellnr"
    t.string "vb2", limit: 5
    t.string "zblieferdat", limit: 1
    t.string "bedienersperre", limit: 5
    t.string "frachtartikelnr", limit: 12
    t.float "frachtpauschal"
    t.float "frachtpauschal2"
    t.string "projektauftrag", limit: 1
    t.integer "bezugid"
    t.integer "bezugdbid"
    t.string "warnungrabattrefresh", limit: 1
    t.string "vertreter1keineprov", limit: 1
    t.string "vertreter2keineprov", limit: 1
    t.datetime "geaendertam", precision: nil
    t.integer "vertragstyp"
    t.integer "auswertselid"
    t.integer "auswertseldbid"
    t.string "ladeterminuhrzeit", limit: 5
    t.string "ladedatumuhrzeit", limit: 5
    t.string "defaultbeleg", limit: 1
    t.string "kmssperre", limit: 1
    t.integer "versandart"
    t.datetime "lieferterminbis", precision: nil
    t.string "vbpauschalprov", limit: 5
    t.string "vertreter2", limit: 5
    t.string "vorkasse", limit: 1
    t.string "l2schnittstelle", limit: 1
    t.integer "druckinstanw"
    t.string "ext_email", limit: 255
    t.string "ext_telefon", limit: 20
    t.string "ext_name", limit: 30
    t.string "ext_vorname", limit: 30
    t.string "ext_bemerkung", limit: 255
    t.index ["angebotnr"], name: "index_wws_verkauf1_on_angebotnr"
    t.index ["auftstatus"], name: "index_wws_verkauf1_on_auftstatus"
    t.index ["bediener"], name: "index_wws_verkauf1_on_bediener"
    t.index ["bestdatum"], name: "index_wws_verkauf1_on_bestdatum"
    t.index ["datum"], name: "index_wws_verkauf1_on_datum"
    t.index ["erledigt"], name: "index_wws_verkauf1_on_erledigt"
    t.index ["geaendertam"], name: "index_wws_verkauf1_on_geaendertam"
    t.index ["geplliefdatum"], name: "index_wws_verkauf1_on_geplliefdatum"
    t.index ["hauptkundennr"], name: "index_wws_verkauf1_on_hauptkundennr"
    t.index ["kdauftragnr"], name: "index_wws_verkauf1_on_kdauftragnr"
    t.index ["kdreferenznr"], name: "index_wws_verkauf1_on_kdreferenznr"
    t.index ["kostenst"], name: "index_wws_verkauf1_on_kostenst"
    t.index ["kundennr"], name: "index_wws_verkauf1_on_kundennr"
    t.index ["lager"], name: "index_wws_verkauf1_on_lager"
    t.index ["lieferantnr"], name: "index_wws_verkauf1_on_lieferantnr"
    t.index ["spediteurnr"], name: "index_wws_verkauf1_on_spediteurnr"
    t.index ["statusproduktion"], name: "index_wws_verkauf1_on_statusproduktion"
    t.index ["vertragstyp"], name: "index_wws_verkauf1_on_vertragstyp"
    t.index ["vertreter"], name: "index_wws_verkauf1_on_vertreter"
  end

  create_table "wws_verkauf2", id: false, force: :cascade do |t|
    t.integer "vauftragnr", null: false
    t.integer "posnr", null: false
    t.string "posart", limit: 1
    t.string "artikelnr", limit: 12
    t.string "bezeichn1", limit: 40
    t.string "bezeichn2", limit: 40
    t.text "langtext"
    t.string "langzusaet", limit: 1
    t.string "langliefer", limit: 1
    t.string "langrechn", limit: 1
    t.string "artikelart", limit: 4
    t.integer "umsatzgrp"
    t.integer "posnrvon"
    t.integer "posnrbis"
    t.string "berechnart", limit: 2
    t.float "zuabschlag"
    t.string "vertreter", limit: 5
    t.integer "lager"
    t.integer "abteilung"
    t.integer "lagerfach"
    t.integer "chargennr"
    t.string "seriennr", limit: 40
    t.integer "kostenst"
    t.integer "erlkonto"
    t.integer "kontraktnr"
    t.float "gebindemg"
    t.integer "gebindschl"
    t.string "gebindeinh", limit: 5
    t.float "gebinhalt"
    t.float "menge"
    t.float "bishliefmg"
    t.integer "einhschl"
    t.string "einheit", limit: 5
    t.integer "preiseinh"
    t.integer "steuerschl"
    t.float "mwstsatz"
    t.float "listpreis"
    t.float "listbrutto"
    t.float "rabatt"
    t.string "rabattart", limit: 3
    t.float "einhpreis"
    t.float "bruttpreis"
    t.float "netto"
    t.float "mwst"
    t.float "brutto"
    t.float "listpreis2"
    t.float "listbrutto2"
    t.float "einhpreis2"
    t.float "bruttpreis2"
    t.float "netto2"
    t.float "mwst2"
    t.float "brutto2"
    t.integer "lsrabatt"
    t.integer "rabpos_s"
    t.integer "rabpos_l"
    t.float "gewicht"
    t.string "skonto", limit: 1
    t.string "wrv", limit: 1
    t.string "bonus", limit: 1
    t.string "selbstabhrabatt", limit: 1
    t.string "pauschal", limit: 1
    t.string "fremdware", limit: 1
    t.string "trans", limit: 1
    t.string "trfield", limit: 1
    t.integer "repl_id"
    t.integer "repl_database"
    t.string "langangebot", limit: 1
    t.string "langauftrag", limit: 1
    t.string "kommission", limit: 1
    t.integer "kontraktpos"
    t.float "sollpreis"
    t.integer "altschl"
    t.string "alteinheit", limit: 5
    t.float "altmenge"
    t.float "altumr"
    t.string "sonderpreis", limit: 1
    t.integer "rezepturnr"
    t.string "prod_erledigt", limit: 1
    t.integer "rezepturnr2"
    t.integer "ruestliste"
    t.string "rezeptangebot", limit: 1
    t.string "rezeptauftrag", limit: 1
    t.string "rezeptliefer", limit: 1
    t.string "rezeptrechn", limit: 1
    t.integer "bestellnrlief"
    t.string "rabattfaehig", limit: 1
    t.string "zuabschlagnr", limit: 12
    t.string "zuabstaffel", limit: 1
    t.float "ladungsgewicht"
    t.integer "palettennr"
    t.integer "palanzahl"
    t.integer "umrpalgebinde"
    t.float "umrpalmenge"
    t.integer "skonto1tg"
    t.float "skonto1pr"
    t.integer "skonto2tg"
    t.float "skonto2pr"
    t.integer "nettotg"
    t.float "auftragmindestmenge"
    t.text "kommentar"
    t.text "infoverladung"
    t.text "infoproduktion"
    t.string "rezeptproduktion", limit: 1
    t.integer "produktionsauftragid"
    t.integer "kontrakttyp"
    t.float "kontraktpreis"
    t.integer "prodanlage"
    t.integer "vorprodanlage"
    t.string "artikelnraufdruck", limit: 12
    t.string "textaufdruck", limit: 50
    t.string "sg_kommission", limit: 1
    t.string "druckgefahrg", limit: 1
    t.string "druckanalyse", limit: 5
    t.integer "druckspez"
    t.float "sollpreis_prov"
    t.float "rabatt2"
    t.string "rabattart2", limit: 5
    t.string "zuabschlagnr2", limit: 12
    t.string "gefgutklasse", limit: 5
    t.integer "gefgutpunkte"
    t.float "ekpreis"
    t.integer "reparatur"
    t.float "zuabschlag2"
    t.integer "artikeltextfix"
    t.string "nabi", limit: 1
    t.string "bruttoberechn", limit: 1
    t.string "chargenaufteilung", limit: 1
    t.integer "prodparnr"
    t.integer "soheberechn"
    t.float "sohepreis"
    t.integer "reznralternativ"
    t.integer "anzfolgeart"
    t.integer "langtextgrafikzusaet"
    t.integer "aubelegnr"
    t.integer "kommissionierungstatus"
    t.integer "nuts2_id"
    t.integer "nuts2_dbid"
    t.float "gewichtnetto"
    t.integer "id_tourenplan2"
    t.integer "dbid_tourenplan2"
    t.float "kalkkosten"
    t.integer "picklistnr"
    t.integer "bestellposnrlief"
    t.float "rabattw2"
    t.string "rabattartw2", limit: 5
    t.float "rabatt2w2"
    t.string "rabattart2w2", limit: 5
    t.integer "ap1gebindschl"
    t.integer "pe1stamm"
    t.string "digispostyp", limit: 1
    t.integer "id_vkschlag"
    t.integer "dbid_vkschlag"
    t.string "schnittstexport", limit: 1
    t.float "frachtpv"
    t.integer "id_pv"
    t.integer "dbid_pv"
    t.integer "altpreiseinh"
    t.float "alteinhpreis"
    t.float "altbruttpreis"
    t.float "altlistpreis"
    t.float "altlistbrutto"
    t.float "alteinhpreis2"
    t.float "altbruttpreis2"
    t.float "altlistpreis2"
    t.float "altlistbrutto2"
    t.string "neukundenprovision", limit: 1
    t.integer "lmusternr"
    t.float "artrabatt1"
    t.float "artrabatt2"
    t.integer "artzuabschlagnr1"
    t.integer "artzuabschlagnr2"
    t.integer "reglief_id"
    t.integer "reglief_dbid"
    t.string "aufabschlagrech", limit: 1
    t.integer "silo_id"
    t.integer "silo_dbid"
    t.integer "folgeposvon"
    t.integer "fibuabgrkonto"
    t.integer "silonummer"
    t.string "silobezeichnung", limit: 255
    t.string "rabattnichtrunden", limit: 1
    t.integer "bgrkomponente"
    t.index ["abteilung"], name: "index_wws_verkauf2_on_abteilung"
    t.index ["artikelnr"], name: "index_wws_verkauf2_on_artikelnr"
    t.index ["bestellnrlief"], name: "index_wws_verkauf2_on_bestellnrlief"
    t.index ["chargennr"], name: "index_wws_verkauf2_on_chargennr"
    t.index ["erlkonto"], name: "index_wws_verkauf2_on_erlkonto"
    t.index ["kommissionierungstatus"], name: "index_wws_verkauf2_on_kommissionierungstatus"
    t.index ["kontraktnr"], name: "index_wws_verkauf2_on_kontraktnr"
    t.index ["kontraktpos"], name: "index_wws_verkauf2_on_kontraktpos"
    t.index ["kostenst"], name: "index_wws_verkauf2_on_kostenst"
    t.index ["lager"], name: "index_wws_verkauf2_on_lager"
    t.index ["picklistnr"], name: "index_wws_verkauf2_on_picklistnr"
    t.index ["prodanlage"], name: "index_wws_verkauf2_on_prodanlage"
    t.index ["produktionsauftragid"], name: "index_wws_verkauf2_on_produktionsauftragid"
    t.index ["rezepturnr"], name: "index_wws_verkauf2_on_rezepturnr"
    t.index ["silo_id"], name: "index_wws_verkauf2_on_silo_id"
    t.index ["vauftragnr", "posnr"], name: "idx_verkauf2_primary", unique: true
    t.index ["vauftragnr"], name: "index_wws_verkauf2_on_vauftragnr"
    t.index ["vertreter"], name: "index_wws_verkauf2_on_vertreter"
  end

  create_table "wws_vliefer1", primary_key: "liefschnr", id: :serial, force: :cascade do |t|
    t.integer "vauftragnr"
    t.datetime "datum", precision: nil
    t.string "einkaufverkauf", limit: 2
    t.integer "geplliefjahrkw"
    t.datetime "geplliefdatum", precision: nil
    t.string "bediener", limit: 5
    t.string "vertreter", limit: 5
    t.integer "kostenst"
    t.integer "kundennr"
    t.string "kundname", limit: 30
    t.integer "rechnadrnr"
    t.integer "kundadrnr"
    t.integer "liefadrnr"
    t.integer "debitorkto"
    t.string "rechnhauptkunde", limit: 1
    t.string "gebiet", limit: 20
    t.string "best_anrede", limit: 15
    t.string "best_briefanrede", limit: 50
    t.string "besteller", limit: 30
    t.datetime "bestdatum", precision: nil
    t.string "bestnrkd", limit: 50
    t.string "kdabteilung", limit: 30
    t.integer "angebotnr"
    t.datetime "angebdatum", precision: nil
    t.string "liefertext", limit: 80
    t.string "objekt", limit: 80
    t.string "lieferart", limit: 40
    t.string "zertifikat", limit: 1
    t.integer "waehrcode"
    t.integer "kundwaehrcode"
    t.integer "mwstkz"
    t.integer "rabattproz"
    t.float "netto"
    t.float "brutto"
    t.integer "skonto1tg"
    t.float "skonto1pr"
    t.integer "skonto2tg"
    t.float "skonto2pr"
    t.integer "nettotg"
    t.datetime "valuta", precision: nil
    t.string "lastschrift", limit: 1
    t.string "zahlbedtext", limit: 80
    t.integer "lager"
    t.integer "lkwnr"
    t.string "selbstabholung", limit: 1
    t.string "selbstabhrabatt", limit: 12
    t.string "faktfrei1", limit: 1
    t.string "faktfrei2", limit: 1
    t.string "gedruckt", limit: 1
    t.integer "rechnungnr"
    t.integer "kundrechnart"
    t.string "sammelrech", limit: 1
    t.string "dummy", limit: 1
    t.string "trans", limit: 1
    t.string "trfield", limit: 1
    t.integer "repl_id"
    t.integer "repl_database"
    t.string "gutschrift", limit: 1
    t.integer "strecke_auftragnr"
    t.integer "strecke_eliefschnr"
    t.integer "strecke_erechnnr"
    t.string "ratenzahlung", limit: 1
    t.string "fahrzeug", limit: 22
    t.float "gesmengevorg"
    t.integer "mgb_ecr"
    t.integer "mgb_bestellnr"
    t.string "fremdwaehrung", limit: 3
    t.float "umrfaktor"
    t.string "zblieferdat", limit: 1
    t.string "wiegenota", limit: 10
    t.integer "arechnungnr"
    t.integer "kbestellnr"
    t.float "lizenzvetrag"
    t.integer "kasse"
    t.integer "spediteurnr"
    t.string "paritaet", limit: 80
    t.integer "baust_nr"
    t.integer "bestellnrlief"
    t.integer "lieferantnr"
    t.integer "abholadrnr"
    t.string "ustidmandant", limit: 15
    t.string "ustidkunde", limit: 15
    t.integer "wws_intra_meldung1_id"
    t.integer "wws_intra_meldung1_dbid"
    t.integer "ursprungls"
    t.string "faktfrei3", limit: 1
    t.float "fahrzleergewicht"
    t.string "containernr", limit: 20
    t.integer "transportart"
    t.string "ladeort", limit: 30
    t.string "zbabdatum", limit: 1
    t.string "lieferbedkurz", limit: 5
    t.datetime "ladedatum", precision: nil
    t.string "kfzkennzeichen1", limit: 12
    t.string "kfzkennzeichen2", limit: 12
    t.string "kdauftragnr", limit: 20
    t.string "zollspedname", limit: 30
    t.datetime "versandavisdatum", precision: nil
    t.text "infoliefsch"
    t.integer "hauptkundennr"
    t.string "belegartschnittstelle", limit: 5
    t.string "uhrzeit", limit: 5
    t.datetime "mgb_bestelldatum", precision: nil
    t.integer "ursprungsls"
    t.integer "webshopbest1id"
    t.integer "webshopbest1dbid"
    t.integer "webshopzahlungart"
    t.string "fruehbezug", limit: 1
    t.integer "repscheinnr"
    t.string "kennzeichnung", limit: 20
    t.integer "rechnungnrkorrektur"
    t.integer "ksvorgangnr"
    t.string "bruttoberechn", limit: 1
    t.integer "liefschnrbtg"
    t.string "bedienersperre", limit: 5
    t.integer "wws_intra_meldungar1_id"
    t.integer "wws_intra_meldungar1_dbid"
    t.string "frachtartikelnr", limit: 12
    t.float "frachtpauschal"
    t.float "frachtpauschal2"
    t.string "vertreter2", limit: 5
    t.string "vertreter1keineprov", limit: 1
    t.string "vertreter2keineprov", limit: 1
    t.text "infoverladung"
    t.string "edi_desadv", limit: 1
    t.integer "id_org_bericht"
    t.integer "dbid_org_bericht"
    t.integer "versandart"
    t.string "alseinkaufbuchen", limit: 1
    t.string "vorkasse", limit: 1
    t.integer "rechnungnrurspr"
    t.index ["angebotnr"], name: "index_wws_vliefer1_on_angebotnr"
    t.index ["bediener"], name: "index_wws_vliefer1_on_bediener"
    t.index ["datum"], name: "index_wws_vliefer1_on_datum"
    t.index ["gedruckt"], name: "index_wws_vliefer1_on_gedruckt"
    t.index ["geplliefdatum"], name: "index_wws_vliefer1_on_geplliefdatum"
    t.index ["gutschrift"], name: "index_wws_vliefer1_on_gutschrift"
    t.index ["hauptkundennr"], name: "index_wws_vliefer1_on_hauptkundennr"
    t.index ["kasse"], name: "index_wws_vliefer1_on_kasse"
    t.index ["kostenst"], name: "index_wws_vliefer1_on_kostenst"
    t.index ["kundennr"], name: "index_wws_vliefer1_on_kundennr"
    t.index ["ladedatum"], name: "index_wws_vliefer1_on_ladedatum"
    t.index ["lager"], name: "index_wws_vliefer1_on_lager"
    t.index ["lieferantnr"], name: "index_wws_vliefer1_on_lieferantnr"
    t.index ["rechnungnr"], name: "index_wws_vliefer1_on_rechnungnr"
    t.index ["selbstabholung"], name: "index_wws_vliefer1_on_selbstabholung"
    t.index ["spediteurnr"], name: "index_wws_vliefer1_on_spediteurnr"
    t.index ["transportart"], name: "index_wws_vliefer1_on_transportart"
    t.index ["ursprungls"], name: "index_wws_vliefer1_on_ursprungls"
    t.index ["vauftragnr"], name: "index_wws_vliefer1_on_vauftragnr"
    t.index ["versandart"], name: "index_wws_vliefer1_on_versandart"
    t.index ["versandavisdatum"], name: "index_wws_vliefer1_on_versandavisdatum"
    t.index ["vertreter"], name: "index_wws_vliefer1_on_vertreter"
    t.index ["webshopbest1id"], name: "index_wws_vliefer1_on_webshopbest1id"
  end

  create_table "wws_vliefer2", id: false, force: :cascade do |t|
    t.integer "liefschnr", null: false
    t.integer "posnr", null: false
    t.integer "vauftragnr"
    t.string "posart", limit: 1
    t.string "einkaufverkauf", limit: 2
    t.string "artikelnr", limit: 12
    t.string "bezeichn1", limit: 40
    t.string "bezeichn2", limit: 40
    t.text "langtext"
    t.string "langzusaet", limit: 1
    t.string "langliefer", limit: 1
    t.string "langrechn", limit: 1
    t.string "artikelart", limit: 4
    t.integer "posnrvon"
    t.integer "posnrbis"
    t.string "berechnart", limit: 2
    t.float "zuabschlag"
    t.string "vertreter", limit: 5
    t.integer "lager"
    t.integer "abteilung"
    t.integer "lagerfach"
    t.integer "chargennr"
    t.string "seriennr", limit: 40
    t.integer "kostenst"
    t.integer "erlkonto"
    t.integer "kontraktnr"
    t.float "gebindemg"
    t.integer "gebindschl"
    t.string "gebindeinh", limit: 5
    t.float "gebinhalt"
    t.float "liefmenge"
    t.integer "einhschl"
    t.string "einheit", limit: 5
    t.integer "verpackmenge"
    t.integer "verpackschl"
    t.string "verpackeinh", limit: 5
    t.integer "preiseinh"
    t.integer "steuerschl"
    t.float "mwstsatz"
    t.float "listpreis"
    t.float "listbrutto"
    t.float "rabatt"
    t.string "rabattart", limit: 3
    t.float "einhpreis"
    t.float "bruttpreis"
    t.float "listpreis2"
    t.float "listbrutto2"
    t.float "einhpreis2"
    t.float "bruttpreis2"
    t.float "netto"
    t.float "mwst"
    t.float "brutto"
    t.float "netto2"
    t.float "mwst2"
    t.float "brutto2"
    t.integer "umsatzgrp"
    t.integer "lsrabatt"
    t.integer "rabpos_s"
    t.integer "rabpos_l"
    t.float "gewicht"
    t.string "skonto", limit: 1
    t.string "wrv", limit: 1
    t.string "bonus", limit: 1
    t.string "selbstabhrabatt", limit: 1
    t.string "pauschal", limit: 1
    t.string "fremdware", limit: 1
    t.integer "journaldruck"
    t.integer "journalseite"
    t.integer "druckspez"
    t.string "druckgefahrg", limit: 1
    t.string "druckanalyse", limit: 5
    t.string "dummy", limit: 1
    t.string "trfield", limit: 1
    t.integer "repl_id"
    t.integer "repl_database"
    t.string "kommission", limit: 1
    t.integer "kontraktpos"
    t.integer "anzahlseriennr"
    t.string "eingabeseriennr", limit: 1
    t.float "sollpreis"
    t.integer "altschl"
    t.string "alteinheit", limit: 5
    t.float "altmenge"
    t.float "altumr"
    t.string "sonderpreis", limit: 1
    t.integer "rabatt_inpos"
    t.integer "ruestliste"
    t.integer "mgb_posnr"
    t.string "fremdwaehrung", limit: 3
    t.float "umrfaktor"
    t.integer "rezepturnr"
    t.float "reportzuschlag"
    t.integer "streckenr"
    t.integer "vauftragposnr"
    t.integer "refnr"
    t.integer "rezepturnr2"
    t.string "rezeptliefer", limit: 1
    t.string "rezeptrechn", limit: 1
    t.integer "bestellnrlief"
    t.string "rabattfaehig", limit: 1
    t.string "zuabschlagnr", limit: 12
    t.string "zuabstaffel", limit: 1
    t.float "ladungsgewicht"
    t.integer "palettennr"
    t.integer "palanzahl"
    t.integer "umrpalgebinde"
    t.float "umrpalmenge"
    t.integer "kontrakttyp"
    t.float "kontraktpreis"
    t.float "guthverrechn"
    t.string "eancode", limit: 15
    t.string "artikelnr_kunde", limit: 20
    t.string "gefgutklasse", limit: 5
    t.integer "gefgutpunkte"
    t.string "sg_kommission", limit: 1
    t.integer "bwdexport"
    t.float "sollpreis_prov"
    t.float "rabatt2"
    t.string "rabattart2", limit: 5
    t.string "zuabschlagnr2", limit: 12
    t.integer "schlschnr"
    t.integer "formelnr"
    t.string "ausfaktur", limit: 1
    t.string "fruehbezugerledigt", limit: 1
    t.float "ekpreis"
    t.integer "positiontyp"
    t.float "zuabschlag2"
    t.string "nabi", limit: 1
    t.string "bruttoberechn", limit: 1
    t.string "chargenaufteilung", limit: 1
    t.integer "ksvorgangposnr"
    t.integer "ksstrecke2posnr"
    t.integer "anzfolgeart"
    t.string "qzuabpreis", limit: 1
    t.integer "qzuabsortenr"
    t.float "qzuabbasispreis"
    t.float "qzuabbasispreis2"
    t.float "qzuabgewicht"
    t.integer "strecke_auftragposnr"
    t.integer "nuts2_id"
    t.integer "nuts2_dbid"
    t.float "gewichtnetto"
    t.integer "id_tourenplan2"
    t.integer "dbid_tourenplan2"
    t.integer "bestellposnrlief"
    t.text "infoverladung"
    t.float "rabattw2"
    t.string "rabattartw2", limit: 5
    t.float "rabatt2w2"
    t.string "rabattart2w2", limit: 5
    t.integer "ap1gebindschl"
    t.integer "pe1stamm"
    t.integer "nve_id"
    t.integer "nve_dbid"
    t.integer "nveart_id"
    t.integer "nveart_dbid"
    t.string "digispostyp", limit: 1
    t.integer "id_vkschlag"
    t.integer "dbid_vkschlag"
    t.float "frachtpv"
    t.integer "id_pv"
    t.integer "dbid_pv"
    t.integer "altpreiseinh"
    t.float "alteinhpreis"
    t.float "altbruttpreis"
    t.float "altlistpreis"
    t.float "altlistbrutto"
    t.float "alteinhpreis2"
    t.float "altbruttpreis2"
    t.float "altlistpreis2"
    t.float "altlistbrutto2"
    t.integer "lmusternr"
    t.float "artrabatt1"
    t.float "artrabatt2"
    t.integer "artzuabschlagnr1"
    t.integer "artzuabschlagnr2"
    t.integer "reglief_id"
    t.integer "reglief_dbid"
    t.integer "fibuabgrkonto"
    t.integer "fremdbelegnr"
    t.integer "fremdbelegposnr"
    t.string "fremdbelegart", limit: 2
    t.string "rabattnichtrunden", limit: 1
    t.integer "bgrkomponente"
    t.integer "liefschnrurspr"
    t.integer "posnrurspr"
    t.index ["abteilung"], name: "index_wws_vliefer2_on_abteilung"
    t.index ["artikelnr"], name: "index_wws_vliefer2_on_artikelnr"
    t.index ["artikelnr_kunde"], name: "index_wws_vliefer2_on_artikelnr_kunde"
    t.index ["bestellnrlief"], name: "index_wws_vliefer2_on_bestellnrlief"
    t.index ["chargennr"], name: "index_wws_vliefer2_on_chargennr"
    t.index ["eancode"], name: "index_wws_vliefer2_on_eancode"
    t.index ["erlkonto"], name: "index_wws_vliefer2_on_erlkonto"
    t.index ["id_tourenplan2"], name: "index_wws_vliefer2_on_id_tourenplan2"
    t.index ["kontraktnr"], name: "index_wws_vliefer2_on_kontraktnr"
    t.index ["kontraktpos"], name: "index_wws_vliefer2_on_kontraktpos"
    t.index ["kostenst"], name: "index_wws_vliefer2_on_kostenst"
    t.index ["lager"], name: "index_wws_vliefer2_on_lager"
    t.index ["liefschnr", "posnr"], name: "idx_vliefer2_primary", unique: true
    t.index ["liefschnr"], name: "index_wws_vliefer2_on_liefschnr"
    t.index ["liefschnrurspr"], name: "index_wws_vliefer2_on_liefschnrurspr"
    t.index ["nve_id"], name: "index_wws_vliefer2_on_nve_id"
    t.index ["palettennr"], name: "index_wws_vliefer2_on_palettennr"
    t.index ["rezepturnr"], name: "index_wws_vliefer2_on_rezepturnr"
    t.index ["schlschnr"], name: "index_wws_vliefer2_on_schlschnr"
    t.index ["streckenr"], name: "index_wws_vliefer2_on_streckenr"
    t.index ["vauftragnr"], name: "index_wws_vliefer2_on_vauftragnr"
    t.index ["vauftragposnr"], name: "index_wws_vliefer2_on_vauftragposnr"
    t.index ["vertreter"], name: "index_wws_vliefer2_on_vertreter"
  end

  create_table "wws_wiegeschein", id: :serial, force: :cascade do |t|
    t.integer "dbid", null: false
    t.integer "wiegescheinnr", null: false
    t.integer "art"
    t.datetime "datum", precision: nil
    t.string "uhrzeit", limit: 5
    t.string "bediener", limit: 5
    t.integer "kundliefnr"
    t.integer "kostenstelle"
    t.integer "lager"
    t.integer "abteilung"
    t.string "artikelnr", limit: 12
    t.integer "sorten_id"
    t.integer "sorten_dbid"
    t.integer "kontraktnr"
    t.integer "wiegungwaageid1"
    t.integer "wiegungwaageid2"
    t.datetime "wiegungdatum1", precision: nil
    t.datetime "wiegungdatum2", precision: nil
    t.integer "wiegungeinh"
    t.string "kfz_kennzeichen", limit: 20
    t.string "trfield", limit: 1
    t.integer "repl_id"
    t.integer "repl_database"
    t.float "wiegungnetto1"
    t.float "wiegungnetto2"
    t.float "gewicht"
    t.float "preis"
    t.integer "kontraktpos"
    t.integer "status"
    t.string "erledigt", limit: 1
    t.string "zielschein", limit: 2
    t.integer "belegnr"
    t.string "wiegunguhrzeit1", limit: 5
    t.string "wiegunguhrzeit2", limit: 5
    t.text "infotext"
    t.integer "chargennr"
    t.integer "spediteurnr"
    t.integer "auftragnr"
    t.integer "lagerfach"
    t.string "wiegungidentnr1", limit: 100
    t.string "wiegungidentnr2", limit: 100
    t.string "liefliefschnr", limit: 10
    t.datetime "liefdatum", precision: nil
    t.string "nawaro", limit: 1
    t.integer "nawaro_vertragnr"
    t.integer "bestellungnr"
    t.integer "lager2"
    t.integer "abteilung2"
    t.integer "lagerfach2"
    t.integer "chargennr2"
    t.string "zielscheinfestgelegt", limit: 1
    t.integer "posnr"
    t.string "ausfremdbestand", limit: 1
    t.integer "fb_lager"
    t.integer "fb_abteilung"
    t.integer "fb_lagerfach"
    t.integer "fb_chargennr"
    t.string "muster", limit: 40
    t.string "bezeichn1", limit: 40
    t.string "bezeichn2", limit: 40
    t.float "fb_diffmenge"
    t.integer "debktohauptkd"
    t.string "rechnhauptkunde", limit: 1
    t.string "bemerkungen", limit: 80
    t.string "sperre", limit: 1
    t.integer "zaehleranfang"
    t.integer "zaehlerende"
    t.float "fuellmenge"
    t.float "restmenge"
    t.string "nabi", limit: 1
    t.integer "streckenr"
    t.integer "vorgangnr"
    t.integer "vorgangposnr"
    t.string "qzuabpreis", limit: 1
    t.float "menge"
    t.string "erledigungsgrund", limit: 80
    t.integer "nuts2_id"
    t.integer "nuts2_dbid"
    t.string "kontraktaufteilung", limit: 1
    t.integer "liefadrnr"
    t.integer "gosse"
    t.string "analysefertig", limit: 1
    t.integer "anliefereradrnr"
    t.integer "zwhaendleradrnr"
    t.integer "zwhaendlernr"
    t.integer "export"
    t.float "sollgewicht"
    t.integer "nve_id"
    t.integer "nve_dbid"
    t.integer "nveart_id"
    t.integer "nveart_dbid"
    t.string "erledigtbediener", limit: 5
    t.datetime "erledigtdatum", precision: nil
    t.datetime "erledigtuhrzeit", precision: nil
    t.integer "auftragposnr"
    t.integer "bestellungposnr"
    t.integer "importbelegnr"
    t.string "importbelegart", limit: 2
    t.float "fb_preisfruehbezug"
    t.string "handwiegung", limit: 1
    t.integer "lmusternr"
    t.integer "fb_belegnr"
    t.integer "fb_belegposnr"
    t.string "fb_belegart", limit: 2
    t.datetime "geaendertam", precision: nil
    t.string "auto_druck", limit: 1
    t.string "gedruckt", limit: 1
    t.index ["artikelnr"], name: "index_wws_wiegeschein_on_artikelnr"
    t.index ["belegnr"], name: "index_wws_wiegeschein_on_belegnr"
    t.index ["datum"], name: "index_wws_wiegeschein_on_datum"
    t.index ["dbid"], name: "index_wws_wiegeschein_on_dbid"
    t.index ["kontraktnr"], name: "index_wws_wiegeschein_on_kontraktnr"
    t.index ["kundliefnr"], name: "index_wws_wiegeschein_on_kundliefnr"
    t.index ["status"], name: "index_wws_wiegeschein_on_status"
    t.index ["wiegescheinnr"], name: "index_wws_wiegeschein_on_wiegescheinnr"
  end

  add_foreign_key "addresses", "customers", column: "nummer", primary_key: "kundennr"
  add_foreign_key "delivery_note_line_items", "delivery_notes"
  add_foreign_key "delivery_note_line_items", "sales_orders"
  add_foreign_key "delivery_notes", "sales_orders"
  add_foreign_key "sales_order_line_items", "sales_orders"
  add_foreign_key "weighing_slips", "delivery_notes"
  add_foreign_key "weighing_slips", "sales_orders"
end
