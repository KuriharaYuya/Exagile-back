class TopicIdea < ApplicationRecord
  include TokenGeneratable

  before_save :set_title_to_default, :done_with_binding_appoint

  belongs_to :appoint, optional: true
  belongs_to :user
  belongs_to :character

  validates :idea_type, inclusion: { in: %w[話題 行動] }

  private

  def set_title_to_default
    self.title = "Untitled" if title.nil? || title == ""
  end

  def done_with_binding_appoint
    self.done = true unless appoint_id.nil? && done
  end
end
