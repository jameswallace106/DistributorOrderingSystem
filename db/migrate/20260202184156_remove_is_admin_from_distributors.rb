class RemoveIsAdminFromDistributors < ActiveRecord::Migration[8.0]
  def change
    remove_column :distributors, :is_admin, :boolean
  end
end
