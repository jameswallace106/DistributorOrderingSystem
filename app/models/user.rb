class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable

  belongs_to :distributor, optional: true
  belongs_to :admin, class_name: "User", optional: true
  has_many :managed_users, class_name: "User", foreign_key: "admin_id"

  # Done instead of using validatable because validatable requires email
  validates :username, presence: true, uniqueness: { case_sensitive: true }
  validates :password, presence: true, length: { minimum: 1 }, on: :create
  validates :password, length: { minimum: 1 }, allow_blank: true, on: :update
  def is_admin?
    is_admin
  end

  def role_name
    if is_admin
      admin ? admin.username : "Super Admin"
    else
      distributor ? distributor.name : "Unassigned"
    end
  end
end
