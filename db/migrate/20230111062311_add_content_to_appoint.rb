class AddContentToAppoint < ActiveRecord::Migration[7.0]
  def change
    add_column :appoints, :content, :text
  end
end
