class CreateWwsVliefer1 < ActiveRecord::Migration[8.0]
  def change
    create_table :wws_vliefer1, id: false do |t|
      # Primary Key
      t.integer :liefschnr, null: false, primary_key: true

      # Verkaufsauftrag Referenz
      t.integer :vauftragnr

      # Grunddaten
      t.timestamp :datum
      t.string :einkaufverkauf, limit: 2
      t.integer :geplliefjahrkw
      t.timestamp :geplliefdatum
      t.string :bediener, limit: 5
      t.string :vertreter, limit: 5
      t.integer :kostenst

      # Kunde
      t.integer :kundennr
      t.string :kundname, limit: 30
      t.integer :rechnadrnr
      t.integer :kundadrnr
      t.integer :liefadrnr
      t.integer :debitorkto
      t.string :rechnhauptkunde, limit: 1
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
      t.string :zertifikat, limit: 1

      # Währung
      t.integer :waehrcode
      t.integer :kundwaehrcode
      t.integer :mwstkz

      # Rabatt und Beträge
      t.integer :rabattproz
      t.float :netto
      t.float :brutto

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
      t.string :selbstabholung, limit: 1
      t.string :selbstabhrabatt, limit: 12

      # Fakturfrei Felder
      t.string :faktfrei1, limit: 1
      t.string :faktfrei2, limit: 1
      t.string :gedruckt, limit: 1

      # Rechnung
      t.integer :rechnungnr
      t.integer :kundrechnart
      t.string :sammelrech, limit: 1
      t.string :dummy, limit: 1

      # System Felder
      t.string :trans, limit: 1
      t.string :trfield, limit: 1
      t.integer :repl_id
      t.integer :repl_database

      # Gutschrift
      t.string :gutschrift, limit: 1

      # Streckengeschäft
      t.integer :strecke_auftragnr
      t.integer :strecke_eliefschnr
      t.integer :strecke_erechnnr

      # Zahlung
      t.string :ratenzahlung, limit: 1
      t.string :fahrzeug, limit: 22

      # Mengen
      t.float :gesmengevorg

      # MGB (Molkereigenossenschaft Bayern)
      t.integer :mgb_ecr
      t.integer :mgb_bestellnr

      # Fremdwährung
      t.string :fremdwaehrung, limit: 3
      t.float :umrfaktor
      t.string :zblieferdat, limit: 1

      # Waage
      t.string :wiegenota, limit: 10

      # Weitere Belegnummern
      t.integer :arechnungnr
      t.integer :kbestellnr
      t.float :lizenzvetrag
      t.integer :kasse

      # Spedition
      t.integer :spediteurnr
      t.string :paritaet, limit: 80

      # Baustelle und Lieferant
      t.integer :baust_nr
      t.integer :bestellnrlief
      t.integer :lieferantnr
      t.integer :abholadrnr

      # USt-ID
      t.string :ustidmandant, limit: 15
      t.string :ustidkunde, limit: 15

      # Intrastat
      t.integer :wws_intra_meldung1_id
      t.integer :wws_intra_meldung1_dbid

      # Ursprung
      t.integer :ursprungls
      t.string :faktfrei3, limit: 1

      # Transport Details
      t.float :fahrzleergewicht
      t.string :containernr, limit: 20
      t.integer :transportart
      t.string :ladeort, limit: 30
      t.string :zbabdatum, limit: 1
      t.string :lieferbedkurz, limit: 5

      # Termine
      t.timestamp :ladedatum

      # Fahrzeug Kennzeichen
      t.string :kfzkennzeichen1, limit: 12
      t.string :kfzkennzeichen2, limit: 12

      # Kunde Auftrag
      t.string :kdauftragnr, limit: 20
      t.string :zollspedname, limit: 30

      # Versandavis
      t.timestamp :versandavisdatum
      t.text :infoliefsch

      # Hauptkunde
      t.integer :hauptkundennr
      t.string :belegartschnittstelle, limit: 5
      t.string :uhrzeit, limit: 5

      # MGB Bestellung
      t.timestamp :mgb_bestelldatum
      t.integer :ursprungsls

      # Webshop
      t.integer :webshopbest1id
      t.integer :webshopbest1dbid
      t.integer :webshopzahlungart

      # Frühbezug
      t.string :fruehbezug, limit: 1
      t.integer :repscheinnr
      t.string :kennzeichnung, limit: 20

      # Korrektur
      t.integer :rechnungnrkorrektur
      t.integer :ksvorgangnr
      t.string :bruttoberechn, limit: 1
      t.integer :liefschnrbtg
      t.string :bedienersperre, limit: 5

      # Weitere Intrastat
      t.integer :wws_intra_meldungar1_id
      t.integer :wws_intra_meldungar1_dbid

      # Fracht
      t.string :frachtartikelnr, limit: 12
      t.float :frachtpauschal
      t.float :frachtpauschal2

      # Vertreter
      t.string :vertreter2, limit: 5
      t.string :vertreter1keineprov, limit: 1
      t.string :vertreter2keineprov, limit: 1

      # Info Texte
      t.text :infoverladung

      # EDI
      t.string :edi_desadv, limit: 1

      # Organisationsbericht
      t.integer :id_org_bericht
      t.integer :dbid_org_bericht

      # Versand
      t.integer :versandart
      t.string :alseinkaufbuchen, limit: 1
      t.string :vorkasse, limit: 1

      # Ursprungsrechnung
      t.integer :rechnungnrurspr
    end

    # Indizes für bessere Performance
    add_index :wws_vliefer1, :vauftragnr
    add_index :wws_vliefer1, :datum
    add_index :wws_vliefer1, :kundennr
    add_index :wws_vliefer1, :bediener
    add_index :wws_vliefer1, :vertreter
    add_index :wws_vliefer1, :geplliefdatum
    add_index :wws_vliefer1, :rechnungnr
    add_index :wws_vliefer1, :angebotnr
    add_index :wws_vliefer1, :kostenst
    add_index :wws_vliefer1, :lager
    add_index :wws_vliefer1, :spediteurnr
    add_index :wws_vliefer1, :lieferantnr
    add_index :wws_vliefer1, :hauptkundennr
    add_index :wws_vliefer1, :gedruckt
    add_index :wws_vliefer1, :gutschrift
    add_index :wws_vliefer1, :selbstabholung
    add_index :wws_vliefer1, :ladedatum
    add_index :wws_vliefer1, :versandavisdatum
    add_index :wws_vliefer1, :webshopbest1id
    add_index :wws_vliefer1, :ursprungls
    add_index :wws_vliefer1, :kasse
    add_index :wws_vliefer1, :transportart
    add_index :wws_vliefer1, :versandart
  end
end
