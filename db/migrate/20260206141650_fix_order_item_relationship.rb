class FixOrderItemRelationship < ActiveRecord::Migration[8.0]
  def change
    remove_column :orders, :item_id, :integer

    add_reference :items, :order, null: false, foreign_key: true
  end
end
