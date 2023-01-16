class CreateAppointCharacters < ActiveRecord::Migration[7.0]
  def change
    create_table :appoint_characters do |t|
      t.string :appoint_id
      t.string :character_id

      t.timestamps
    end
  end
end
