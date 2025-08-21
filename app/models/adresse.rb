class Adresse < ApplicationRecord
  self.table_name = "adressen"
  self.primary_key = "nummer"

  # Associations
  has_many :kunden, foreign_key: "kundadrnr", class_name: "WwsKunde"
  has_many :rechnungsadressen, foreign_key: "rechnadrnr", class_name: "WwsVerkauf"
  has_many :lieferadressen, foreign_key: "liefadrnr", class_name: "WwsVerkauf"
  has_many :abholadressen, foreign_key: "abholadrnr", class_name: "WwsVerkauf"

  # Validations
  validates :nummer, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, allow_blank: true
  validates :art, inclusion: { in: %w[K L S], message: "muss K (Kunde), L (Lieferant) oder S (Sonstiges) sein" }, allow_blank: true

  # Scopes
  scope :kunden, -> { where(art: "K") }
  scope :lieferanten, -> { where(art: "L") }
  scope :aktiv, -> { where.not(erledigt: 1) }

  # Instance Methods
  def vollständiger_name
    [name1, name2].compact.join(", ")
  end

  def vollständige_adresse
    parts = [strasse, "#{plz} #{ort}", land].compact
    parts.join(", ")
  end

  def haupt_telefon
    telefon1.presence || telefon2
  end
end