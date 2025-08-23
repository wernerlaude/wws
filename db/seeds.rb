# db/seeds.rb

# Helper method to only use available attributes
def safe_attributes(model_class, attributes)
  available_columns = model_class.column_names.map(&:to_sym)
  attributes.select { |key, _| available_columns.include?(key) }
end

puts "🌱 WWS Seed Data Creation Started..."

# Only delete in development and only if tables exist
if Rails.env.development?
  puts "⚠️  Deleting existing data..."

  # Check if tables exist before deleting
  tables = ActiveRecord::Base.connection.tables

  WeighingSlip.delete_all if tables.include?('weighing_slips')
  DeliveryNoteLineItem.delete_all if tables.include?('delivery_note_line_items')
  DeliveryNote.delete_all if tables.include?('delivery_notes')
  SalesOrderLineItem.delete_all if tables.include?('sales_order_line_items')
  SalesOrder.delete_all if tables.include?('sales_orders')
  Customer.delete_all if tables.include?('customers')
  Address.delete_all if tables.include?('addresses')
end

# 1. CREATE ADDRESSES
puts "📍 Creating Addresses..."

# Check if we're using old models (with nummer) or new models (with id)
using_old_models = Address.column_names.include?('nummer')

addresses = [
  {
    name1: "Müller Agrar GmbH",
    name2: "Grain Trading",
    industry: using_old_models ? nil : "Agriculture",
    branche: using_old_models ? "Landwirtschaft" : nil,
    street: using_old_models ? nil : "Hauptstraße 15",
    strasse: using_old_models ? "Hauptstraße 15" : nil,
    country_code: using_old_models ? nil : "D",
    nat: using_old_models ? "D" : nil,
    postal_code: using_old_models ? nil : "94436",
    plz: using_old_models ? "94436" : nil,
    city: using_old_models ? nil : "Simbach",
    ort: using_old_models ? "Simbach" : nil,
    country: using_old_models ? nil : "Germany",
    land: using_old_models ? "Deutschland" : nil,
    phone1: using_old_models ? nil : "08571/12345",
    telefon1: using_old_models ? "08571/12345" : nil,
    phone2: using_old_models ? nil : "08571/12346",
    telefon2: using_old_models ? "08571/12346" : nil,
    fax: using_old_models ? nil : "08571/12347",
    telefax: using_old_models ? "08571/12347" : nil,
    email: "info@mueller-agrar.de",
    website: using_old_models ? nil : "www.mueller-agrar.de",
    homepage: using_old_models ? "www.mueller-agrar.de" : nil,
    address_type: using_old_models ? nil : "K",
    art: using_old_models ? "K" : nil,
    nummer: using_old_models ? 1001 : nil
  },
  {
    name1: "Farmer Schmidt",
    name2: "Dairy Farm",
    industry: using_old_models ? nil : "Dairy Farming",
    branche: using_old_models ? "Milchwirtschaft" : nil,
    street: using_old_models ? nil : "Dorfstraße 8",
    strasse: using_old_models ? "Dorfstraße 8" : nil,
    country_code: using_old_models ? nil : "D",
    nat: using_old_models ? "D" : nil,
    postal_code: using_old_models ? nil : "84347",
    plz: using_old_models ? "84347" : nil,
    city: using_old_models ? nil : "Pfarrkirchen",
    ort: using_old_models ? "Pfarrkirchen" : nil,
    country: using_old_models ? nil : "Germany",
    land: using_old_models ? "Deutschland" : nil,
    phone1: using_old_models ? nil : "08561/98765",
    telefon1: using_old_models ? "08561/98765" : nil,
    email: "schmidt@milchbauer.de",
    address_type: using_old_models ? nil : "K",
    art: using_old_models ? "K" : nil,
    nummer: using_old_models ? 1002 : nil
  },
  {
    name1: "Genossenschaft Rottal eG",
    name2: "Goods and Services Cooperative",
    industry: using_old_models ? nil : "Cooperative",
    branche: using_old_models ? "Genossenschaft" : nil,
    street: using_old_models ? nil : "Genossenschaftsweg 1",
    strasse: using_old_models ? "Genossenschaftsweg 1" : nil,
    country_code: using_old_models ? nil : "D",
    nat: using_old_models ? "D" : nil,
    postal_code: using_old_models ? nil : "84307",
    plz: using_old_models ? "84307" : nil,
    city: using_old_models ? nil : "Eggenfelden",
    ort: using_old_models ? "Eggenfelden" : nil,
    country: using_old_models ? nil : "Germany",
    land: using_old_models ? "Deutschland" : nil,
    phone1: using_old_models ? nil : "08721/55555",
    telefon1: using_old_models ? "08721/55555" : nil,
    phone2: using_old_models ? nil : "08721/55556",
    telefon2: using_old_models ? "08721/55556" : nil,
    fax: using_old_models ? nil : "08721/55557",
    telefax: using_old_models ? "08721/55557" : nil,
    email: "kontakt@rottal-eg.de",
    website: using_old_models ? nil : "www.rottal-eg.de",
    homepage: using_old_models ? "www.rottal-eg.de" : nil,
    address_type: using_old_models ? nil : "K",
    art: using_old_models ? "K" : nil,
    nummer: using_old_models ? 1003 : nil
  },
  {
    name1: "Weber Feed GmbH",
    name2: "Wholesale",
    industry: using_old_models ? nil : "Feed Trading",
    branche: using_old_models ? "Futtermittelhandel" : nil,
    street: using_old_models ? nil : "Industriestraße 12",
    strasse: using_old_models ? "Industriestraße 12" : nil,
    country_code: using_old_models ? nil : "D",
    nat: using_old_models ? "D" : nil,
    postal_code: using_old_models ? nil : "94474",
    plz: using_old_models ? "94474" : nil,
    city: using_old_models ? nil : "Vilshofen",
    ort: using_old_models ? "Vilshofen" : nil,
    country: using_old_models ? nil : "Germany",
    land: using_old_models ? "Deutschland" : nil,
    phone1: using_old_models ? nil : "08541/77777",
    telefon1: using_old_models ? "08541/77777" : nil,
    email: "weber@futtermittel.de",
    address_type: using_old_models ? nil : "L",
    art: using_old_models ? "L" : nil,
    nummer: using_old_models ? 1004 : nil
  },
  {
    name1: "Huber Logistics",
    name2: "Logistics & Transport",
    industry: using_old_models ? nil : "Transportation",
    branche: using_old_models ? "Spedition" : nil,
    street: using_old_models ? nil : "Logistikpark 5",
    strasse: using_old_models ? "Logistikpark 5" : nil,
    country_code: using_old_models ? nil : "D",
    nat: using_old_models ? "D" : nil,
    postal_code: using_old_models ? nil : "94032",
    plz: using_old_models ? "94032" : nil,
    city: using_old_models ? nil : "Passau",
    ort: using_old_models ? "Passau" : nil,
    country: using_old_models ? nil : "Germany",
    land: using_old_models ? "Deutschland" : nil,
    phone1: using_old_models ? nil : "0851/123456",
    telefon1: using_old_models ? "0851/123456" : nil,
    email: "huber@spedition.de",
    address_type: using_old_models ? nil : "S",
    art: using_old_models ? "S" : nil,
    nummer: using_old_models ? 1005 : nil
  }
]

