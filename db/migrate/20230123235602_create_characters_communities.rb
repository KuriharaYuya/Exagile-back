class CreateCharactersCommunities < ActiveRecord::Migration[7.0]
  def change
    create_table :characters_communities do |t|
      t.string :character_id, null: false
      t.string :community_id, null: false
      t.timestamps
    end
  end
end
