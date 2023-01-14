class CreateTopics < ActiveRecord::Migration[7.0]
  def change
    create_table :topics, id: false do |t|
      t.string :id, null: false, primary_key: true
      t.string :character_id, null: false
      t.string :title, null: false
      t.text :content

      t.timestamps
    end
    add_foreign_key :topics, :characters, column: :character_id, primary_key: :id, on_delete: :cascade
  end
end
