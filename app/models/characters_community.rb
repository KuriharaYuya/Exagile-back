class CharactersCommunity < ApplicationRecord
  belongs_to :character
  belongs_to :community
end
