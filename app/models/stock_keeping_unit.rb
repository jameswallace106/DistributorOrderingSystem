class StockKeepingUnit < ApplicationRecord
  belongs_to :distributor
  belongs_to :product
  validates :price, presence: true
end
