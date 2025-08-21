class WwsKunde < ApplicationRecord
  self.table_name = "wws_kunden"
  self.primary_key = "kundennr"

  # Associations
  belongs_to :adresse, foreign_key: "kundennr", primary_key: "nummer", optional: true
  has_many :verkaufsaufträge, foreign_key: "kundennr", class_name: "WwsVerkauf"
  has_many :lieferscheine, foreign_key: "kundennr", class_name: "WwsLieferschein"
  has_many :wiegescheine, foreign_key: "kundliefnr", class_name: "WwsWiegeschein"

  # Validations
  validates :kundennr, presence: true, uniqueness: true
  validates :umsatzsteuer, inclusion: { in: %w[J N], message: "muss J oder N sein" }, allow_blank: true
  validates :gekuendigt, inclusion: { in: %w[J N], message: "muss J oder N sein" }, allow_blank: true

  # Scopes
  scope :aktiv, -> { where.not(gekuendigt: "J") }
  scope :gekündigt, -> { where(gekuendigt: "J") }
  scope :mit_umsatzsteuer, -> { where(umsatzsteuer: "J") }
  scope :nach_gruppe, ->(gruppe) { where(kundgruppe: gruppe) }
  scope :nach_bundesland, ->(bl) { where(bundesland: bl) }

  # Instance Methods
  def aktiv?
    gekuendigt != "J"
  end

  def gekündigt?
    gekuendigt == "J"
  end

  def umsatzsteuerpflichtig?
    umsatzsteuer == "J"
  end

  def mitglied?
    mitgliednr.present?
  end

  def name
    adresse&.vollständiger_name || "Kunde #{kundennr}"
  end
end