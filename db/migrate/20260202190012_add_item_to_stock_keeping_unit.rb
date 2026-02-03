class AddItemToStockKeepingUnit < ActiveRecord::Migration[8.0]
  def change
    add_reference :stock_keeping_units, :item, null: false, foreign_key: true
  end
end
