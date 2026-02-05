class RemovePasswordFromDistributors < ActiveRecord::Migration[8.0]
  def change
    remove_column :distributors, :password, :string
  end
end
