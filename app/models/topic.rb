class Topic < ApplicationRecord
  include TokenGeneratable
  belongs_to :character
end
