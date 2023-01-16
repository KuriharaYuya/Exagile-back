class AddAppointIdToTopic < ActiveRecord::Migration[7.0]
  def change
    add_column :topics, :appoint_id, :string, null: false
    add_foreign_key :topics, :appoints, column: :appoint_id, primary_key: :id, on_delete: :cascade
  end
end
