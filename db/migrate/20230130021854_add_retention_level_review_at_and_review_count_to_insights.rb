class AddRetentionLevelReviewAtAndReviewCountToInsights < ActiveRecord::Migration[7.0]
  def change
    add_column :insights, :retention_level, :integer, limit: 1, default: 1, null: false
    add_column :insights, :review_at, :datetime
    add_column :insights, :review_count, :integer, default: 0
  end
end
