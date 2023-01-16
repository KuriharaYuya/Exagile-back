class Topic < ApplicationRecord
  include TokenGeneratable
  belongs_to :character
  belongs_to :appoint
  scope :bound_topics, ->(appoint_id, character_id) { where(appoint_id:, character_id:).order("updated_at DESC") }
end
