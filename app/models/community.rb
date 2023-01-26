class Community < ApplicationRecord
  include TokenGeneratable
  validates :name, length: { maximum: 20 }, presence: true
  has_many :characters_communities, dependent: :destroy
  has_many :characters, through: :characters_communities
  belongs_to :user
end
