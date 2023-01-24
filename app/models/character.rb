class Character < ApplicationRecord
  belongs_to :user

  has_many :appoint_characters

  has_many :appoints, through: :appoint_characters

  has_many :topics, dependent: :destroy
  include TokenGeneratable
  validates :name, length: { maximum: 20 }, presence: true
  has_many :characters_communities
  has_many :communities, through: :characters_communities, class_name: 'Community'
end
