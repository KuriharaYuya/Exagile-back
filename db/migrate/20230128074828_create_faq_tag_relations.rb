class CreateFaqTagRelations < ActiveRecord::Migration[7.0]
  def change
    create_table :faq_tag_relations do |t|
      t.string :faq_id, null: false
      t.string :faq_tag_id, null: false
      t.timestamps
    end
  end
end
