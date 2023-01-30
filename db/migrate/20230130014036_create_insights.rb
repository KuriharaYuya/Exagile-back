class CreateInsights < ActiveRecord::Migration[7.0]
  def change
    create_table :insights, id: false do |t|
      t.string :id, null: false, primary_key: true
      t.string :user_id, null: false
      t.string :title, limit: 60, null: false
      t.text :content
      t.string :appoint_id, null: false
      t.boolean :archived, default: false

      t.timestamps
    end
    add_foreign_key :insights, :appoints, column: :appoint_id, primary_key: :id
    add_foreign_key :insights, :users, column: :user_id, primary_key: :uid
  end
end
