class CreateFaqs < ActiveRecord::Migration[7.0]
  def change
    create_table :faqs, id: false do |t|
      t.string :id, null: false, primary_key: true
      t.string :name
      t.text :content
      t.string :user_id
      t.string :appoint_id
      t.boolean :inspired, default: false
      t.boolean :applied, default: false

      t.timestamps
    end
    add_foreign_key :faqs, :users, column: :user_id, primary_key: :uid, on_delete: :cascade
    add_foreign_key :faqs, :appoints, column: :appoint_id, primary_key: :id, on_delete: :cascade
  end
end
