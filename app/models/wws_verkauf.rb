# app/models/wws_verkauf.rb
class WwsVerkauf < ApplicationRecord
  self.table_name = 'wws_verkauf1'
  self.primary_key = 'vauftragnr'

  # Associations
  belongs_to :kunde, foreign_key: 'kundennr', class_name: 'WwsKunde', optional: true
  belongs_to :kundenadresse, foreign_key: 'kundadrnr', class_name: 'Adresse', primary_key: 'nummer', optional: true
  belongs_to :rechnungsadresse, foreign_key: 'rechnadrnr', class_name: 'Adresse', primary_key: 'nummer', optional: true
  belongs_to :lieferadresse, foreign_key: 'liefadrnr', class_name: 'Adresse', primary_key: 'nummer', optional: true
  belongs_to :abholadresse, foreign_key: 'abholadrnr', class_name: 'Adresse', primary_key: 'nummer', optional: true

  has_many :positionen, foreign_key: 'vauftragnr', class_name: 'WwsVerkaufPosition', dependent: :destroy
  has_many :lieferscheine, foreign_key: 'vauftragnr', class_name: 'WwsLieferschein'
  has_many :wiegescheine, foreign_key: 'auftragnr', class_name: 'WwsWiegeschein'

  # Validations
  validates :vauftragnr, presence: true, uniqueness: true
  validates :datum, presence: true
  validates :auftstatus, inclusion: { in: %w[A B E S], message: "muss A (Angebot), B (Bestätigt), E (Erledigt) oder S (Storniert) sein" }, allow_blank: true
  validates :erledigt, inclusion: { in: %w[J N], message: "muss J oder N sein" }, allow_blank: true

  # Scopes
  scope :angebote, -> { where(auftstatus: 'A') }
  scope :aufträge, -> { where(auftstatus: 'B') }
  scope :erledigt, -> { where(erledigt: 'J') }
  scope :offen, -> { where.not(erledigt: 'J') }
  scope :im_zeitraum, ->(von, bis) { where(datum: von..bis) }
  scope :nach_bediener, ->(bediener) { where(bediener: bediener) }
  scope :nach_vertreter, ->(vertreter) { where(vertreter: vertreter) }

  # ENUM ENTFERNT - Das war das Problem!
  # Die enum Definition hat Probleme verursacht

  # Instance Methods
  def angebot?
    auftstatus == 'A'
  end

  def auftrag?
    auftstatus == 'B'
  end

  def erledigt?
    erledigt == 'J'
  end

  def offen?
    !erledigt?
  end

  def auftragswert
    positionen.sum(:brutto) || 0
  rescue
    0
  end

  def kundenname
    kundname.presence || kunde&.name || kundenadresse&.vollständiger_name
  end

  def status_text
    case auftstatus
    when 'A' then 'Angebot'
    when 'B' then 'Auftrag'
    when 'E' then 'Erledigt'
    when 'S' then 'Storniert'
    else 'Unbekannt'
    end
  end
end