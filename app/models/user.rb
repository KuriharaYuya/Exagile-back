class User < ApplicationRecord
  has_many :appoints
  has_many :characters
  has_many :topics, through: :appoints
  has_many :communities
  has_many :faqs
  has_many :faq_tags
  has_many :faq_tag_relations
  has_many :insights
  serialize :manipulate_options, JSON
  after_initialize :set_manipulate_options
  has_many :topic_ideas

  private

  def set_manipulate_options
    self.manipulate_options ||= { faqs: { sort: { created_at: "desc", tags: "asc" }, filter: { tags: "" } }, insights: { sort: { reviewed_at: "asc"}, filter: {archived: false}}}
  end
end
