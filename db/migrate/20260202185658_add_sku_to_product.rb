class AddSkuToProduct < ActiveRecord::Migration[8.0]
  def change
    add_reference :products, :stock_keeping_unit, null: false, foreign_key: true
  end
end
