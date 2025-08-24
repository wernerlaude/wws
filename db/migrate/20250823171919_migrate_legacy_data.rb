class MigrateLegacyData < ActiveRecord::Migration[8.0]
  def up
    # Migrate Addresses
    if table_exists?('adressen') && table_exists?('addresses')
      puts "Migrating addresses from 'adressen' to 'addresses'..."

      execute <<-SQL
        INSERT INTO addresses (
          name1, name2, industry, street, country_code, postal_code, city,
          po_box, po_postal_code, po_city, phone1, phone2, fax, country,
          salutation, letter_salutation, address_type, email, website, active,
          created_at, updated_at
        )
        SELECT#{' '}
          name1,#{' '}
          name2,#{' '}
          COALESCE(lbranche, branche) as industry,
          strasse as street,
          nat as country_code,
          plz as postal_code,
          ort as city,
          postfach as po_box,
          postfplz as po_postal_code,
          postfort as po_city,
          telefon1 as phone1,
          telefon2 as phone2,
          telefax as fax,
          land as country,
          anrede as salutation,
          briefanr as letter_salutation,
          art as address_type,
          email,
          homepage as website,
          CASE WHEN erledigt = 1 THEN false ELSE true END as active,
          CURRENT_TIMESTAMP as created_at,
          CURRENT_TIMESTAMP as updated_at
        FROM adressen
        WHERE nummer IS NOT NULL
      SQL

      migrated_count = execute("SELECT COUNT(*) FROM addresses").first['count']
      puts "✅ Migrated #{migrated_count} addresses"
    end

    # Migrate Customers (if customers table exists)
    if table_exists?('wws_kunden') && table_exists?('customers')
      puts "Migrating customers from 'wws_kunden' to 'customers'..."

      execute <<-SQL
        INSERT INTO customers (
          customer_group, state, vat_liable, terminated, member_number,
          discount_percent, payment_terms, currency, entry_date, exit_date,
          created_at, updated_at, address_id
        )
        SELECT#{' '}
          kundgruppe as customer_group,
          bundesland as state,
          umsatzsteuer as vat_liable,
          gekuendigt as terminated,
          mitgliednr as member_number,
          COALESCE(rabatt, 0) as discount_percent,
          zahlungart as payment_terms,
          COALESCE(fremdwaehrung, 'EUR') as currency,
          datumeintritt as entry_date,
          datumaustritt as exit_date,
          COALESCE(geaendertam, CURRENT_TIMESTAMP) as created_at,
          COALESCE(geaendertam, CURRENT_TIMESTAMP) as updated_at,
          -- Map to new address IDs (assuming kundennr matches adressen.nummer)
          (SELECT id FROM addresses WHERE addresses.name1 = (SELECT name1 FROM adressen WHERE nummer = wws_kunden.kundennr LIMIT 1) LIMIT 1) as address_id
        FROM wws_kunden
        WHERE kundennr IS NOT NULL
      SQL

      migrated_customers = execute("SELECT COUNT(*) FROM customers").first['count']
      puts "✅ Migrated #{migrated_customers} customers"
    end

    # Migrate Sales Orders (if sales_orders table exists)
    if table_exists?('wws_verkauf1') && table_exists?('sales_orders')
      puts "Migrating sales orders from 'wws_verkauf1' to 'sales_orders'..."

      execute <<-SQL
        INSERT INTO sales_orders (
          order_date, operator, sales_rep, status, completed, customer_name,
          customer_order_number, customer_department, delivery_terms, project,
          delivery_type, currency_code, vat_code, discount1_days, discount1_percent,
          discount2_days, discount2_percent, net_days, due_date, payment_terms_text,
          warehouse, self_pickup, delivery_terms_short, planned_delivery_date,
          reference, valid_until, general_info, production_info, loading_info,
          delivery_info, created_at, updated_at, customer_id,#{' '}
          customer_address_id, billing_address_id, shipping_address_id, pickup_address_id
        )
        SELECT#{' '}
          datum as order_date,
          bediener as operator,
          vertreter as sales_rep,
          auftstatus as status,
          CASE WHEN erledigt = 'J' THEN true ELSE false END as completed,
          kundname as customer_name,
          bestnrkd as customer_order_number,
          kdabteilung as customer_department,
          liefertext as delivery_terms,
          objekt as project,
          lieferart as delivery_type,
          waehrcode as currency_code,
          mwstkz as vat_code,
          skonto1tg as discount1_days,
          skonto1pr as discount1_percent,
          skonto2tg as discount2_days,
          skonto2pr as discount2_percent,
          nettotg as net_days,
          valuta as due_date,
          zahlbedtext as payment_terms_text,
          lager as warehouse,
          CASE WHEN selbstabholer = 'J' THEN true ELSE false END as self_pickup,
          lieferbedkurz as delivery_terms_short,
          geplliefdatum as planned_delivery_date,
          bezug as reference,
          gueltigbis as valid_until,
          infoallgemein as general_info,
          infoproduktion as production_info,
          infoverladung as loading_info,
          infoliefsch as delivery_info,
          COALESCE(geaendertam, CURRENT_TIMESTAMP) as created_at,
          COALESCE(geaendertam, CURRENT_TIMESTAMP) as updated_at,
          -- Map customer
          (SELECT id FROM customers WHERE customers.address_id = (SELECT id FROM addresses WHERE addresses.name1 = (SELECT name1 FROM adressen WHERE nummer = wws_verkauf1.kundadrnr LIMIT 1) LIMIT 1) LIMIT 1) as customer_id,
          -- Map addresses
          (SELECT id FROM addresses WHERE addresses.name1 = (SELECT name1 FROM adressen WHERE nummer = wws_verkauf1.kundadrnr LIMIT 1) LIMIT 1) as customer_address_id,
          (SELECT id FROM addresses WHERE addresses.name1 = (SELECT name1 FROM adressen WHERE nummer = wws_verkauf1.rechnadrnr LIMIT 1) LIMIT 1) as billing_address_id,
          (SELECT id FROM addresses WHERE addresses.name1 = (SELECT name1 FROM adressen WHERE nummer = wws_verkauf1.liefadrnr LIMIT 1) LIMIT 1) as shipping_address_id,
          (SELECT id FROM addresses WHERE addresses.name1 = (SELECT name1 FROM adressen WHERE nummer = wws_verkauf1.abholadrnr LIMIT 1) LIMIT 1) as pickup_address_id
        FROM wws_verkauf1
        WHERE vauftragnr IS NOT NULL
      SQL

      migrated_orders = execute("SELECT COUNT(*) FROM sales_orders").first['count']
      puts "✅ Migrated #{migrated_orders} sales orders"
    end

    # Migrate Sales Order Line Items
    if table_exists?('wws_verkauf2') && table_exists?('sales_order_line_items')
      puts "Migrating sales order line items from 'wws_verkauf2' to 'sales_order_line_items'..."

      execute <<-SQL
        INSERT INTO sales_order_line_items (
          sales_order_id, position_number, position_type, article_number,
          description1, description2, long_text, article_type, sales_group,
          warehouse, department, quantity, unit_key, unit, unit_price,
          gross_price, list_price, discount_percent, discount_type, vat_rate,
          net_amount, vat_amount, gross_amount, weight, commission, foreign_goods,
          contract_number, contract_position, sales_rep, comment
        )
        SELECT#{' '}
          -- Map to new sales_order id
          (SELECT id FROM sales_orders WHERE sales_orders.order_date = (SELECT datum FROM wws_verkauf1 WHERE vauftragnr = wws_verkauf2.vauftragnr LIMIT 1)#{' '}
           AND sales_orders.customer_name = (SELECT kundname FROM wws_verkauf1 WHERE vauftragnr = wws_verkauf2.vauftragnr LIMIT 1) LIMIT 1) as sales_order_id,
          posnr as position_number,
          COALESCE(posart, 'N') as position_type,
          artikelnr as article_number,
          bezeichn1 as description1,
          bezeichn2 as description2,
          langtext as long_text,
          artikelart as article_type,
          umsatzgrp as sales_group,
          lager as warehouse,
          abteilung as department,
          menge as quantity,
          einhschl as unit_key,
          einheit as unit,
          einhpreis as unit_price,
          bruttpreis as gross_price,
          listpreis as list_price,
          COALESCE(rabatt, 0) as discount_percent,
          rabattart as discount_type,
          COALESCE(mwstsatz, 19) as vat_rate,
          COALESCE(netto, 0) as net_amount,
          COALESCE(mwst, 0) as vat_amount,
          COALESCE(brutto, 0) as gross_amount,
          COALESCE(gewicht, 0) as weight,
          CASE WHEN kommission = 'J' THEN true ELSE false END as commission,
          CASE WHEN fremdware = 'J' THEN true ELSE false END as foreign_goods,
          kontraktnr as contract_number,
          kontraktpos as contract_position,
          vertreter as sales_rep,
          kommentar as comment
        FROM wws_verkauf2
        WHERE vauftragnr IS NOT NULL AND posnr IS NOT NULL
      SQL

      migrated_line_items = execute("SELECT COUNT(*) FROM sales_order_line_items").first['count']
      puts "✅ Migrated #{migrated_line_items} sales order line items"
    end

    puts "\n🎉 Data migration completed!"
    puts "Next steps:"
    puts "1. Test the new English models: Customer.first, Address.first, etc."
    puts "2. Update your controllers to use the new models"
    puts "3. When ready, drop the old German tables"
  end

  def down
    # Clean up migrated data if needed
    execute "DELETE FROM sales_order_line_items" if table_exists?('sales_order_line_items')
    execute "DELETE FROM sales_orders" if table_exists?('sales_orders')
    execute "DELETE FROM customers" if table_exists?('customers')
    execute "DELETE FROM addresses" if table_exists?('addresses')

    puts "Migration rolled back - old data preserved in German tables"
  end
end
