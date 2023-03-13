require 'rails_helper'

RSpec.describe Api::V1::Appoints::AppointsController, type: :controller do
  describe "GET #show" do
    let!(:user1) { create(:user, name: "John Doe", email: "testmail@gmail,com", uid: "iamTestUser") }
    let(:appoint) { create(:appoint, title: "testTitle", content: "testContent", user_id: user1.id, end: DateTime.now + 1.hour) }

    before do
      allow(controller).to receive(:authenticate_user).and_return(true)
      allow(controller).to receive(:current_user).and_return(user1)
    end

    it "returns the correct appoint with appoint-id" do
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
    it "create new appoint" do
      post :create, params: { appoints: { title: "testTitle", content: "testContent", user_id: user1.id, end: DateTime.now + 1.hour } }
      # レスポンスがsuccesかどうか
      expect(response).to have_http_status(:success)
      # appointが作成されているかどうか
      # 作成したタイトルがレスポンスに含まれているかどうか
      expect(response.body).to include("testTitle")
    end

    it "update appoint" do
      content_txt = "updateContent"
      appoint.update(content: content_txt)
      put :update, params: { appoints: { id: appoint.id, content: content_txt }, id: appoint.id }
      # レスポンスがsuccesかどうか
      expect(response).to have_http_status(:success)
      # appointが更新されているかどうか
      expect(response.body).to include(content_txt)
    end
  end
end
