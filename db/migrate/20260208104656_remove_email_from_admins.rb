class RemoveEmailFromAdmins < ActiveRecord::Migration[8.0]
  def change
    remove_column :admins, :email, :string
  end
end
