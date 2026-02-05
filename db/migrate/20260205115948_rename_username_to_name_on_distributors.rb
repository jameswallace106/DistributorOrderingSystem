class RenameUsernameToNameOnDistributors < ActiveRecord::Migration[8.0]
  def change
    rename_column :distributors, :username, :name
  end
end
