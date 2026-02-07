class Order < ApplicationRecord
  belongs_to :distributor
  has_many :items, dependent: :destroy

  accepts_nested_attributes_for :items, allow_destroy: true

  validates :required_delivery_date, presence: true
  validates :status, presence: true, inclusion: { in: %w[in-progress submitted] }

  after_initialize :set_defaults, if: :new_record?

  def total_cost
    items.sum(&:total_cost)
  end

  def submitted?
    status == "submitted"
  end

  def in_progress?
    status == "in-progress"
  end

  private

  def set_defaults
    self.status ||= "in-progress"
  end
end
