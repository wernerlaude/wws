class WwsLieferscheinPosition < ApplicationRecord
  self.table_name = 'wws_vliefer2'
  self.primary_key = nil  # ✅ Das ist die Lösung

  # Composite Key Validierung
  validates :liefschnr, presence: true
  validates :posnr, presence: true
  validates_uniqueness_of :posnr, scope: :liefschnr

  # Associations
  belongs_to :lieferschein, foreign_key: 'liefschnr', class_name: 'WwsLieferschein'

  # Validations
  validates :liefmenge, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :einhpreis, presence: true, numericality: true

  # Scopes
  scope :normalpositionen, -> { where(posart: ['N', nil]) }
  scope :nach_artikel, ->(artikel) { where(artikelnr: artikel) }
  scope :nach_lager, ->(lager) { where(lager: lager) }
  scope :mit_menge, -> { where('liefmenge > 0') }
  scope :für_lieferschein, ->(liefer_nr) { where(liefschnr: liefer_nr) }

  # Instance Methods
  def vollständige_bezeichnung
    [bezeichn1, bezeichn2].compact.join(' ')
  end

  def nettobetrag
    return 0 unless liefmenge && einhpreis
    (liefmenge * einhpreis * (1 - (rabatt || 0) / 100)).round(2)
  end

  def bruttobetrag
    return 0 unless nettobetrag
    (nettobetrag * (1 + (mwstsatz || 0) / 100)).round(2)
  end

  def gesamtgewicht
    return 0 unless liefmenge && gewicht
    (liefmenge * gewicht).round(2)
  end

  # Composite Key Hilfsmethoden
  def self.find_position(liefschnr, posnr)
    find_by(liefschnr: liefschnr, posnr: posnr)
  end

  def composite_key
    "#{liefschnr}-#{posnr}"
  end

  # Hilfsmethode um Auftragsposition zu finden
  def find_auftragsposition
    return nil unless vauftragnr && vauftragposnr
    WwsVerkaufPosition.find_position(vauftragnr, vauftragposnr)
  end
end