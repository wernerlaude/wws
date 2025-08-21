class CreateWwsVliefer2 < ActiveRecord::Migration[8.0]
  def change
    create_table :wws_vliefer2, id: false do |t|
      # Composite Primary Key
      t.integer :liefschnr, null: false
      t.integer :posnr, null: false

      # Verkaufsauftrag Referenz
      t.integer :vauftragnr

      # Position Details
      t.string :posart, limit: 1
      t.string :einkaufverkauf, limit: 2
      t.string :artikelnr, limit: 12
      t.string :bezeichn1, limit: 40
      t.string :bezeichn2, limit: 40
      t.text :langtext
      t.string :langzusaet, limit: 1
      t.string :langliefer, limit: 1
      t.string :langrechn, limit: 1

      # Artikel Classification
      t.string :artikelart, limit: 4

      # Position Range
      t.integer :posnrvon
      t.integer :posnrbis

      # Calculation
      t.string :berechnart, limit: 2
      t.float :zuabschlag

      # Assignment
      t.string :vertreter, limit: 5
      t.integer :lager
      t.integer :abteilung
      t.integer :lagerfach
      t.integer :chargennr
      t.string :seriennr, limit: 40
      t.integer :kostenst
      t.integer :erlkonto
      t.integer :kontraktnr

      # Packaging
      t.float :gebindemg
      t.integer :gebindschl
      t.string :gebindeinh, limit: 5
      t.float :gebinhalt

      # Quantities
      t.float :liefmenge
      t.integer :einhschl
      t.string :einheit, limit: 5

      # Packaging Details
      t.integer :verpackmenge
      t.integer :verpackschl
      t.string :verpackeinh, limit: 5
      t.integer :preiseinh

      # Tax
      t.integer :steuerschl
      t.float :mwstsatz

      # Prices (Currency 1)
      t.float :listpreis
      t.float :listbrutto
      t.float :rabatt
      t.string :rabattart, limit: 3
      t.float :einhpreis
      t.float :bruttpreis

      # Prices (Currency 2)
      t.float :listpreis2
      t.float :listbrutto2
      t.float :einhpreis2
      t.float :bruttpreis2

      # Amounts
      t.float :netto
      t.float :mwst
      t.float :brutto
      t.float :netto2
      t.float :mwst2
      t.float :brutto2

      # Classification
      t.integer :umsatzgrp

      # Discounts
      t.integer :lsrabatt
      t.integer :rabpos_s
      t.integer :rabpos_l

      # Physical Properties
      t.float :gewicht

      # Flags
      t.string :skonto, limit: 1
      t.string :wrv, limit: 1
      t.string :bonus, limit: 1
      t.string :selbstabhrabatt, limit: 1
      t.string :pauschal, limit: 1
      t.string :fremdware, limit: 1

      # Journal/Printing
      t.integer :journaldruck
      t.integer :journalseite
      t.integer :druckspez
      t.string :druckgefahrg, limit: 1
      t.string :druckanalyse, limit: 5

      # System Fields
      t.string :dummy, limit: 1
      t.string :trfield, limit: 1
      t.integer :repl_id
      t.integer :repl_database

      # Commission
      t.string :kommission, limit: 1
      t.integer :kontraktpos

      # Serial Numbers
      t.integer :anzahlseriennr
      t.string :eingabeseriennr, limit: 1

      # Target Price
      t.float :sollpreis

      # Alternative Unit
      t.integer :altschl
      t.string :alteinheit, limit: 5
      t.float :altmenge
      t.float :altumr
      t.string :sonderpreis, limit: 1

      # Position Discount
      t.integer :rabatt_inpos
      t.integer :ruestliste

      # MGB
      t.integer :mgb_posnr

      # Foreign Currency
      t.string :fremdwaehrung, limit: 3
      t.float :umrfaktor

      # Recipe
      t.integer :rezepturnr
      t.float :reportzuschlag

      # Track/Route
      t.integer :streckenr
      t.integer :vauftragposnr
      t.integer :refnr
      t.integer :rezepturnr2
      t.string :rezeptliefer, limit: 1
      t.string :rezeptrechn, limit: 1

      # Purchase Order
      t.integer :bestellnrlief
      t.string :rabattfaehig, limit: 1

      # Surcharges
      t.string :zuabschlagnr, limit: 12
      t.string :zuabstaffel, limit: 1

      # Logistics
      t.float :ladungsgewicht
      t.integer :palettennr
      t.integer :palanzahl
      t.integer :umrpalgebinde
      t.float :umrpalmenge

      # Contract
      t.integer :kontrakttyp
      t.float :kontraktpreis
      t.float :guthverrechn

      # Codes
      t.string :eancode, limit: 15
      t.string :artikelnr_kunde, limit: 20

      # Hazardous Goods
      t.string :gefgutklasse, limit: 5
      t.integer :gefgutpunkte

      # Commission Special
      t.string :sg_kommission, limit: 1
      t.integer :bwdexport

      # Provision
      t.float :sollpreis_prov

      # Additional Discounts
      t.float :rabatt2
      t.string :rabattart2, limit: 5
      t.string :zuabschlagnr2, limit: 12

      # Settlement
      t.integer :schlschnr
      t.integer :formelnr
      t.string :ausfaktur, limit: 1
      t.string :fruehbezugerledigt, limit: 1

      # Purchase Price
      t.float :ekpreis
      t.integer :positiontyp
      t.float :zuabschlag2

      # NABI
      t.string :nabi, limit: 1
      t.string :bruttoberechn, limit: 1
      t.string :chargenaufteilung, limit: 1

      # Cashpoint
      t.integer :ksvorgangposnr
      t.integer :ksstrecke2posnr
      t.integer :anzfolgeart

      # Quality Surcharge
      t.string :qzuabpreis, limit: 1
      t.integer :qzuabsortenr
      t.float :qzuabbasispreis
      t.float :qzuabbasispreis2
      t.float :qzuabgewicht

      # Stretch Business
      t.integer :strecke_auftragposnr

      # NUTS2
      t.integer :nuts2_id
      t.integer :nuts2_dbid

      # Net Weight
      t.float :gewichtnetto

      # Tour Planning
      t.integer :id_tourenplan2
      t.integer :dbid_tourenplan2

      # Purchase Order Position
      t.integer :bestellposnrlief
      t.text :infoverladung

      # Additional Discounts (Second Currency)
      t.float :rabattw2
      t.string :rabattartw2, limit: 5
      t.float :rabatt2w2
      t.string :rabattart2w2, limit: 5

      # Additional Packaging
      t.integer :ap1gebindschl
      t.integer :pe1stamm

      # NVE (Nummer der Versandeinheit)
      t.integer :nve_id
      t.integer :nve_dbid
      t.integer :nveart_id
      t.integer :nveart_dbid

      # Disposition
      t.string :digispostyp, limit: 1

      # Sales Surcharge
      t.integer :id_vkschlag
      t.integer :dbid_vkschlag

      # Freight
      t.float :frachtpv
      t.integer :id_pv
      t.integer :dbid_pv

      # Alternative Prices
      t.integer :altpreiseinh
      t.float :alteinhpreis
      t.float :altbruttpreis
      t.float :altlistpreis
      t.float :altlistbrutto
      t.float :alteinhpreis2
      t.float :altbruttpreis2
      t.float :altlistpreis2
      t.float :altlistbrutto2

      # Sample Number
      t.integer :lmusternr

      # Article Discounts
      t.float :artrabatt1
      t.float :artrabatt2
      t.integer :artzuabschlagnr1
      t.integer :artzuabschlagnr2

      # Regular Delivery
      t.integer :reglief_id
      t.integer :reglief_dbid

      # Accounting
      t.integer :fibuabgrkonto

      # Foreign Document
      t.integer :fremdbelegnr
      t.integer :fremdbelegposnr
      t.string :fremdbelegart, limit: 2

      # Rounding
      t.string :rabattnichtrunden, limit: 1
      t.integer :bgrkomponente

      # Original Document
      t.integer :liefschnrurspr
      t.integer :posnrurspr
    end

    # Composite Primary Key
    add_index :wws_vliefer2, [:liefschnr, :posnr], unique: true, name: 'idx_vliefer2_primary'

    # Additional Indexes
    add_index :wws_vliefer2, :liefschnr
    add_index :wws_vliefer2, :vauftragnr
    add_index :wws_vliefer2, :artikelnr
    add_index :wws_vliefer2, :lager
    add_index :wws_vliefer2, :abteilung
    add_index :wws_vliefer2, :chargennr
    add_index :wws_vliefer2, :kontraktnr
    add_index :wws_vliefer2, :kontraktpos
    add_index :wws_vliefer2, :vertreter
    add_index :wws_vliefer2, :kostenst
    add_index :wws_vliefer2, :erlkonto
    add_index :wws_vliefer2, :rezepturnr
    add_index :wws_vliefer2, :bestellnrlief
    add_index :wws_vliefer2, :vauftragposnr
    add_index :wws_vliefer2, :streckenr
    add_index :wws_vliefer2, :palettennr
    add_index :wws_vliefer2, :eancode
    add_index :wws_vliefer2, :artikelnr_kunde
    add_index :wws_vliefer2, :schlschnr
    add_index :wws_vliefer2, :nve_id
    add_index :wws_vliefer2, :id_tourenplan2
    add_index :wws_vliefer2, :liefschnrurspr
  end
end
