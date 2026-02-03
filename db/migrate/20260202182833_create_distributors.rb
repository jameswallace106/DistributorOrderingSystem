class CreateDistributors < ActiveRecord::Migration[8.0]
  def change
    create_table :distributors do |t|
      t.string :username
      t.string :password
      t.boolean :is_admin

      t.timestamps
    end
  end
end
