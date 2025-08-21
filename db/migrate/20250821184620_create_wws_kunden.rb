class CreateWwsKunden < ActiveRecord::Migration[8.0]

  def change
    create_table :wws_kunden, id: false do |t|
      # Primary Key
      t.integer :kundennr, null: false, primary_key: true

      # Grunddaten
      t.integer :kundgruppe
      t.integer :bundesland

      # Kontoauszug
      t.string :kontoauszug, limit: 1
      t.timestamp :datumlauszug
      t.integer :nrlauszug
      t.float :saldolauszug

      # Rechnung
      t.string :saldorechnung, limit: 1
      t.integer :lfdrechnnr
      t.integer :rechnkunde
      t.string :umsatzsteuer, limit: 1
      t.string :werbetext, limit: 1
      t.string :rechnformular, limit: 8

      # Rabatt und Zahlung
      t.float :rabatt
      t.string :zahlungart, limit: 1

      # Zinsen
      t.integer :zinstabsoll
      t.integer :zinstabhaben
      t.float :zinssatzsoll
      t.float :zinssatzhaben
      t.string :zinsbuchung, limit: 1
      t.timestamp :datumlzinsabr
      t.float :saldolzinsabr

      # Selbstabholung
      t.string :selbstabhrabatt, limit: 12
      t.float :selbstabhbetrag

      # Bonus und Mitgliedschaft
      t.string :bonusberecht, limit: 1
      t.integer :mitgliednr
      t.integer :geschkonto

      # Kündigung
      t.string :gekuendigt, limit: 1
      t.string :kuendgrund, limit: 30
      t.timestamp :datumeintritt
      t.timestamp :datumaustritt

      # Anteile
      t.integer :pflichtanteile
      t.integer :pflichtanteilegez
      t.integer :anteilgekuend1
      t.timestamp :datumkuend1
      t.integer :anteilgekuend2
      t.timestamp :datumkuend2

      # System Felder
      t.string :trans, limit: 1
      t.string :trfield, limit: 1
      t.integer :repl_id
      t.integer :repl_database

      # Weitere Geschäftsfelder
      t.string :organschaft, limit: 1
      t.string :bemerkford, limit: 1
      t.string :kontoauszug2, limit: 1
      t.integer :rechnanzahl

      # Nebenkosten
      t.float :nk_stdsatz
      t.float :nk_fahrtkosten

      # Weitere Einstellungen
      t.string :offeneposten, limit: 1
      t.float :regalflaeche
      t.string :fremdwaehrung, limit: 3
      t.string :konzernkunde, limit: 1
      t.float :gk_aufschlag
      t.float :ernte_mitglbeitrag
      t.integer :kreditorkto2

      # Lieferschein
      t.integer :rabstnr_ls
      t.string :formular_ls, limit: 12
      t.string :versandspesen, limit: 1

      # Zertifizierung
      t.string :zert_pflicht, limit: 1
      t.timestamp :zert_datum

      # Formulare
      t.string :formular_stang, limit: 12
      t.string :formular_stauf, limit: 12

      # Lieferbedingungen
      t.string :lieferbedkurz, limit: 5
      t.string :zahlbedtext, limit: 80
      t.string :zbabdatum, limit: 1

      # Versandavis
      t.integer :versandavis
      t.float :proforma_rabatt1
      t.float :proforma_rabatt2
      t.timestamp :versandavisdatum

      # Zahlungsbedingungen
      t.integer :zb_id
      t.integer :zb_dbid

      # Ernte Formulare
      t.string :formular_ernte1, limit: 12
      t.string :formular_ernte2, limit: 12
      t.string :formular_ernte3, limit: 12

      # Weitere Versandavis Einstellungen
      t.integer :versandaviseinzel
      t.string :versandavisvb, limit: 1

      # Verkaufspreise
      t.float :vkpreiszuschlagek
      t.timestamp :vkpreiszuschldatum

      # Landwirtschaftsamt
      t.integer :landwamtnr
      t.string :lwa_betriebsnr, limit: 20

      # Weitere Kontoauszüge
      t.string :kontoauszug1, limit: 1
      t.integer :kundennrschnittst

      # EDI Einstellungen
      t.string :edi_iln, limit: 15
      t.integer :edi_typ
      t.integer :edi_uebertrnr
      t.string :edi_prefix, limit: 15
      t.string :rechnsammelliste, limit: 1
      t.float :marge
      t.string :edi_iln_nad_su, limit: 15

      # Statistik
      t.integer :g12_statistik
      t.string :kundstatusw, limit: 1

      # Versicherung
      t.string :versicherung, limit: 1
      t.float :versprozent
      t.float :schwellenwert
      t.string :gutschrverr, limit: 1
      t.float :rechnlistenprov

      # Lieferbewertung
      t.integer :liefbewertung_basis
      t.integer :andavisexport
      t.integer :sprachenr

      # NABI Zertifizierung
      t.string :nabizertstelleregnr, limit: 40
      t.string :bruttoberechn, limit: 1

      # Tank Rechnung
      t.integer :tankrechnungpdf
      t.string :zblieferdat, limit: 1

      # Preise und Bonus
      t.integer :preisqzuabsortenr
      t.float :minbestellwert
      t.float :vkbonus

      # MVO Kennzeichen
      t.integer :mvo_ek_kennz
      t.integer :mvo_vk_kennz

      # Vertreterbeauftragung
      t.string :vertrbeauf1keineprov, limit: 1
      t.string :vertrbeauf2keineprov, limit: 1

      # Weitere Formulare
      t.string :formular_wiegeschein, limit: 12

      # EDI Kostenstelle
      t.integer :edi_kostenst
      t.integer :anzdruckliefersch
      t.string :sknpflschg, limit: 1
      t.string :kundennrdeuka, limit: 15
      t.string :edi_keinstorno, limit: 1

      # Selbstabrechnung
      t.string :selbstabrechner, limit: 1

      # Weitere EDI Felder
      t.string :edi_kundennr, limit: 70
      t.integer :edi_typorders
      t.integer :edi_typdesadv
      t.integer :edi_uebertrnr_desadv

      # NVE Formular
      t.string :formular_nve, limit: 12

      # Explosivnachweis
      t.string :explosivnachweis, limit: 1
      t.string :edi_iln_desadv, limit: 15

      # Kontrakt
      t.integer :kontraktzusammenstellung

      # Unternehmensgegenstand
      t.integer :id_unternehmensgegenstand
      t.integer :dbid_unternehmensgegenstand

      # Weitere Daten
      t.timestamp :explosivnachweisdatum
      t.timestamp :geaendertam
      t.integer :edi_abkommensnr
      t.string :selbstabrechnerek, limit: 1
      t.string :formular_etikett, limit: 12

      # Creditreform
      t.integer :creditreform_status
      t.timestamp :creditreform_timestamp
    end

    # Indizes für bessere Performance
    add_index :wws_kunden, :kundgruppe
    add_index :wws_kunden, :bundesland
    add_index :wws_kunden, :mitgliednr
    add_index :wws_kunden, :gekuendigt
    add_index :wws_kunden, :rechnkunde
    add_index :wws_kunden, :konzernkunde
    add_index :wws_kunden, :kundstatusw
    add_index :wws_kunden, :geaendertam
    add_index :wws_kunden, :edi_iln
    add_index :wws_kunden, :kundennrdeuka
    add_index :wws_kunden, :landwamtnr
    add_index :wws_kunden, :creditreform_status
  end

end
