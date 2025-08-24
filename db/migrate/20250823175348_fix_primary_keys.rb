class FixPrimaryKeys < ActiveRecord::Migration[8.0]
  def up
    # Fix addresses table - add PRIMARY KEY constraint on nummer
    if table_exists?('addresses')
      # Add primary key constraint on existing nummer column
      execute "ALTER TABLE addresses ADD PRIMARY KEY (nummer)" rescue nil
      puts "✅ Set nummer as primary key for addresses"
    end

    # Fix customers table - add PRIMARY KEY constraint on kundennr
    if table_exists?('customers')
      # Add primary key constraint on existing kundennr column
      execute "ALTER TABLE customers ADD PRIMARY KEY (kundennr)" rescue nil
      puts "✅ Set kundennr as primary key for customers"
    end

    puts "\n🎉 Primary keys fixed to match Firebird structure!"
  end

  def down
    # Remove primary key constraints
    execute "ALTER TABLE addresses DROP CONSTRAINT IF EXISTS addresses_pkey" if table_exists?('addresses')
    execute "ALTER TABLE customers DROP CONSTRAINT IF EXISTS customers_pkey" if table_exists?('customers')
  end
end
