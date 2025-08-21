class CreateWwsWiegeschein < ActiveRecord::Migration[8.0]
  def change
    create_table :wws_wiegeschein, id: false do |t|
      # Primary Keys
      t.integer :id, null: false, primary_key: true
      t.integer :dbid, null: false
      t.integer :wiegescheinnr, null: false

      # Basic Info
      t.integer :art
      t.timestamp :datum
      t.string :uhrzeit, limit: 5
      t.string :bediener, limit: 5

      # References
      t.integer :kundliefnr
      t.integer :kostenstelle
      t.integer :lager
      t.integer :abteilung
      t.string :artikelnr, limit: 12
      t.integer :sorten_id
      t.integer :sorten_dbid
      t.integer :kontraktnr

      # Wiegung Info
      t.integer :wiegungwaageid1
      t.integer :wiegungwaageid2
      t.timestamp :wiegungdatum1
      t.timestamp :wiegungdatum2
      t.integer :wiegungeinh
      t.string :kfz_kennzeichen, limit: 20
      t.string :trfield, limit: 1

      # Replication
      t.integer :repl_id
      t.integer :repl_database

      # Gewichte und Preise
      t.float :wiegungnetto1
      t.float :wiegungnetto2
      t.float :gewicht
      t.float :preis

      # Status und Verarbeitung
      t.integer :kontraktpos
      t.integer :status
      t.string :erledigt, limit: 1
      t.string :zielschein, limit: 2
      t.integer :belegnr

      # Weitere Wiegung Details
      t.string :wiegunguhrzeit1, limit: 5
      t.string :wiegunguhrzeit2, limit: 5
      t.text :infotext

      # Zusätzliche Referenzen
      t.integer :chargennr
      t.integer :spediteurnr
      t.integer :auftragnr
      t.integer :lagerfach
      t.string :wiegungidentnr1, limit: 100
      t.string :wiegungidentnr2, limit: 100

      # Lieferung
      t.string :liefliefschnr, limit: 10
      t.timestamp :liefdatum

      # NAWARO
      t.string :nawaro, limit: 1
      t.integer :nawaro_vertragnr

      # Bestellung
      t.integer :bestellungnr

      # Zusätzliche Lager Info
      t.integer :lager2
      t.integer :abteilung2
      t.integer :lagerfach2
      t.integer :chargennr2

      # Weitere Felder
      t.string :zielscheinfestgelegt, limit: 1
      t.integer :posnr
      t.string :ausfremdbestand, limit: 1

      # Fremdbestand
      t.integer :fb_lager
      t.integer :fb_abteilung
      t.integer :fb_lagerfach
      t.integer :fb_chargennr

      # Bezeichnungen
      t.string :muster, limit: 40
      t.string :bezeichn1, limit: 40
      t.string :bezeichn2, limit: 40

      # Weitere Fremdbestand Felder
      t.float :fb_diffmenge
      t.integer :debktohauptkd
      t.string :rechnhauptkunde, limit: 1

      # Bemerkungen und Status
      t.string :bemerkungen, limit: 80
      t.string :sperre, limit: 1

      # Zähler
      t.integer :zaehleranfang
      t.integer :zaehlerende

      # Mengen
      t.float :fuellmenge
      t.float :restmenge

      # Weitere Felder
      t.string :nabi, limit: 1
      t.integer :streckenr
      t.integer :vorgangnr
      t.integer :vorgangposnr
      t.string :qzuabpreis, limit: 1
      t.float :menge
      t.string :erledigungsgrund, limit: 80

      # NUTS
      t.integer :nuts2_id
      t.integer :nuts2_dbid

      # Weitere Business Logic
      t.string :kontraktaufteilung, limit: 1
      t.integer :liefadrnr
      t.integer :gosse
      t.string :analysefertig, limit: 1

      # Adressen
      t.integer :anliefereradrnr
      t.integer :zwhaendleradrnr
      t.integer :zwhaendlernr

      # Export und Gewichte
      t.integer :export
      t.float :sollgewicht

      # NVE
      t.integer :nve_id
      t.integer :nve_dbid
      t.integer :nveart_id
      t.integer :nveart_dbid

      # Erledigung Details
      t.string :erledigtbediener, limit: 5
      t.timestamp :erledigtdatum
      t.timestamp :erledigtuhrzeit

      # Aufträge und Bestellungen
      t.integer :auftragposnr
      t.integer :bestellungposnr

      # Import
      t.integer :importbelegnr
      t.string :importbelegart, limit: 2

      # Preise
      t.float :fb_preisfruehbezug

      # Weitere Flags
      t.string :handwiegung, limit: 1
      t.integer :lmusternr

      # Fremdbestand Belege
      t.integer :fb_belegnr
      t.integer :fb_belegposnr
      t.string :fb_belegart, limit: 2

      # Metadaten
      t.timestamp :geaendertam
      t.string :auto_druck, limit: 1
      t.string :gedruckt, limit: 1
    end

    # Indizes für bessere Performance
    add_index :wws_wiegeschein, :dbid
    add_index :wws_wiegeschein, :wiegescheinnr
    add_index :wws_wiegeschein, :datum
    add_index :wws_wiegeschein, :kundliefnr
    add_index :wws_wiegeschein, :artikelnr
    add_index :wws_wiegeschein, :kontraktnr
    add_index :wws_wiegeschein, :status
    add_index :wws_wiegeschein, :belegnr
  end
end
