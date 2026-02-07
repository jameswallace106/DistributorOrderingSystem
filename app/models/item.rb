class Item < ApplicationRecord
  belongs_to :order
  belongs_to :stock_keeping_unit

  validates :quantity, presence: true, numericality: { greater_than: 0 }

  def total_cost
    quantity * stock_keeping_unit.price * 4800 # quantity in pallets
  end
end