created_addresses = []
addresses.each do |address_data|
  safe_data = safe_attributes(Address, address_data)
  address = Address.create!(safe_data)
  created_addresses << address
end

puts "✅ #{Address.count} Addresses created"

# 2. CREATE CUSTOMERS
puts "👥 Creating Customers..."

customers_data = [
  {
    customer_group: 1,
    state: 9, # Bavaria
    vat_liable: "J",
    terminated: "N",
    member_number: 12345,
    entry_date: 1.year.ago.to_date,
    discount_percent: 2.5,
    payment_terms: "1",
    address: created_addresses[0]
  },
  {
    customer_group: 2,
    state: 9,
    vat_liable: "J",
    terminated: "N",
    member_number: 12346,
    entry_date: 2.years.ago.to_date,
    discount_percent: 1.5,
    payment_terms: "2",
    address: created_addresses[1]
  },
  {
    customer_group: 1,
    state: 9,
    vat_liable: "J",
    terminated: "N",
    member_number: 12347,
    entry_date: 3.years.ago.to_date,
    discount_percent: 3.0,
    payment_terms: "1",
    address: created_addresses[2]
  }
]

created_customers = []
customers_data.each do |customer_data|
  safe_data = safe_attributes(Customer, customer_data)
  customer = Customer.create!(safe_data)
  created_customers << customer
end

puts "✅ #{Customer.count} Customers created"

# 3. CREATE SALES ORDERS
puts "📝 Creating Sales Orders..."

