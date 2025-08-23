class WeighingSlip < ApplicationRecord
  self.table_name = "wws_wiegeschein"
  self.primary_key = "id"

  # Associations
  belongs_to :customer, foreign_key: "kundliefnr", class_name: "Customer", optional: true
  belongs_to :shipping_address, foreign_key: "liefadrnr", class_name: "Address", primary_key: "nummer", optional: true
  belongs_to :sales_order, foreign_key: "auftragnr", class_name: "SalesOrder", optional: true
  belongs_to :delivery_note, foreign_key: "liefliefschnr", class_name: "DeliveryNote", optional: true

  # Validations
  validates :id, presence: true, uniqueness: true
  validates :dbid, presence: true
  validates :wiegescheinnr, presence: true, uniqueness: true
  validates :datum, presence: true
  validates :gewicht, numericality: { greater_than_or_equal_to: 0 }, allow_blank: true
  validates :erledigt, inclusion: { in: %w[J N], message: "must be J or N" }, allow_blank: true

  # Scopes
  scope :completed, -> { where(erledigt: "J") }
  scope :open, -> { where.not(erledigt: "J") }
  scope :in_period, ->(from, to) { where(datum: from..to) }
  scope :by_article, ->(article) { where(artikelnr: article) }
  scope :by_vehicle, ->(vehicle) { where(kfz_kennzeichen: vehicle) }

  # Instance Methods
  def completed?
    erledigt == "J"
  end

  def open?
    !completed?
  end

  def net_weight
    return nil unless wiegungnetto1 && wiegungnetto2
    (wiegungnetto2 - wiegungnetto1).abs
  end

  def full_description
    [ bezeichn1, bezeichn2 ].compact.join(" ")
  end

  def weighing_complete?
    wiegungdatum1.present? && wiegungdatum2.present? &&
      wiegungnetto1.present? && wiegungnetto2.present?
  end

  def total_value
    return 0 unless weight && price
    (weight * price).round(2)
  end

  # Convenience methods
  def weighing_slip_number
    wiegescheinnr
  end

  def date
    datum
  end

  def weight
    gewicht
  end

  def price
    preis
  end

  def article_number
    artikelnr
  end

  def vehicle_registration
    kfz_kennzeichen
  end
end
