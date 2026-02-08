class Distributor < ApplicationRecord
  has_many :users
  has_many :stock_keeping_units
  has_many :orders

  validates :name, presence: true
end
