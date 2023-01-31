class AddRetentionLevelReviewAtAndReviewCountToInsights < ActiveRecord::Migration[7.0]
  def change
    add_column :insights, :reviewed_at, :datetime
    add_column :insights, :concerning, :boolean, default: false
  end
end
