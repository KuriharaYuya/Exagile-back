class Faq < ApplicationRecord
  include TokenGeneratable
  validates :name, presence: true
  validates :user_id, presence: true
  validate :inspired_or_applied
  belongs_to :inspired_appoint, class_name: 'Appoint', foreign_key: :inspired_appoint_id, optional: true
  belongs_to :applied_appoint, class_name: 'Appoint', foreign_key: :applied_appoint_id, optional: true
  belongs_to :user

  private

  def inspired_or_applied
    errors.add(:base, "inspired or applied must be true") if !inspired_appoint_id && !applied_appoint_id
  end
end
