class CreateFaqTags < ActiveRecord::Migration[7.0]
  def change
    create_table :faq_tags, id: false do |t|
      t.string :id, null: false, primary_key: true
      t.string :user_id, null: false
      t.string :name, null: false
      t.timestamps
    end
    add_foreign_key :faq_tags, :users, column: :user_id, primary_key: :uid, on_delete: :cascade
  end
end
