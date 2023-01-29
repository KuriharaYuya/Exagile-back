class FaqTag < ApplicationRecord
  include TokenGeneratable
  belongs_to :user
  has_many :faq_tag_relations
  has_many :faqs, through: :faq_tag_relations
end
