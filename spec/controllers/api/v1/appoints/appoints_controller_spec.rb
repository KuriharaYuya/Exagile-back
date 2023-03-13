require 'rails_helper'

RSpec.describe Api::V1::Appoints::AppointsController, type: :controller do
  describe "GET #show" do
    let!(:user1) { create(:user, name: "John Doe", email: "testmail@gmail,com", id: "iamTestUser") }
    let(:appoint) { create(:appoint, title: "testTitle", content: "testContent", user_id: user1.id, end: DateTime.now + 1.hour) }

    it "returns the correct appoint" do
      get :show, params: { appoints: { id: appoint.id }, id: appoint.id }
      expect(response.body).to eq({
        appoints: {
          appoint:,
          faqs: {
            inspiredFaqs: appoint.inspired_faqs.sort_by(&:updated_at).reverse,
            appliedFaqs: appoint.applied_faqs.sort_by(&:updated_at).reverse
          },
          insight: appoint.insights.sort_by(&:created_at).reverse
        }
      }.to_json)
    end
  end
end