sales_orders_data = [
  {
    order_date: 1.week.ago.to_date,
    operator: "MEIER",
    sales_rep: "VT001",
    customer: created_customers[0],
    customer_address: created_customers[0].address,
    billing_address: created_customers[0].address,
    shipping_address: created_customers[0].address,
    customer_name: "Müller Agrar GmbH",
    customer_order_number: "BEST-2024-001",
    status: "B",
    completed: false,
    currency_code: 1,
    vat_code: 1,
    discount1_days: 10,
    discount1_percent: 2.0,
    discount2_days: 20,
    discount2_percent: 1.0,
    net_days: 30,
    payment_terms_text: "2% discount within 10 days",
    warehouse: 1,
    planned_delivery_date: 1.day.from_now.to_date
  },
  {
    order_date: 3.days.ago.to_date,
    operator: "WEBER",
    sales_rep: "VT002",
    customer: created_customers[1],
    customer_address: created_customers[1].address,
    billing_address: created_customers[1].address,
    shipping_address: created_customers[1].address,
    customer_name: "Farmer Schmidt",
    customer_order_number: "BEST-2024-002",
    status: "B",
    completed: false,
    currency_code: 1,
    vat_code: 1,
    discount1_days: 7,
    discount1_percent: 2.0,
    net_days: 14,
    payment_terms_text: "2% discount within 7 days",
    warehouse: 1,
    planned_delivery_date: 2.days.from_now.to_date
  },
  {
    order_date: 2.weeks.ago.to_date,
    operator: "HUBER",
    sales_rep: "VT001",
    customer: created_customers[2],
    customer_address: created_customers[2].address,
    billing_address: created_customers[2].address,
    shipping_address: created_customers[2].address,
    customer_name: "Genossenschaft Rottal eG",
    customer_order_number: "BEST-2024-003",
    status: "E",
    completed: true,
    currency_code: 1,
    vat_code: 1,
    discount1_days: 10,
    discount1_percent: 2.0,
    discount2_days: 20,
    discount2_percent: 1.0,
    net_days: 30,
    payment_terms_text: "2% discount within 10 days",
    warehouse: 1,
    planned_delivery_date: 1.week.ago.to_date
  }
]

created_sales_orders = []
sales_orders_data.each do |order_data|
  safe_data = safe_attributes(SalesOrder, order_data)
  order = SalesOrder.create!(safe_data)
  created_sales_orders << order
end

puts "✅ #{SalesOrder.count} Sales Orders created"

# 4. CREATE SALES ORDER LINE ITEMS
puts "📋 Creating Sales Order Line Items..."

line_items_data = [
  # Order 1 Items
  {
    sales_order_id: created_sales_orders[0].id,
    position_number: 10,
    position_type: "N",
    article_number: "WEIZEN001",
    description1: "Feed Wheat",
    description2: "Quality A, 13% Protein",
    quantity: 25000.0,
    unit: "kg",
    unit_price: 0.28,
    list_price: 0.30,
    discount_percent: 5.0,
    vat_rate: 19.0,
    net_amount: 6650.0,
    vat_amount: 1263.5,
    gross_amount: 7913.5,
    warehouse: 1,
    department: 1,
    weight: 1.0
  },
  {
    sales_order_id: created_sales_orders[0].id,
    position_number: 20,
    position_type: "N",
    article_number: "GERSTE001",
    description1: "Malting Barley",
    description2: "2-row, Variety Scarlett",
    quantity: 15000.0,
    unit: "kg",
    unit_price: 0.32,
    list_price: 0.35,
    discount_percent: 8.0,
    vat_rate: 19.0,
    net_amount: 4416.0,
    vat_amount: 839.04,
    gross_amount: 5255.04,
    warehouse: 1,
    department: 2,
    weight: 1.0
  },
  # Order 2 Items
  {
    sales_order_id: created_sales_orders[1].id,
    position_number: 10,
    position_type: "N",
    article_number: "FUTTER001",
    description1: "Dairy Cow Feed",
    description2: "18% Protein, pelleted",
    quantity: 5000.0,
    unit: "kg",
    unit_price: 0.45,
    list_price: 0.48,
    discount_percent: 6.0,
    vat_rate: 7.0,
    net_amount: 2115.0,
    vat_amount: 148.05,
    gross_amount: 2263.05,
    warehouse: 2,
    department: 3,
    weight: 1.0
  },
  # Order 3 Items (completed)
  {
    sales_order_id: created_sales_orders[2].id,
    position_number: 10,
    position_type: "N",
    article_number: "MAIS001",
    description1: "Grain Corn",
    description2: "14% Moisture",
    quantity: 20000.0,
    unit: "kg",
    unit_price: 0.26,
    list_price: 0.28,
    discount_percent: 7.0,
    vat_rate: 19.0,
    net_amount: 4836.0,
    vat_amount: 918.84,
    gross_amount: 5754.84,
    warehouse: 1,
    department: 1,
    weight: 1.0
  }
]

