class AddUserIdToCommunity < ActiveRecord::Migration[7.0]
  def change
    add_column :communities, :user_id, :string, null: false
    add_foreign_key :communities, :users, column: :user_id, primary_key: :uid
  end
end
