class Insight < ApplicationRecord
  include TokenGeneratable
  before_save :set_review_at

  belongs_to :appoint
  belongs_to :user

  private

  def set_review_at
    self.review_at = Time.now if review_at.nil?
  end
end
