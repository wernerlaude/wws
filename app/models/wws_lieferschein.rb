class WwsLieferschein < ApplicationRecord
  self.table_name = 'wws_vliefer1'
  self.primary_key = 'liefschnr'

  # Associations
  belongs_to :auftrag, foreign_key: 'vauftragnr', class_name: 'WwsVerkauf', optional: true
  belongs_to :kunde, foreign_key: 'kundennr', class_name: 'WwsKunde', optional: true
  belongs_to :kundenadresse, foreign_key: 'kundadrnr', class_name: 'Adresse', primary_key: 'nummer', optional: true
  belongs_to :rechnungsadresse, foreign_key: 'rechnadrnr', class_name: 'Adresse', primary_key: 'nummer', optional: true
  belongs_to :lieferadresse, foreign_key: 'liefadrnr', class_name: 'Adresse', primary_key: 'nummer', optional: true

  has_many :positionen, foreign_key: 'liefschnr', class_name: 'WwsLieferscheinPosition', dependent: :destroy
  has_many :wiegescheine, foreign_key: 'liefliefschnr', class_name: 'WwsWiegeschein'

  # Validations
  validates :liefschnr, presence: true, uniqueness: true
  validates :datum, presence: true
  validates :selbstabholung, inclusion: { in: %w[J N], message: "muss J oder N sein" }, allow_blank: true
  validates :gedruckt, inclusion: { in: %w[J N], message: "muss J oder N sein" }, allow_blank: true

  # Scopes
  scope :gedruckt, -> { where(gedruckt: 'J') }
  scope :ungedruckt, -> { where.not(gedruckt: 'J') }
  scope :selbstabholer, -> { where(selbstabholung: 'J') }
  scope :versand, -> { where.not(selbstabholung: 'J') }
  scope :im_zeitraum, ->(von, bis) { where(datum: von..bis) }
  scope :nach_bediener, ->(bediener) { where(bediener: bediener) }

  # Instance Methods
  def gedruckt?
    gedruckt == 'J'
  end

  def selbstabholung?
    selbstabholung == 'J'
  end

  def versand?
    !selbstabholung?
  end

  def lieferwert
    positionen.sum(&:bruttobetrag) || 0
  end

  def kundenname
    kundname.presence || kunde&.name || kundenadresse&.vollständiger_name
  end

  def lieferadresse_text
    lieferadresse&.vollständige_adresse || "Lieferadresse #{liefadrnr}"
  end
end