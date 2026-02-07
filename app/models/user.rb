class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable

  belongs_to :distributor, optional: true
  belongs_to :admin, optional: true

  before_validation :normalize_role_associations
  # Done instead of using validatable because validatable requires email
  validates :username, presence: true, uniqueness: { case_sensitive: true }
  validates :password, presence: true, length: { minimum: 1 }, on: :create
  validates :password, length: { minimum: 1 }, allow_blank: true, on: :update
  validate :exactly_one_role_association
  def is_admin?
    is_admin
  end

  def normalize_role_associations
    if is_admin
      self.distributor_id = nil
    else
      self.admin_id = nil
    end
  end


  def role_name
    if is_admin
      admin ? admin.name : ""
    else
      distributor ? distributor.name : ""
    end
  end

  
  def exactly_one_role_association
    if is_admin && distributor_id.present?
      errors.add(:distributor_id, "must be empty for admin users")
    end

    if !is_admin && admin_id.present?
      errors.add(:admin_id, "must be empty for distributor users")
    end
  end
end