line_items_data.each do |item_data|
  safe_data = safe_attributes(SalesOrderLineItem, item_data)
  SalesOrderLineItem.create!(safe_data)
end

puts "✅ #{SalesOrderLineItem.count} Sales Order Line Items created"

# 5. CREATE DELIVERY NOTES
puts "🚚 Creating Delivery Notes..."

delivery_notes_data = [
  {
    delivery_date: 1.week.ago.to_date,
    operator: "HUBER",
    sales_rep: "VT001",
    sales_order: created_sales_orders[2],
    customer: created_customers[2],
    customer_address: created_customers[2].address,
    billing_address: created_customers[2].address,
    shipping_address: created_customers[2].address,
    customer_name: "Genossenschaft Rottal eG",
    self_pickup: false,
    printed: true,
    warehouse: 1,
    vehicle: "AB-CD 1234",
    license_plate1: "AB-CD 1234",
    time: "08:30",
    net_amount: 4836.0,
    gross_amount: 5754.84
  },
  {
    delivery_date: 2.days.ago.to_date,
    operator: "MEIER",
    sales_rep: "VT001",
    sales_order: created_sales_orders[0],
    customer: created_customers[0],
    customer_address: created_customers[0].address,
    billing_address: created_customers[0].address,
    shipping_address: created_customers[0].address,
    customer_name: "Müller Agrar GmbH",
    self_pickup: true,
    printed: true,
    warehouse: 1,
    time: "14:15",
    net_amount: 3325.0,
    gross_amount: 3956.75
  }
]

created_delivery_notes = []
delivery_notes_data.each do |delivery_data|
  safe_data = safe_attributes(DeliveryNote, delivery_data)
  delivery_note = DeliveryNote.create!(safe_data)
  created_delivery_notes << delivery_note
end

puts "✅ #{DeliveryNote.count} Delivery Notes created"

# 6. CREATE DELIVERY NOTE LINE ITEMS
puts "📦 Creating Delivery Note Line Items..."

delivery_line_items_data = [
  # Delivery Note 1 (Order 3)
  {
    delivery_note_id: created_delivery_notes[0].id,
    position_number: 10,
    sales_order_id: created_sales_orders[2].id,
    sales_order_position_number: 10,
    article_number: "MAIS001",
    description1: "Grain Corn",
    description2: "14% Moisture",
    delivered_quantity: 20000.0,
    unit: "kg",
    unit_price: 0.26,
    discount_percent: 7.0,
    vat_rate: 19.0,
    net_amount: 4836.0,
    vat_amount: 918.84,
    gross_amount: 5754.84,
    weight: 1.0,
    warehouse: 1,
    department: 1
  },
  # Delivery Note 2 (Order 1) - Partial delivery
  {
    delivery_note_id: created_delivery_notes[1].id,
    position_number: 10,
    sales_order_id: created_sales_orders[0].id,
    sales_order_position_number: 10,
    article_number: "WEIZEN001",
    description1: "Feed Wheat",
    description2: "Quality A, 13% Protein",
    delivered_quantity: 12500.0,  # Only half delivered
    unit: "kg",
    unit_price: 0.28,
    discount_percent: 5.0,
    vat_rate: 19.0,
    net_amount: 3325.0,
    vat_amount: 631.75,
    gross_amount: 3956.75,
    weight: 1.0,
    warehouse: 1,
    department: 1
  }
]

delivery_line_items_data.each do |item_data|
  safe_data = safe_attributes(DeliveryNoteLineItem, item_data)
  DeliveryNoteLineItem.create!(safe_data)
end

puts "✅ #{DeliveryNoteLineItem.count} Delivery Note Line Items created"

# 7. CREATE WEIGHING SLIPS
puts "⚖️ Creating Weighing Slips..."

