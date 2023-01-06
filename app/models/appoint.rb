class Appoint < ApplicationRecord
  before_create :generate_token

  belongs_to :user

  validates :title, :start, :end, :start_js, :end_js, presence: true

  private

  def generate_token
    self.id = loop do
      random_token = SecureRandom.uuid
      break random_token unless self.class.exists?(id: random_token)
    end
  end
end
