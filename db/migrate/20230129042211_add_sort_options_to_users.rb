class AddSortOptionsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :manipulate_options, :text
  end
end
