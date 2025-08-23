class Customer < ApplicationRecord
  self.table_name  = "customers"
  self.primary_key = "kundennr"

  has_one :address,
          foreign_key: :nummer,
          primary_key: :kundennr,
          inverse_of: :customer,
          dependent: :nullify

  # ‘J’/‘N’-Flags als deutsche Enums
  enum :umsatzsteuer, { ja: "J", nein: "N" }, suffix: true
  enum :gekuendigt,   { ja: "J", nein: "N" },  suffix: true

  # Validierungen
  validates :kundennr, presence: true, uniqueness: true
  validates :umsatzsteuer, inclusion: { in: %w[J N] }, allow_nil: true
  validates :gekuendigt,   inclusion: { in: %w[J N] }, allow_nil: true

  # Scopes (deutsch)
  scope :aktiv,        -> { where.not(gekuendigt: "J") }
  scope :gekündigt,    -> { where(gekuendigt: "J") }
  scope :mit_ust,      -> { where(umsatzsteuer: "J") }
  scope :nach_gruppe,  ->(g) { where(kundgruppe: g) }
  scope :nach_bundesland, ->(b) { where(bundesland: b) }

  # Delegation (deutsche Methoden)
  delegate :voller_name, :anschrift_komplett, :email, :telefon1, :telefon2,
           to: :address, allow_nil: true

  # Komfort/Domainlogik (deutsch)
  def name
    address&.voller_name || "Kunde #{kundennr}"
  end

  def aktiv?
    gekuendigt != "J"
  end

  def umsatzsteuerpflichtig?
    umsatzsteuer == "J"
  end

  def mitglied?
    mitgliednr.present?
  end

  # numerische/sonstige Felder bleiben deutsch
  def waehrung
    fremdwaehrung.presence || "EUR"
  end

  def rabatt_prozent
    rabatt
  end

  def zahlungsbedingungen
    zahlungart
  end
end
