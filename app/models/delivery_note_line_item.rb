class DeliveryNoteLineItem < ApplicationRecord
  self.table_name = "wws_vliefer2"
  self.primary_key = nil

  # Composite Key Validation
  validates :liefschnr, presence: true
  validates :posnr, presence: true
  validates_uniqueness_of :posnr, scope: :liefschnr

  # Associations
  belongs_to :delivery_note, foreign_key: "liefschnr", class_name: "DeliveryNote"

  # Validations
  validates :liefmenge, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :einhpreis, presence: true, numericality: true

  # Scopes
  scope :normal_items, -> { where(posart: [ "N", nil ]) }
  scope :by_article, ->(article) { where(artikelnr: article) }
  scope :by_warehouse, ->(warehouse) { where(lager: warehouse) }
  scope :with_quantity, -> { where("liefmenge > 0") }
  scope :for_delivery_note, ->(delivery_nr) { where(liefschnr: delivery_nr) }

  # Instance Methods
  def full_description
    [ bezeichn1, bezeichn2 ].compact.join(" ")
  end

  def net_amount
    return 0 unless delivered_quantity && unit_price
    (delivered_quantity * unit_price * (1 - (discount_percent || 0) / 100)).round(2)
  end

  def gross_amount
    return 0 unless net_amount
    (net_amount * (1 + (vat_rate || 0) / 100)).round(2)
  end

  def total_weight
    return 0 unless delivered_quantity && weight
    (delivered_quantity * weight).round(2)
  end

  def composite_key
    "#{liefschnr}-#{posnr}"
  end

  def find_sales_order_item
    return nil unless vauftragnr && vauftragposnr
    SalesOrderLineItem.find_item(vauftragnr, vauftragposnr)
  end

  # Convenience methods
  def delivered_quantity
    liefmenge
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

  def weight
    gewicht
  end

  def article_number
    artikelnr
  end

  def position_number
    posnr
  end

  def warehouse
    lager
  end

  def self.find_item(delivery_nr, position_nr)
    find_by(liefschnr: delivery_nr, posnr: position_nr)
  end
end
