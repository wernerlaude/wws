class SalesOrderLineItem < ApplicationRecord
  self.table_name = "wws_verkauf2"
  self.primary_key = nil

  # Composite Key Validation
  validates :vauftragnr, presence: true
  validates :posnr, presence: true
  validates_uniqueness_of :posnr, scope: :vauftragnr

  # Associations
  belongs_to :sales_order, foreign_key: "vauftragnr", class_name: "SalesOrder"

  # Validations
  validates :menge, presence: true, numericality: { greater_than: 0 }
  validates :einhpreis, presence: true, numericality: true
  validates :posart, inclusion: { in: %w[N T Z R], message: "must be N (Normal), T (Text), Z (Surcharge) or R (Discount)" }, allow_blank: true

  # Scopes
  scope :normal_items, -> { where(posart: [ "N", nil ]) }
  scope :text_items, -> { where(posart: "T") }
  scope :surcharges, -> { where(posart: "Z") }
  scope :discounts, -> { where(posart: "R") }
  scope :by_article, ->(article) { where(artikelnr: article) }
  scope :by_warehouse, ->(warehouse) { where(lager: warehouse) }
  scope :for_order, ->(order_nr) { where(vauftragnr: order_nr) }

  # Instance Methods
  def normal_item?
    posart.blank? || posart == "N"
  end

  def text_item?
    posart == "T"
  end

  def surcharge?
    posart == "Z"
  end

  def discount_item?
    posart == "R"
  end

  def full_description
    [ bezeichn1, bezeichn2 ].compact.join(" ")
  end

  def net_amount
    return 0 unless quantity && unit_price
    (quantity * unit_price * (1 - (discount_percent || 0) / 100)).round(2)
  end

  def gross_amount
    return 0 unless net_amount
    (net_amount * (1 + (vat_rate || 0) / 100)).round(2)
  end

  def composite_key
    "#{vauftragnr}-#{posnr}"
  end

  # Convenience methods for German field names
  def quantity
    menge
  end

  def unit_price
    einhpreis
  end

  def discount_percent
    rabatt
  end

  def vat_rate
    mwstsatz
  end

  def article_number
    artikelnr
  end

  def position_number
    posnr
  end

  def position_type
    posart
  end

  def warehouse
    lager
  end

  def self.find_item(order_nr, position_nr)
    find_by(vauftragnr: order_nr, posnr: position_nr)
  end
end
