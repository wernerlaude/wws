class AddRailsColumnsToExistingTables < ActiveRecord::Migration[8.0]
  def up
    if table_exists?('addresses')
      add_column :addresses, :created_at, :timestamp, precision: 6 unless column_exists?(:addresses, :created_at)
      add_column :addresses, :updated_at, :timestamp, precision: 6 unless column_exists?(:addresses, :updated_at)

      execute <<-SQL
        UPDATE addresses#{' '}
        SET created_at = CURRENT_TIMESTAMP,
            updated_at = CURRENT_TIMESTAMP
        WHERE created_at IS NULL OR updated_at IS NULL
      SQL

      puts "✅ Added Rails timestamps to adressen table"
    end
    end
end
