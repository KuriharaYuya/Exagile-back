class Appoint < ApplicationRecord
  before_create :generate_token

  belongs_to :user

  validates :title, :start, :end, presence: true

  scope :between_dates, ->(start_date, end_date) { where("start >= ? AND end <= ?", start_date, end_date) }

  private

  def generate_token
    self.id = loop do
      random_token = SecureRandom.uuid
      break random_token unless self.class.exists?(id: random_token)
    end
  end
end
