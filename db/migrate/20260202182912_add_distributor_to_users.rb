class AddDistributorToUsers < ActiveRecord::Migration[8.0]
  def change
    add_reference :users, :distributor, null: true, foreign_key: true
  end
end
