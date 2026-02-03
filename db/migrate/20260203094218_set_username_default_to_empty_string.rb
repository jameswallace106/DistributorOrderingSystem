class SetUsernameDefaultToEmptyString < ActiveRecord::Migration[8.0]
  def change
    change_column_default :users, :username, ""
  end
end
