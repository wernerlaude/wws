class DeliveryNote < ApplicationRecord
  self.table_name = "wws_vliefer1"
  self.primary_key = "liefschnr"

  # Associations
  belongs_to :sales_order, foreign_key: "vauftragnr", class_name: "SalesOrder", optional: true
  belongs_to :customer, foreign_key: "kundennr", class_name: "Customer", optional: true
  belongs_to :customer_address, foreign_key: "kundadrnr", class_name: "Address", primary_key: "nummer", optional: true
  belongs_to :billing_address, foreign_key: "rechnadrnr", class_name: "Address", primary_key: "nummer", optional: true
  belongs_to :shipping_address, foreign_key: "liefadrnr", class_name: "Address", primary_key: "nummer", optional: true

  has_many :line_items, foreign_key: "liefschnr", class_name: "DeliveryNoteLineItem", dependent: :destroy
  has_many :weighing_slips, foreign_key: "liefliefschnr", class_name: "WeighingSlip"

  # Validations
  validates :liefschnr, presence: true, uniqueness: true
  validates :datum, presence: true
  validates :selbstabholung, inclusion: { in: %w[J N], message: "must be J or N" }, allow_blank: true
  validates :gedruckt, inclusion: { in: %w[J N], message: "must be J or N" }, allow_blank: true

  # Scopes
  scope :printed, -> { where(gedruckt: "J") }
  scope :unprinted, -> { where.not(gedruckt: "J") }
  scope :pickup, -> { where(selbstabholung: "J") }
  scope :delivery, -> { where.not(selbstabholung: "J") }
  scope :in_period, ->(from, to) { where(datum: from..to) }
  scope :by_operator, ->(operator) { where(bediener: operator) }

  # Instance Methods
  def printed?
    gedruckt == "J"
  end

  def pickup?
    selbstabholung == "J"
  end

  def delivery?
    !pickup?
  end

  def delivery_value
    line_items.sum(&:gross_amount) || 0
  end

  def customer_name
    kundname.presence || customer&.name || customer_address&.full_name
  end

  def shipping_address_text
    shipping_address&.full_address || "Shipping address #{liefadrnr}"
  end

  def delivery_number
    liefschnr
  end

  def date
    datum
  end
end
