class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable

  # Done instead of using validatable because validatable requires email
  validates :username, presence: true, uniqueness: { case_sensitive: false }

  def is_admin?
    is_admin
  end
end
