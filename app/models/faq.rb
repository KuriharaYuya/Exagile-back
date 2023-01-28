class Faq < ApplicationRecord
  include TokenGeneratable
  validates :name, presence: true
  validates :user_id, presence: true
  belongs_to :inspired_appoint, class_name: 'Appoint', foreign_key: :inspired_appoint_id, optional: true
  belongs_to :applied_appoint, class_name: 'Appoint', foreign_key: :applied_appoint_id, optional: true
  belongs_to :user
end
