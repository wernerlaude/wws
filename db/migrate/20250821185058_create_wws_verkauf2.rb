class CreateWwsVerkauf2 < ActiveRecord::Migration[8.0]

  def change
    create_table :wws_verkauf2, id: false do |t|
      # Composite Primary Key
      t.integer :vauftragnr, null: false
      t.integer :posnr, null: false

      # Position Details
      t.string :posart, limit: 1
      t.string :artikelnr, limit: 12
      t.string :bezeichn1, limit: 40
      t.string :bezeichn2, limit: 40
      t.text :langtext
      t.string :langzusaet, limit: 1
      t.string :langliefer, limit: 1
      t.string :langrechn, limit: 1

      # Artikel Classification
      t.string :artikelart, limit: 4
      t.integer :umsatzgrp

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
      t.float :menge
      t.float :bishliefmg
      t.integer :einhschl
      t.string :einheit, limit: 5
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
      t.float :netto
      t.float :mwst
      t.float :brutto

      # Prices (Currency 2)
      t.float :listpreis2
      t.float :listbrutto2
      t.float :einhpreis2
      t.float :bruttpreis2
      t.float :netto2
      t.float :mwst2
      t.float :brutto2

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

      # System Fields
      t.string :trans, limit: 1
      t.string :trfield, limit: 1
      t.integer :repl_id
      t.integer :repl_database

      # Long Text Flags
      t.string :langangebot, limit: 1
      t.string :langauftrag, limit: 1
      t.string :kommission, limit: 1

      # Contract
      t.integer :kontraktpos
      t.float :sollpreis

      # Alternative Unit
      t.integer :altschl
      t.string :alteinheit, limit: 5
      t.float :altmenge
      t.float :altumr
      t.string :sonderpreis, limit: 1

      # Recipe/Production
      t.integer :rezepturnr
      t.string :prod_erledigt, limit: 1
      t.integer :rezepturnr2
      t.integer :ruestliste
      t.string :rezeptangebot, limit: 1
      t.string :rezeptauftrag, limit: 1
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

      # Payment Terms (Position Level)
      t.integer :skonto1tg
      t.float :skonto1pr
      t.integer :skonto2tg
      t.float :skonto2pr
      t.integer :nettotg

      # Minimum Order
      t.float :auftragmindestmenge

      # Comments
      t.text :kommentar
      t.text :infoverladung
      t.text :infoproduktion

      # Production
      t.string :rezeptproduktion, limit: 1
      t.integer :produktionsauftragid
      t.integer :kontrakttyp
      t.float :kontraktpreis
      t.integer :prodanlage
      t.integer :vorprodanlage

      # Printing
      t.string :artikelnraufdruck, limit: 12
      t.string :textaufdruck, limit: 50
      t.string :sg_kommission, limit: 1
      t.string :druckgefahrg, limit: 1
      t.string :druckanalyse, limit: 5
      t.integer :druckspez

      # Provision
      t.float :sollpreis_prov

      # Additional Discounts
      t.float :rabatt2
      t.string :rabattart2, limit: 5
      t.string :zuabschlagnr2, limit: 12

      # Hazardous Goods
      t.string :gefgutklasse, limit: 5
      t.integer :gefgutpunkte

      # Purchase Price
      t.float :ekpreis
      t.integer :reparatur
      t.float :zuabschlag2
      t.integer :artikeltextfix

      # NABI
      t.string :nabi, limit: 1
      t.string :bruttoberechn, limit: 1
      t.string :chargenaufteilung, limit: 1

      # Production Parameters
      t.integer :prodparnr
      t.integer :soheberechn
      t.float :sohepreis
      t.integer :reznralternativ
      t.integer :anzfolgeart
      t.integer :langtextgrafikzusaet

      # Order References
      t.integer :aubelegnr
      t.integer :kommissionierungstatus

      # NUTS2
      t.integer :nuts2_id
      t.integer :nuts2_dbid

      # Net Weight
      t.float :gewichtnetto

      # Tour Planning
      t.integer :id_tourenplan2
      t.integer :dbid_tourenplan2

      # Calculation Costs
      t.float :kalkkosten
      t.integer :picklistnr
      t.integer :bestellposnrlief

      # Additional Discounts (Second Currency)
      t.float :rabattw2
      t.string :rabattartw2, limit: 5
      t.float :rabatt2w2
      t.string :rabattart2w2, limit: 5

      # Additional Packaging
      t.integer :ap1gebindschl
      t.integer :pe1stamm
      t.string :digispostyp, limit: 1

      # Sales Surcharge
      t.integer :id_vkschlag
      t.integer :dbid_vkschlag
      t.string :schnittstexport, limit: 1

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

      # New Customer Provision
      t.string :neukundenprovision, limit: 1
      t.integer :lmusternr

      # Article Discounts
      t.float :artrabatt1
      t.float :artrabatt2
      t.integer :artzuabschlagnr1
      t.integer :artzuabschlagnr2

      # Regular Delivery
      t.integer :reglief_id
      t.integer :reglief_dbid
      t.string :aufabschlagrech, limit: 1

      # Silo
      t.integer :silo_id
      t.integer :silo_dbid
      t.integer :folgeposvon
      t.integer :fibuabgrkonto
      t.integer :silonummer
      t.string :silobezeichnung, limit: 255

      # Rounding
      t.string :rabattnichtrunden, limit: 1
      t.integer :bgrkomponente
    end

    # Composite Primary Key
    add_index :wws_verkauf2, [:vauftragnr, :posnr], unique: true, name: 'idx_verkauf2_primary'

    # Additional Indexes
    add_index :wws_verkauf2, :vauftragnr
    add_index :wws_verkauf2, :artikelnr
    add_index :wws_verkauf2, :lager
    add_index :wws_verkauf2, :abteilung
    add_index :wws_verkauf2, :chargennr
    add_index :wws_verkauf2, :kontraktnr
    add_index :wws_verkauf2, :kontraktpos
    add_index :wws_verkauf2, :vertreter
    add_index :wws_verkauf2, :kostenst
    add_index :wws_verkauf2, :erlkonto
    add_index :wws_verkauf2, :rezepturnr
    add_index :wws_verkauf2, :produktionsauftragid
    add_index :wws_verkauf2, :bestellnrlief
    add_index :wws_verkauf2, :prodanlage
    add_index :wws_verkauf2, :kommissionierungstatus
    add_index :wws_verkauf2, :picklistnr
    add_index :wws_verkauf2, :silo_id
  end

end
