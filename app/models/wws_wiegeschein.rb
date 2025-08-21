class WwsWiegeschein < ApplicationRecord
  self.table_name = 'wws_wiegeschein'
  self.primary_key = 'id'

  # Associations
  belongs_to :kunde, foreign_key: 'kundliefnr', class_name: 'WwsKunde', optional: true  # WwsKunde statt WwsKunde1
  belongs_to :lieferadresse, foreign_key: 'liefadrnr', class_name: 'Adresse', primary_key: 'nummer', optional: true
  belongs_to :auftrag, foreign_key: 'auftragnr', class_name: 'WwsVerkauf', optional: true  # ✅
  belongs_to :lieferschein, foreign_key: 'liefliefschnr', class_name: 'WwsLieferschein', optional: true  # ✅

  # Validations
  validates :id, presence: true, uniqueness: true
  validates :dbid, presence: true
  validates :wiegescheinnr, presence: true, uniqueness: true
  validates :datum, presence: true
  validates :gewicht, numericality: { greater_than_or_equal_to: 0 }, allow_blank: true
  validates :erledigt, inclusion: { in: %w[J N], message: "muss J oder N sein" }, allow_blank: true

  # Scopes
  scope :erledigt, -> { where(erledigt: 'J') }
  scope :offen, -> { where.not(erledigt: 'J') }
  scope :im_zeitraum, ->(von, bis) { where(datum: von..bis) }
  scope :nach_artikel, ->(artikel) { where(artikelnr: artikel) }
  scope :nach_fahrzeug, ->(kfz) { where(kfz_kennzeichen: kfz) }

  # Instance Methods
  def erledigt?
    erledigt == 'J'
  end

  def offen?
    !erledigt?
  end

  def nettogewicht
    return nil unless wiegungnetto1 && wiegungnetto2
    (wiegungnetto2 - wiegungnetto1).abs
  end

  def vollständige_bezeichnung  # vollständige statt vollstÃ¤ndige
    [bezeichn1, bezeichn2].compact.join(' ')
  end

  def wiegevorgang_komplett?
    wiegungdatum1.present? && wiegungdatum2.present? &&
      wiegungnetto1.present? && wiegungnetto2.present?
  end

  def gesamtwert
    return 0 unless gewicht && preis
    (gewicht * preis).round(2)
  end
end