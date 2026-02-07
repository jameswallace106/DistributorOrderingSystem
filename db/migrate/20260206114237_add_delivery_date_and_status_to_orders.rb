class AddDeliveryDateAndStatusToOrders < ActiveRecord::Migration[8.0]
  def change
    add_column :orders, :required_delivery_date, :date
    add_column :orders, :status, :string
  end
end
