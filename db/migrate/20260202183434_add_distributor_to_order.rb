class AddDistributorToOrder < ActiveRecord::Migration[8.0]
  def change
    add_reference :orders, :distributor, null: false, foreign_key: true
  end
end
