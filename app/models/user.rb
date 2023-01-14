class User < ApplicationRecord
  has_many :appoints
  has_many :characters
end
