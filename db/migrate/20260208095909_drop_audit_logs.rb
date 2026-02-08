class DropAuditLogs < ActiveRecord::Migration[8.0]
  def change
    drop_table :audit_logs do |t|
      t.references :user, null: true, foreign_key: true
      t.string :action, null: false
      t.references :auditable, polymorphic: true, null: true
      t.text :changes
      t.string :ip_address
      t.timestamps
      
      t.index [:auditable_type, :auditable_id]
      t.index :created_at
    end
  end
end