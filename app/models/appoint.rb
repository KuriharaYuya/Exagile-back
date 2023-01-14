class Appoint < ApplicationRecord
  include TokenGeneratable

  belongs_to :user

  has_many :appoint_characters

  has_many :characters, through: :appoint_characters

  validates :title, :start, :end, presence: true

  scope :between_dates, ->(start_date, end_date) { where("start >= ? AND end <= ?", start_date, end_date) }
end
