class CreateCharacters < ActiveRecord::Migration[7.0]
  def change
    create_table :characters, id: false do |t|
      t.string :id, null: false, primary_key: true
      t.string :name, limit: 20, null: false
      t.text :profile
      t.string :user_id

      t.timestamps
    end
    add_foreign_key :characters, :users, column: :user_id, primary_key: :uid, on_delete: :cascade
  end
end
