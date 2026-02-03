class FixForeignKeys < ActiveRecord::Migration[8.0]
  def change
    remove_foreign_key :distributors, :stock_keeping_units
    remove_column :distributors, :stock_keeping_unit_id, :integer

    add_column :stock_keeping_units, :distributor_id, :integer, null: false
    add_index :stock_keeping_units, :distributor_id
    add_foreign_key :stock_keeping_units, :distributors

    remove_foreign_key :products, :stock_keeping_units
    remove_column :products, :stock_keeping_unit_id, :integer

    add_column :stock_keeping_units, :product_id, :integer, null: false
    add_index :stock_keeping_units, :product_id
    add_foreign_key :stock_keeping_units, :products

    remove_foreign_key :stock_keeping_units, :items
    remove_column :stock_keeping_units, :item_id

    add_column :items, :stock_keeping_unit_id, :integer
    add_index :items, :stock_keeping_unit_id
    add_foreign_key :items, :stock_keeping_units
  end
end
