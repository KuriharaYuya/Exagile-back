class CreateTopicIdeas < ActiveRecord::Migration[7.0]
  def change
    create_table :topic_ideas, id: false do |t|
      t.string :id, null: false, primary_key: true
      t.string :appoint_id
      t.string :user_id, null: false
      t.string :character_id, null: false
      t.string :title, null: false
      t.string :content
      t.boolean :done, default: false
      t.timestamps
    end
    add_foreign_key :topic_ideas, :users, column: :user_id, primary_key: :uid
    add_foreign_key :topic_ideas, :characters, column: :character_id, primary_key: :id
  end
end
