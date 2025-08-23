class Address < ApplicationRecord
  self.table_name  = "addresses"
  self.primary_key = "nummer"

  # Beziehungen
  belongs_to :customer,
             foreign_key: :nummer,   # addresses.nummer → customers.kundennr
             primary_key: :kundennr,
             inverse_of: :address,
             optional: true

  # Enums (deutsche Schlüssel, alte 1-Buchstabenwerte bleiben erhalten)
  enum :art, { kunde: "K", lieferant: "L", sonstig: "S" }, prefix: :art

  # Validierungen (rein deutsch)
  validates :nummer, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, allow_blank: true
  validates :art, inclusion: { in: %w[K L S] }, allow_nil: true

  # Scopes (deutsch)
  scope :kunden,     -> { where(art: "K") }
  scope :lieferanten, -> { where(art: "L") }
  scope :aktiv,      -> { where.not(erledigt: 1) }

  before_validation do
    self.email    = email.to_s.strip.downcase.presence
    self.homepage = homepage.to_s.strip.presence
  end

  # Anzeige-/Komfortmethoden (deutsch)
  def voller_name
    [ name1, name2 ].compact_blank.join(", ")
  end

  def anschrift_komplett
    [ strasse, [ plz, ort ].compact_blank.join(" "), land ].compact_blank.join(", ")
  end

  def telefon_prio
    telefon1.presence || telefon2
  end

  def aktiv?
    erledigt != 1
  end
end
