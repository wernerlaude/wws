class CreateCleanWwsTables < ActiveRecord::Migration[8.0]
  def change
    # Enable necessary extensions
    enable_extension 'pg_catalog.plpgsql'

    # Addresses Table
    create_table :addresses, id: :serial do |t|
      t.string :name1, limit: 100
      t.string :name2, limit: 100
      t.string :industry, limit: 100
      t.string :street, limit: 42
      t.string :country_code, limit: 3
      t.string :postal_code, limit: 10
      t.string :city, limit: 40
      t.string :po_box, limit: 10
      t.string :po_postal_code, limit: 8
      t.string :po_city, limit: 30
      t.string :phone1, limit: 20
      t.string :phone2, limit: 20
      t.string :fax, limit: 20
      t.string :country, limit: 40
      t.string :salutation, limit: 15
      t.string :letter_salutation, limit: 50
      t.string :address_type, limit: 1 # K=Customer, L=Supplier, S=Other
      t.string :email, limit: 255
      t.string :website, limit: 60
      t.boolean :active, default: true, null: false

      # Rails timestamps
      t.timestamp :created_at, precision: 6
      t.timestamp :updated_at, precision: 6

      # Indexes for performance
      t.index :address_type
      t.index :email
      t.index :active
      t.index :name1
      t.index :city
      t.index :postal_code
    end

    # Customers Table
    create_table :customers, id: :serial do |t|
      t.integer :customer_group
      t.integer :state
      t.integer :member_number
      t.string :vat_liable, limit: 1, default: 'N' # J/N
      t.string :terminated, limit: 1, default: 'N' # J/N
      t.string :termination_reason, limit: 30
      t.float :discount_percent, default: 0.0
      t.string :payment_terms, limit: 1
      t.integer :days_net
      t.float :credit_limit
      t.string :invoice_format, limit: 12
      t.string :currency, limit: 3, default: 'EUR'
      t.string :delivery_terms_short, limit: 5
      t.string :payment_terms_text, limit: 80
      t.boolean :self_pickup_discount, default: false
      t.float :minimum_order_value, default: 0.0
      t.string :edi_number, limit: 15
      t.integer :edi_type
      t.date :entry_date
      t.date :exit_date

      # Rails timestamps
      t.timestamp :created_at, precision: 6
      t.timestamp :updated_at, precision: 6

      # Foreign keys
      t.references :address, foreign_key: { to_table: :addresses }

      # Indexes
      t.index :customer_group
      t.index :state
      t.index :terminated
      t.index :member_number
      t.index :vat_liable
      t.index :updated_at
    end

    # Sales Orders Table
    create_table :sales_orders, id: :serial do |t|
      t.date :order_date, null: false
      t.string :operator, limit: 5
      t.string :sales_rep, limit: 5
      t.string :status, limit: 1 # A=Quote, B=Order, E=Completed, S=Cancelled
      t.boolean :completed, default: false
      t.string :customer_name, limit: 30
      t.string :customer_order_number, limit: 50
      t.string :customer_department, limit: 30
      t.string :delivery_terms, limit: 80
      t.string :project, limit: 80
      t.string :delivery_type, limit: 40
      t.integer :currency_code
      t.integer :vat_code
      t.integer :discount1_days
      t.float :discount1_percent
      t.integer :discount2_days
      t.float :discount2_percent
      t.integer :net_days
      t.date :due_date
      t.string :payment_terms_text, limit: 80
      t.integer :warehouse
      t.boolean :self_pickup, default: false
      t.string :delivery_terms_short, limit: 5
      t.date :planned_delivery_date
      t.string :reference, limit: 80
      t.date :valid_until
      t.text :general_info
      t.text :production_info
      t.text :loading_info
      t.text :delivery_info

      # Rails timestamps
      t.timestamp :created_at, precision: 6
      t.timestamp :updated_at, precision: 6

      # Foreign keys
      t.references :customer, foreign_key: { to_table: :customers }
      t.references :customer_address, foreign_key: { to_table: :addresses }, null: true
      t.references :billing_address, foreign_key: { to_table: :addresses }, null: true
      t.references :shipping_address, foreign_key: { to_table: :addresses }, null: true
      t.references :pickup_address, foreign_key: { to_table: :addresses }, null: true

      # Indexes
      t.index :order_date
      t.index :status
      t.index :completed
      t.index :operator
      t.index :sales_rep
      t.index :planned_delivery_date
      t.index :customer_order_number
      t.index :updated_at
    end

    # Sales Order Line Items Table
    create_table :sales_order_line_items, id: false do |t|
      t.integer :sales_order_id, null: false
      t.integer :position_number, null: false
      t.string :position_type, limit: 1, default: 'N' # N=Normal, T=Text, Z=Surcharge, R=Discount
      t.string :article_number, limit: 12
      t.string :description1, limit: 40
      t.string :description2, limit: 40
      t.text :long_text
      t.string :article_type, limit: 4
      t.integer :sales_group
      t.integer :warehouse
      t.integer :department
      t.float :quantity, null: false
      t.integer :unit_key
      t.string :unit, limit: 5
      t.decimal :unit_price, precision: 10, scale: 4, null: false
      t.decimal :gross_price, precision: 10, scale: 4
      t.decimal :list_price, precision: 10, scale: 4
      t.float :discount_percent, default: 0.0
      t.string :discount_type, limit: 3
      t.float :vat_rate, default: 19.0
      t.decimal :net_amount, precision: 10, scale: 2
      t.decimal :vat_amount, precision: 10, scale: 2
      t.decimal :gross_amount, precision: 10, scale: 2
      t.float :weight, default: 0.0
      t.boolean :commission, default: false
      t.boolean :foreign_goods, default: false
      t.integer :contract_number
      t.integer :contract_position
      t.string :sales_rep, limit: 5
      t.text :comment

      # Composite primary key constraint
      t.index [ :sales_order_id, :position_number ], unique: true, name: 'idx_sales_order_line_items_pk'
      t.index :sales_order_id
      t.index :article_number
      t.index :warehouse
      t.index :department
      t.index :contract_number
      t.index :sales_rep
    end

    # Delivery Notes Table
    create_table :delivery_notes, id: :serial do |t|
      t.date :delivery_date, null: false
      t.string :operator, limit: 5
      t.string :sales_rep, limit: 5
      t.string :customer_name, limit: 30
      t.string :customer_order_number, limit: 50
      t.string :delivery_terms, limit: 80
      t.string :project, limit: 80
      t.string :delivery_type, limit: 40
      t.boolean :self_pickup, default: false
      t.boolean :printed, default: false
      t.integer :invoice_number
      t.integer :warehouse
      t.integer :truck_number
      t.string :vehicle, limit: 22
      t.string :license_plate1, limit: 12
      t.string :license_plate2, limit: 12
      t.string :time, limit: 5
      t.decimal :net_amount, precision: 10, scale: 2, default: 0.0
      t.decimal :gross_amount, precision: 10, scale: 2, default: 0.0
      t.text :delivery_info

      # Rails timestamps
      t.timestamp :created_at, precision: 6
      t.timestamp :updated_at, precision: 6

      # Foreign keys
      t.references :sales_order, foreign_key: { to_table: :sales_orders }, null: true
      t.references :customer, foreign_key: { to_table: :customers }
      t.references :customer_address, foreign_key: { to_table: :addresses }, null: true
      t.references :billing_address, foreign_key: { to_table: :addresses }, null: true
      t.references :shipping_address, foreign_key: { to_table: :addresses }, null: true

      # Indexes
      t.index :delivery_date
      t.index :printed
      t.index :self_pickup
      t.index :operator
      t.index :invoice_number
      t.index :updated_at
    end

    # Delivery Note Line Items Table
    create_table :delivery_note_line_items, id: false do |t|
      t.integer :delivery_note_id, null: false
      t.integer :position_number, null: false
      t.string :position_type, limit: 1, default: 'N'
      t.string :article_number, limit: 12
      t.string :description1, limit: 40
      t.string :description2, limit: 40
      t.text :long_text
      t.integer :sales_order_id
      t.integer :sales_order_position_number
      t.integer :warehouse
      t.integer :department
      t.float :delivered_quantity, null: false, default: 0.0
      t.integer :unit_key
      t.string :unit, limit: 5
      t.decimal :unit_price, precision: 10, scale: 4, null: false
      t.decimal :list_price, precision: 10, scale: 4
      t.float :discount_percent, default: 0.0
      t.string :discount_type, limit: 3
      t.float :vat_rate, default: 19.0
      t.decimal :net_amount, precision: 10, scale: 2, default: 0.0
      t.decimal :vat_amount, precision: 10, scale: 2, default: 0.0
      t.decimal :gross_amount, precision: 10, scale: 2, default: 0.0
      t.float :weight, default: 0.0
      t.integer :contract_number
      t.integer :contract_position
      t.string :sales_rep, limit: 5
      t.text :loading_info

      # Composite primary key constraint
      t.index [ :delivery_note_id, :position_number ], unique: true, name: 'idx_delivery_note_line_items_pk'
      t.index :delivery_note_id
      t.index :article_number
      t.index :sales_order_id
      t.index :warehouse
      t.index :department
      t.index :contract_number
      t.index :sales_rep
    end

    # Weighing Slips Table
    create_table :weighing_slips, id: :serial do |t|
      t.integer :database_id, null: false
      t.integer :weighing_slip_number, null: false
      t.integer :slip_type
      t.date :weighing_date, null: false
      t.string :time, limit: 5
      t.string :operator, limit: 5
      t.string :article_number, limit: 12
      t.string :description1, limit: 40
      t.string :description2, limit: 40
      t.datetime :first_weighing_time, precision: 6
      t.datetime :second_weighing_time, precision: 6
      t.float :first_weight
      t.float :second_weight
      t.float :net_weight
      t.float :total_weight
      t.decimal :price, precision: 10, scale: 4
      t.string :vehicle_registration, limit: 20
      t.boolean :completed, default: false
      t.string :target_slip, limit: 2
      t.integer :document_number
      t.text :info_text
      t.integer :contract_number
      t.integer :contract_position
      t.string :completion_reason, limit: 80
      t.boolean :printed, default: false

      # Rails timestamps
      t.timestamp :created_at, precision: 6
      t.timestamp :updated_at, precision: 6

      # Foreign keys
      t.references :customer, foreign_key: { to_table: :customers }, null: true
      t.references :shipping_address, foreign_key: { to_table: :addresses }, null: true
      t.references :sales_order, foreign_key: { to_table: :sales_orders }, null: true
      t.references :delivery_note, foreign_key: { to_table: :delivery_notes }, null: true

      # Indexes
      t.index :weighing_date
      t.index :weighing_slip_number, unique: true
      t.index :completed
      t.index :article_number
      t.index :vehicle_registration
      t.index :contract_number
      t.index :updated_at
    end

    # Add foreign key constraints
    add_foreign_key :sales_order_line_items, :sales_orders, column: :sales_order_id
    add_foreign_key :delivery_note_line_items, :delivery_notes, column: :delivery_note_id
    add_foreign_key :delivery_note_line_items, :sales_orders, column: :sales_order_id
  end

  def down
    drop_table :weighing_slips
    drop_table :delivery_note_line_items
    drop_table :delivery_notes
    drop_table :sales_order_line_items
    drop_table :sales_orders
    drop_table :customers
    drop_table :addresses
  end
end
