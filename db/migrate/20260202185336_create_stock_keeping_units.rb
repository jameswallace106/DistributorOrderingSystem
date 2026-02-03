class CreateStockKeepingUnits < ActiveRecord::Migration[8.0]
  def change
    create_table :stock_keeping_units do |t|
      t.integer :price

      t.timestamps
    end
  end
end