weighing_slips_data = [
  {
    database_id: 1,
    weighing_slip_number: 300001,
    weighing_date: 1.week.ago.to_date,
    time: "08:45",
    operator: "WAG1",
    customer: created_customers[2],
    article_number: "MAIS001",
    description1: "Grain Corn",
    description2: "14% Moisture",
    vehicle_registration: "AB-CD 1234",
    first_weighing_time: 1.week.ago.change(hour: 8, min: 30),
    second_weighing_time: 1.week.ago.change(hour: 9, min: 15),
    first_weight: 18500.0,  # Empty weight
    second_weight: 38750.0, # Full weight
    net_weight: 20250.0,    # Net weight
    total_weight: 20250.0,
    price: 0.26,
    completed: true,
    sales_order: created_sales_orders[2],
    delivery_note: created_delivery_notes[0],
    shipping_address: created_customers[2].address
  },
  {
    database_id: 1,
    weighing_slip_number: 300002,
    weighing_date: 2.days.ago.to_date,
    time: "14:30",
    operator: "WAG1",
    customer: created_customers[0],
    article_number: "WEIZEN001",
    description1: "Feed Wheat",
    description2: "Quality A, 13% Protein",
    vehicle_registration: "EF-GH 5678",
    first_weighing_time: 2.days.ago.change(hour: 14, min: 15),
    second_weighing_time: 2.days.ago.change(hour: 14, min: 45),
    first_weight: 16800.0,  # Empty weight
    second_weight: 29380.0, # Full weight
    net_weight: 12580.0,    # Net weight
    total_weight: 12580.0,
    price: 0.28,
    completed: true,
    sales_order: created_sales_orders[0],
    delivery_note: created_delivery_notes[1],
    shipping_address: created_customers[0].address
  },
  {
    database_id: 1,
    weighing_slip_number: 300003,
    weighing_date: Date.current,
    time: "10:15",
    operator: "WAG2",
    customer: created_customers[1],
    article_number: "FUTTER001",
    description1: "Dairy Cow Feed",
    description2: "18% Protein, pelleted",
    vehicle_registration: "IJ-KL 9012",
    first_weighing_time: Date.current.beginning_of_day + 10.hours,
    first_weight: 12200.0,  # Only first weighing
    total_weight: nil,      # Not finished weighing
    price: 0.45,
    completed: false,
    sales_order: created_sales_orders[1],
    shipping_address: created_customers[1].address
  }
]

weighing_slips_data.each do |slip_data|
  safe_data = safe_attributes(WeighingSlip, slip_data)
  WeighingSlip.create!(safe_data)
end

puts "✅ #{WeighingSlip.count} Weighing Slips created"

# Summary
puts "\n🎉 Seed data successfully created!"
puts "=" * 50

counts = []
counts << "📍 Addresses: #{Address.count}" if ActiveRecord::Base.connection.table_exists?('addresses')
counts << "👥 Customers: #{Customer.count}" if ActiveRecord::Base.connection.table_exists?('customers')
counts << "📝 Sales Orders: #{SalesOrder.count}" if ActiveRecord::Base.connection.table_exists?('sales_orders')
counts << "📋 Sales Order Items: #{SalesOrderLineItem.count}" if ActiveRecord::Base.connection.table_exists?('sales_order_line_items')
counts << "🚚 Delivery Notes: #{DeliveryNote.count}" if ActiveRecord::Base.connection.table_exists?('delivery_notes')
counts << "📦 Delivery Items: #{DeliveryNoteLineItem.count}" if ActiveRecord::Base.connection.table_exists?('delivery_note_line_items')
counts << "⚖️ Weighing Slips: #{WeighingSlip.count}" if ActiveRecord::Base.connection.table_exists?('weighing_slips')

counts.each { |count| puts count }
puts "=" * 50

# Example queries demonstration
puts "\n🔍 Example Queries:"
puts "Active Customers: #{Customer.active.count}" if ActiveRecord::Base.connection.table_exists?('customers')
puts "Open Orders: #{SalesOrder.open.count}" if ActiveRecord::Base.connection.table_exists?('sales_orders')
puts "Completed Weighing Slips: #{WeighingSlip.completed.count}" if ActiveRecord::Base.connection.table_exists?('weighing_slips')

# Business data overview
if ActiveRecord::Base.connection.table_exists?('sales_orders') && ActiveRecord::Base.connection.table_exists?('sales_order_line_items')
  begin
    total_revenue = SalesOrder.joins(:line_items).sum('sales_order_line_items.gross_amount')
    puts "Total Order Revenue: €#{total_revenue.round(2)}"
  rescue => e
    puts "Total revenue could not be calculated: #{e.message}"
  end
end

puts "\n✨ Seeds completed!"
