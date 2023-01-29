class FaqTagRelation < ApplicationRecord
  belongs_to :faq_tag
  belongs_to :faq
end
