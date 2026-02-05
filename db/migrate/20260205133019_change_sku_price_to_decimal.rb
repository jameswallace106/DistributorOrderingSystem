class ChangeSkuPriceToDecimal < ActiveRecord::Migration[8.0]
  def change
    change_column :stock_keeping_units, :price, :decimal, precision: 10, scale: 2
  end
end
