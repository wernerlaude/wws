class CreateWwsVerkauf1 < ActiveRecord::Migration[8.0]

    def change
      create_table :wws_verkauf1, id: false do |t|
        # Primary Key
        t.integer :vauftragnr, null: false, primary_key: true

        # Grunddaten
        t.timestamp :datum
        t.string :bediener, limit: 5
        t.string :vertreter, limit: 5
        t.integer :kostenst

        # Kunde
        t.integer :kundennr
        t.integer :debitorkto
        t.string :kundname, limit: 30
        t.integer :kundadrnr
        t.integer :rechnadrnr
        t.integer :liefadrnr
        t.string :gebiet, limit: 20

        # Bestellung
        t.string :best_anrede, limit: 15
        t.string :best_briefanrede, limit: 50
        t.string :besteller, limit: 30
        t.timestamp :bestdatum
        t.string :bestnrkd, limit: 50
        t.string :kdabteilung, limit: 30

        # Angebot
        t.integer :angebotnr
        t.timestamp :angebdatum

        # Lieferung
        t.string :liefertext, limit: 80
        t.string :objekt, limit: 80
        t.string :lieferart, limit: 40

        # Währung
        t.integer :waehrcode
        t.integer :kundwaehrcode
        t.integer :mwstkz

        # Zahlungsbedingungen
        t.integer :skonto1tg
        t.float :skonto1pr
        t.integer :skonto2tg
        t.float :skonto2pr
        t.integer :nettotg
        t.timestamp :valuta
        t.string :lastschrift, limit: 1
        t.string :zahlbedtext, limit: 80

        # Lager und Transport
        t.integer :lager
        t.integer :lkwnr
        t.string :selbstabhrabatt, limit: 12

        # Rechnung
        t.integer :kundrechnart
        t.string :sammelrech, limit: 1
        t.string :faktfrei1, limit: 1

        # Status
        t.string :erledigt, limit: 1
        t.string :auftstatus, limit: 1
        t.string :auftrbestgedruckt, limit: 1
        t.string :betrauftrgedruckt, limit: 1

        # Liefertermin
        t.integer :geplliefjahrkw
        t.timestamp :geplliefdatum
        t.string :verzgrund, limit: 5

        # System Felder
        t.string :trans, limit: 1
        t.string :trfield, limit: 1
        t.integer :repl_id
        t.integer :repl_database

        # Text und Ansprechpartner
        t.string :textformat, limit: 20
        t.integer :ansprnr
        t.timestamp :anfragedatum
        t.string :ratenzahlung, limit: 1
        t.integer :ansprnr2
        t.string :bezug, limit: 80

        # Angebot Details
        t.string :pauschalangebot, limit: 1
        t.timestamp :gueltigbis
        t.string :probestellung, limit: 1
        t.float :gesmengevorg

        # Info
        t.timestamp :info_datum
        t.string :info_text, limit: 40
        t.float :lizenzvetrag

        # Liefertermin Details
        t.string :liefertermintxt, limit: 50
        t.string :lieftermintext, limit: 50
        t.string :paritaet, limit: 80

        # Baustelle und Lieferant
        t.integer :baust_nr
        t.integer :bestellnrlief
        t.integer :lieferantnr
        t.integer :abholadrnr

        # Druck und Versand
        t.string :vbgrafikdrucken, limit: 1
        t.integer :schlusspapier
        t.integer :schlussemail
        t.integer :schlussfax

        # USt-ID
        t.string :ustidmandant, limit: 15
        t.string :ustidkunde, limit: 15
        t.integer :drucksortierung

        # Transport Details
        t.integer :spediteurnr
        t.string :fahrzeug, limit: 22
        t.float :fahrzleergewicht
        t.string :containernr, limit: 20
        t.integer :transportart
        t.string :ladeort, limit: 30
        t.integer :zollstelle

        # Kunde Auftrag
        t.string :kdauftragnr, limit: 20
        t.string :lieferbedkurz, limit: 5
        t.string :zbabdatum, limit: 1

        # Info Texte (BLOB)
        t.text :infoallgemein
        t.text :infoproduktion
        t.text :infoverladung
        t.text :infoliefsch
        t.text :infoauftrbest

        # Ausfuhr
        t.string :ausferklnr, limit: 10
        t.timestamp :ausferkldatum

        # Termine
        t.timestamp :prodtermin
        t.timestamp :ladetermin
        t.timestamp :ladedatum

        # Fahrzeug Details
        t.string :kfzkennzeichen1, limit: 12
        t.string :kfzkennzeichen2, limit: 12
        t.string :uhrzeit, limit: 5

        # Transport Klassifikation
        t.string :transpklasse, limit: 1
        t.string :transpmittel, limit: 20
        t.float :transpgewicht
        t.string :zollspedname, limit: 30

        # Erweiterte Produktionstermine
        t.timestamp :prodterminbis
        t.string :prodterminuhrzeit, limit: 5
        t.string :prodterminbisuhrzeit, limit: 5

        # Auftrag Status
        t.string :auftrunterschr, limit: 1
        t.timestamp :proforma_lieferdatum
        t.integer :statusproduktion
        t.string :selbstabholer, limit: 1

        # Webshop
        t.integer :webshopbest1id
        t.integer :webshopbest1dbid
        t.integer :webshopzahlungart

        # Weitere Details
        t.integer :repscheinnr
        t.timestamp :auftrunterschrdatum
        t.string :kdreferenznr, limit: 25

        # Hauptkunde
        t.integer :hauptkundennr
        t.string :rechnhauptkunde, limit: 1
        t.integer :aenderungsperre

        # Fremdwährung
        t.string :fremdwaehrung, limit: 3
        t.float :umrfaktor
        t.string :bruttoberechn, limit: 1

        # Weitere Bestellnummern
        t.integer :kbestellnr
        t.string :vb2, limit: 5
        t.string :zblieferdat, limit: 1
        t.string :bedienersperre, limit: 5

        # Fracht
        t.string :frachtartikelnr, limit: 12
        t.float :frachtpauschal
        t.float :frachtpauschal2

        # Projekt
        t.string :projektauftrag, limit: 1
        t.integer :bezugid
        t.integer :bezugdbid

        # Rabatt und Provision
        t.string :warnungrabattrefresh, limit: 1
        t.string :vertreter1keineprov, limit: 1
        t.string :vertreter2keineprov, limit: 1

        # Metadaten
        t.timestamp :geaendertam
        t.integer :vertragstyp

        # Auswertung
        t.integer :auswertselid
        t.integer :auswertseldbid

        # Erweiterte Termine
        t.string :ladeterminuhrzeit, limit: 5
        t.string :ladedatumuhrzeit, limit: 5

        # Weitere Flags
        t.string :defaultbeleg, limit: 1
        t.string :kmssperre, limit: 1
        t.integer :versandart
        t.timestamp :lieferterminbis

        # Provision und Vertreter
        t.string :vbpauschalprov, limit: 5
        t.string :vertreter2, limit: 5
        t.string :vorkasse, limit: 1

        # Schnittstellen
        t.string :l2schnittstelle, limit: 1
        t.integer :druckinstanw

        # Externe Kontaktdaten
        t.string :ext_email, limit: 255
        t.string :ext_telefon, limit: 20
        t.string :ext_name, limit: 30
        t.string :ext_vorname, limit: 30
        t.string :ext_bemerkung, limit: 255
      end

      # Indizes für bessere Performance
      add_index :wws_verkauf1, :datum
      add_index :wws_verkauf1, :kundennr
      add_index :wws_verkauf1, :bediener
      add_index :wws_verkauf1, :vertreter
      add_index :wws_verkauf1, :erledigt
      add_index :wws_verkauf1, :auftstatus
      add_index :wws_verkauf1, :bestdatum
      add_index :wws_verkauf1, :geplliefdatum
      add_index :wws_verkauf1, :angebotnr
      add_index :wws_verkauf1, :kostenst
      add_index :wws_verkauf1, :lager
      add_index :wws_verkauf1, :spediteurnr
      add_index :wws_verkauf1, :lieferantnr
      add_index :wws_verkauf1, :hauptkundennr
      add_index :wws_verkauf1, :geaendertam
      add_index :wws_verkauf1, :statusproduktion
      add_index :wws_verkauf1, :vertragstyp
      add_index :wws_verkauf1, :kdauftragnr
      add_index :wws_verkauf1, :kdreferenznr
    end

end
