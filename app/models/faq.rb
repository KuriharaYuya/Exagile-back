class Faq < ApplicationRecord
  include TokenGeneratable
  validates :name, presence: true
  validates :user_id, presence: true
  belongs_to :inspired_appoint, class_name: 'Appoint', foreign_key: :inspired_appoint_id, optional: true
  belongs_to :applied_appoint, class_name: 'Appoint', foreign_key: :applied_appoint_id, optional: true
  belongs_to :user
  has_many :faq_tag_relations
  has_many :faq_tags, through: :faq_tag_relations
end
