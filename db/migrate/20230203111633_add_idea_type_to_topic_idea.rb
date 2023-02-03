class AddIdeaTypeToTopicIdea < ActiveRecord::Migration[7.0]
  def change
    add_column :topic_ideas, :idea_type, :string, null: false
  end
end
