class WwsVerkaufPosition < ApplicationRecord
  self.table_name = "wws_verkauf2"
  self.primary_key = nil  # ✅ Das ist die Lösung

  # Composite Key Validierung
  validates :vauftragnr, presence: true
  validates :posnr, presence: true
  validates_uniqueness_of :posnr, scope: :vauftragnr

  # Associations
  belongs_to :auftrag, foreign_key: "vauftragnr", class_name: "WwsVerkauf"

  # Validations
  validates :menge, presence: true, numericality: { greater_than: 0 }
  validates :einhpreis, presence: true, numericality: true
  validates :posart, inclusion: { in: %w[N T Z R], message: "muss N (Normal), T (Text), Z (Zuschlag) oder R (Rabatt) sein" }, allow_blank: true

  # Scopes
  scope :normalpositionen, -> { where(posart: ["N", nil]) }
  scope :textpositionen, -> { where(posart: "T") }
  scope :zuschläge, -> { where(posart: "Z") }
  scope :rabatte, -> { where(posart: "R") }
  scope :nach_artikel, ->(artikel) { where(artikelnr: artikel) }
  scope :nach_lager, ->(lager) { where(lager: lager) }
  scope :für_auftrag, ->(auftrag_nr) { where(vauftragnr: auftrag_nr) }

  # Instance Methods
  def normalposition?
    posart.blank? || posart == "N"
  end

  def textposition?
    posart == "T"
  end

  def zuschlag?
    posart == "Z"
  end

  def rabatt_position?
    posart == "R"
  end

  def vollständige_bezeichnung
    [bezeichn1, bezeichn2].compact.join(" ")
  end

  def nettobetrag
    return 0 unless menge && einhpreis
    (menge * einhpreis * (1 - (rabatt || 0) / 100)).round(2)
  end

  def bruttobetrag
    return 0 unless nettobetrag
    (nettobetrag * (1 + (mwstsatz || 0) / 100)).round(2)
  end

  # Composite Key Hilfsmethoden
  def self.find_position(vauftragnr, posnr)
    find_by(vauftragnr: vauftragnr, posnr: posnr)
  end

  def composite_key
    "#{vauftragnr}-#{posnr}"
  end
end