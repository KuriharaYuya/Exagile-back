class Insight < ApplicationRecord
  include TokenGeneratable
  before_save :set_reviewed_at

  belongs_to :appoint
  belongs_to :user

  private

  def set_reviewed_at
    self.reviewed_at = Time.now if reviewed_at.nil?
  end
end
