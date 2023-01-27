class User < ApplicationRecord
  has_many :appoints
  has_many :characters
  has_many :topics, through: :appoints
  has_many :communities
  has_many :faqs
end
