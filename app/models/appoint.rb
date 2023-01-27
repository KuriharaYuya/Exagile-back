class Appoint < ApplicationRecord
  include TokenGeneratable

  belongs_to :user

  has_many :appoint_characters

  has_many :characters, through: :appoint_characters

  has_many :topics

  validates :title, :start, :end, presence: true
  scope :between_dates, ->(start_date, end_date) { where("start >= ? AND end <= ?", start_date, end_date) }

  has_many :inspired_faqs, class_name: "Faq", foreign_key: "inspired_appoint_id"
  has_many :applied_faqs, class_name: "Faq", foreign_key: "applied_appoint_id"
end
