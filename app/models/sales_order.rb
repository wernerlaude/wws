class SalesOrder < ApplicationRecord
  self.table_name = "wws_verkauf1"
  self.primary_key = "vauftragnr"

  # Associations
  belongs_to :customer, foreign_key: "kundennr", class_name: "Customer", optional: true
  belongs_to :customer_address, foreign_key: "kundadrnr", class_name: "Address", primary_key: "nummer", optional: true
  belongs_to :billing_address, foreign_key: "rechnadrnr", class_name: "Address", primary_key: "nummer", optional: true
  belongs_to :shipping_address, foreign_key: "liefadrnr", class_name: "Address", primary_key: "nummer", optional: true
  belongs_to :pickup_address, foreign_key: "abholadrnr", class_name: "Address", primary_key: "nummer", optional: true

  has_many :line_items, foreign_key: "vauftragnr", class_name: "SalesOrderLineItem", dependent: :destroy
  has_many :delivery_notes, foreign_key: "vauftragnr", class_name: "DeliveryNote"
  has_many :weighing_slips, foreign_key: "auftragnr", class_name: "WeighingSlip"

  # Validations
  validates :vauftragnr, presence: true, uniqueness: true
  validates :datum, presence: true
  validates :auftstatus, inclusion: { in: %w[A B E S], message: "must be A (Quote), B (Confirmed), E (Completed) or S (Cancelled)" }, allow_blank: true
  validates :erledigt, inclusion: { in: %w[J N], message: "must be J or N" }, allow_blank: true

  # Scopes
  scope :quotes, -> { where(auftstatus: "A") }
  scope :orders, -> { where(auftstatus: "B") }
  scope :completed, -> { where(erledigt: "J") }
  scope :open, -> { where.not(erledigt: "J") }
  scope :in_period, ->(from, to) { where(datum: from..to) }
  scope :by_operator, ->(operator) { where(bediener: operator) }
  scope :by_representative, ->(rep) { where(vertreter: rep) }

  # Instance Methods
  def quote?
    auftstatus == "A"
  end

  def order?
    auftstatus == "B"
  end

  def completed?
    erledigt == "J"
  end

  def open?
    !completed?
  end

  def order_value
    line_items.sum(:brutto) || 0
  rescue
    0
  end

  def customer_name
    kundname.presence || customer&.name || customer_address&.full_name
  end

  def status_text
    case auftstatus
    when "A" then "Quote"
    when "B" then "Order"
    when "E" then "Completed"
    when "S" then "Cancelled"
    else "Unknown"
    end
  end

  def order_number
    vauftragnr
  end

  def date
    datum
  end
end
