class Product < ApplicationRecord
  has_many :stock_keeping_units
  validates :name, presence: true
end
