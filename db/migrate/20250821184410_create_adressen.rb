class CreateAdressen < ActiveRecord::Migration[8.0]

    def change
      create_table :adressen, id: false do |t|
        # Primary Key
        t.integer :nummer, null: false, primary_key: true

        # Namen
        t.string :name1, limit: 30
        t.string :name2, limit: 30
        t.string :branche, limit: 40

        # Adresse
        t.string :strasse, limit: 42
        t.string :nat, limit: 3
        t.string :plz, limit: 10
        t.string :ort, limit: 40

        # Postfach
        t.string :postfach, limit: 10
        t.string :postfplz, limit: 8
        t.string :postfort, limit: 30

        # Kontaktdaten
        t.string :telefon1, limit: 20
        t.string :telefon2, limit: 20
        t.string :telefax, limit: 20
        t.string :land, limit: 40

        # Anrede und Brief
        t.string :anrede, limit: 15
        t.string :briefanr, limit: 50

        # Typ und Klassifikation
        t.string :art, limit: 1
        t.integer :knr

        # Freie Felder
        t.integer :frei1, limit: 2
        t.integer :frei2, limit: 2
        t.string :frei3, limit: 10
        t.string :frei4, limit: 30

        # Flags
        t.string :trans, limit: 1

        # Digitale Kontakte
        t.string :email, limit: 255
        t.string :homepage, limit: 60

        # System Felder
        t.string :trfield, limit: 1
        t.integer :repl_id
        t.integer :repl_database

        # Lange Namen/Beschreibungen
        t.string :lname1, limit: 100
        t.string :lname2, limit: 100
        t.string :lbranche, limit: 100

        # Status
        t.integer :erledigt
      end

      # Indizes für bessere Performance
      add_index :adressen, :name1
      add_index :adressen, :plz
      add_index :adressen, :ort
      add_index :adressen, :art
      add_index :adressen, :knr
      add_index :adressen, :email
      add_index :adressen, :erledigt
    end

end
