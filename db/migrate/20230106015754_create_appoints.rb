class CreateAppoints < ActiveRecord::Migration[7.0]
  def change
    create_table :appoints, id: false do |t|
      t.string :id, null: false, primary_key: true
      t.string :user_id, null: false
      t.string :title
      t.string :desc
      t.datetime :start
      t.datetime :end
      t.string :start_js
      t.string :end_js

      t.index :start
      t.index :end

      t.timestamps
    end

    add_foreign_key :appoints, :users, column: :user_id, primary_key: :uid
  end
end
